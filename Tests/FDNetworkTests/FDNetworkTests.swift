import XCTest
@testable import FDNetwork

final class FDNetworkTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FDNetwork.getVersion(), "1.0")
    }
}
