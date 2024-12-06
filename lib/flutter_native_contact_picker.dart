import 'package:flutter_native_contact_picker/model/contact.dart';

import 'flutter_native_contact_picker_platform_interface.dart';

class FlutterNativeContactPicker {
  /// Selects a single contact and returns their information.
  Future<Contact?> selectContact() {
    return FlutterNativeContactPickerPlatform.instance.selectContact();
  }

  /// Selects multiple contacts and returns their information.
  /// Note: This is only supported on iOS.
  Future<List<Contact>?> selectContacts() {
    return FlutterNativeContactPickerPlatform.instance.selectContacts();
  }

  /// Selects a specific phone number from a contact.
  /// Returns the contact information along with the selected phone number.
  Future<Contact?> selectPhoneNumber() {
    return FlutterNativeContactPickerPlatform.instance.selectPhoneNumber();
  }
}
