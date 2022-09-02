import XCTest
@testable import D2LKit

final class D2LKitTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(D2LKit().text, "Hello, World!")
    }
    
    func testCreateHMAC() {
        print(D2LManager.createHMAC(key: "OextryfmALGx0PbknzAbdg", data: "http://pulse.brightspace.com/android/trustedURL"))
        
        if #available(macOS 13.0, *) {
            print(try? D2LManager.buildLoginURL(appID: "MCHLKRukvOZMCV1hchcsgg", appKey: "OextryfmALGx0PbknzAbdg", callbackURL: .init(string: "http://pulse.brightspace.com/android/trustedURL")!).absoluteString)
        } else {
            // Fallback on earlier versions
        }
    }
}
