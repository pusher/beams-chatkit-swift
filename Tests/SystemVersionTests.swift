import XCTest
@testable import BeamsChatkit

class SystemVersionTests: XCTestCase {
    func testSystemVersion() {
        XCTAssertNotNil(SystemVersion.version)
    }
}
