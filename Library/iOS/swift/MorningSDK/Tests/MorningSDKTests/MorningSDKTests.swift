import XCTest
@testable import MobileShield

final class MorningSDKTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MobileShield().text, "Hello, World!")
    }
    static var allTests = [
	("testExample", testExample),
    ]
}
