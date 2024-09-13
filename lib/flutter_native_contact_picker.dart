
import 'package:flutter_native_contact_picker/model/contact.dart';

import 'flutter_native_contact_picker_platform_interface.dart';

class FlutterNativeContactPicker {
  Future<Contact?> selectContact() {
    return FlutterNativeContactPickerPlatform.instance.selectContact();
  }

  Future<List<Contact>?> selectContacts() {
    return FlutterNativeContactPickerPlatform.instance.selectContacts();
  }
}
