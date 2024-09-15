import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_native_contact_picker_method_channel.dart';

abstract class FlutterNativeContactPickerPlatform extends PlatformInterface {
  /// Constructs a FlutterNativeContactPickerPlatform.
  FlutterNativeContactPickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterNativeContactPickerPlatform _instance =
      MethodChannelFlutterNativeContactPicker();

  /// The default instance of [FlutterNativeContactPickerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterNativeContactPicker].
  static FlutterNativeContactPickerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterNativeContactPickerPlatform] when
  /// they register themselves.
  static set instance(FlutterNativeContactPickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Contact?> selectContact() {
    throw UnimplementedError('selectContact() has not been implemented.');
  }

  Future<List<Contact>?> selectContacts() {
    throw UnimplementedError('selectContacts() has not been implemented.');
  }
}
