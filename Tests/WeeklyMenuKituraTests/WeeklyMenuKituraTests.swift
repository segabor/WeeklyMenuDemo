import XCTest
@testable import WeeklyMenuKitura

class WeeklyMenuKituraTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(WeeklyMenuKitura().text, "Hello, World!")
    }


    static var allTests : [(String, (WeeklyMenuKituraTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
