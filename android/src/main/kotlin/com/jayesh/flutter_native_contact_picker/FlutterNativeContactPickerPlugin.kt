package com.jayesh.flutter_native_contact_picker

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.app.Activity
import android.app.Activity.RESULT_OK
import android.content.Intent
import android.provider.ContactsContract
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import java.util.*

/** FlutterContactPickerPlugin */
public class FlutterNativeContactPickerPlugin: FlutterPlugin, MethodCallHandler,
  ActivityAware, PluginRegistry.ActivityResultListener{
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private var pendingResult: Result? = null
  private  val PICK_CONTACT = 2015
  private var selectPhoneNumber: Boolean = false

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_native_contact_picker")
    channel.setMethodCallHandler(this);
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.


  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "selectContact", "selectPhoneNumber" -> {
        if (pendingResult != null) {
          pendingResult!!.error("multiple_requests", "Cancelled by a second request.", null)
          pendingResult = null
        }
        pendingResult = result
        selectPhoneNumber = call.method == "selectPhoneNumber"

        try {
          val intent = Intent(Intent.ACTION_PICK).apply {
            type = ContactsContract.CommonDataKinds.Phone.CONTENT_TYPE
          }
          activity?.startActivityForResult(intent, PICK_CONTACT)
        } catch (e: Exception) {
          pendingResult?.error("intent_error", "Could not launch contact picker", null)
          pendingResult = null
        }
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(@NonNull binding: ActivityPluginBinding) {
    this.activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    this.activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    this.activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivity() {
    this.activity = null
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    if (requestCode != PICK_CONTACT) {
      return false
    }
    if (resultCode != RESULT_OK || data?.data == null) {
      pendingResult?.success(null)
      pendingResult = null
      return true
    }

    try {
      val contactUri = data.data!!
      activity?.contentResolver?.query(
        contactUri,
        arrayOf(
          ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME,
          ContactsContract.CommonDataKinds.Phone.NUMBER
        ),
        null,
        null,
        null
      )?.use { cursor ->
        if (cursor.moveToFirst()) {
          val nameIndex = cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME)
          val numberIndex = cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER)

          if (nameIndex == -1 || numberIndex == -1) {
            pendingResult?.error("invalid_cursor", "Could not find required columns in contact data", null)
            pendingResult = null
            return true
          }

          val fullName = cursor.getString(nameIndex) ?: ""
          val number = cursor.getString(numberIndex) ?: ""

          val contact = HashMap<String, Any>()
          contact["fullName"] = fullName
          contact["phoneNumbers"] = listOf(number)
          if (selectPhoneNumber) {
            contact["selectedPhoneNumber"] = number
          }

          pendingResult?.success(contact)
          pendingResult = null
          return true
        }
      }

      pendingResult?.error("no_contact", "Could not read contact data", null)
      pendingResult = null
      return true
    } catch (e: Exception) {
      pendingResult?.error("contact_picker_error", e.message, null)
      pendingResult = null
      return true
    }
  }

  companion object {

    private const val PICK_CONTACT = 2015

//    @JvmStatic
//    fun registerWith(registrar: Registrar) {
//      val channel = MethodChannel(registrar.messenger(), "contact_picker")
//      channel.setMethodCallHandler(ContactpickerPlugin(registrar, channel))
//    }
  }
}