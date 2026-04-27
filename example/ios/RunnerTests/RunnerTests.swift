import Flutter
import UIKit
import XCTest

@testable import flutter_native_contact_picker

class RunnerTests: XCTestCase {

  func testPluginCanBeInstantiated() {
    let plugin = FlutterNativeContactPickerPlugin()
    XCTAssertNotNil(plugin)
  }

  func testUnknownMethodReturnsNotImplemented() {
    let plugin = FlutterNativeContactPickerPlugin()
    let call = FlutterMethodCall(methodName: "unknownMethod", arguments: nil)
    let resultExpectation = expectation(description: "result block must be called.")
    plugin.handle(call) { result in
      XCTAssertTrue(result as AnyObject? === FlutterMethodNotImplemented as AnyObject?)
      resultExpectation.fulfill()
    }
    waitForExpectations(timeout: 1)
  }
}
