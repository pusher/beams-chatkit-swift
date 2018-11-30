import XCTest
@testable import BeamsChatkit

class DeviceTests: XCTestCase {
    func testPersist() {
        Device.persist("abcd")
        let deviceId = Device.getDeviceId()

        XCTAssertNotNil(deviceId)
        XCTAssert("abcd" == deviceId)
    }
}
