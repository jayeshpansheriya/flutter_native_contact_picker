import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker_platform_interface.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockFlutterNativeContactPickerPlatform
//     with MockPlatformInterfaceMixin
//     implements FlutterNativeContactPickerPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

void main() {
  final FlutterNativeContactPickerPlatform initialPlatform =
      FlutterNativeContactPickerPlatform.instance;

  test('$MethodChannelFlutterNativeContactPicker is the default instance', () {
    expect(initialPlatform,
        isInstanceOf<MethodChannelFlutterNativeContactPicker>());
  });

  // test('getPlatformVersion', () async {
  //   FlutterNativeContactPicker flutterNativeContactPickerPlugin =
  //       FlutterNativeContactPicker();
  //   MockFlutterNativeContactPickerPlatform fakePlatform =
  //       MockFlutterNativeContactPickerPlatform();
  //   FlutterNativeContactPickerPlatform.instance = fakePlatform;

  //   // expect(await flutterNativeContactPickerPlugin.getPlatformVersion(), '42');
  // });
}
