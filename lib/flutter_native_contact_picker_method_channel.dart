import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';

import 'flutter_native_contact_picker_platform_interface.dart';

/// An implementation of [FlutterNativeContactPickerPlatform] that uses method channels.
class MethodChannelFlutterNativeContactPicker
    extends FlutterNativeContactPickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_native_contact_picker');

  @override
  Future<Contact?> selectContact() async {
    final Map<dynamic, dynamic>? result = await methodChannel
        .invokeMethod<Map<dynamic, dynamic>?>('selectContact');
    if (result == null) {
      return null;
    }
    return Contact.fromMap(result);
  }

  @override
  Future<List<Contact>?> selectContacts() async {
    if (!Platform.isIOS) throw UnimplementedError();

    final List<dynamic>? result =
        await methodChannel.invokeMethod<List<dynamic>?>('selectContacts');
    if (result == null) {
      return null;
    }
    return result.map((e) => Contact.fromMap(e)).toList();
  }
}
