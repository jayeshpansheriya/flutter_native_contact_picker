import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_native_contact_picker_platform_interface.dart';

/// An implementation of [FlutterNativeContactPickerPlatform] that uses method channels.
class MethodChannelFlutterNativeContactPicker extends FlutterNativeContactPickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_native_contact_picker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
