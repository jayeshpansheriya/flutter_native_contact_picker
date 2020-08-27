#import "FlutterContactPickerPlugin.h"
#if __has_include(<flutter_contact_picker/flutter_contact_picker-Swift.h>)
#import <flutter_contact_picker/flutter_contact_picker-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_contact_picker-Swift.h"
#endif

@implementation FlutterContactPickerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterContactPickerPlugin registerWithRegistrar:registrar];
}
@end
