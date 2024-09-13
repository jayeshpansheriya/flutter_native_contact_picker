
import 'flutter_native_contact_picker_platform_interface.dart';

class FlutterNativeContactPicker {
  Future<String?> getPlatformVersion() {
    return FlutterNativeContactPickerPlatform.instance.getPlatformVersion();
  }
}
