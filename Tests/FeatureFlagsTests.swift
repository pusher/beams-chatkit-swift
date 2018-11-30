import XCTest
@testable import BeamsChatkit

class FeatureFlagsTests: XCTestCase {
    func testFeatureFlagDeliveryTrackingEnabledIsSetToTrue() {
        XCTAssertEqual(FeatureFlags.DeliveryTrackingEnabled, true)
    }
}
