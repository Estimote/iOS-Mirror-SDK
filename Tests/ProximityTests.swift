import XCTest

@testable import MirrorDisplay

class ProximityTests: XCTestCase {

    func testProximityOptions() {
        // sanity checks (laugh all you want, but forget to override isEqual on an NSObject-based ProximityOptions, and you end up with these failing)
        XCTAssertEqual(ProximityOptions.near, ProximityOptions.near)
        XCTAssertTrue(ProximityOptions.near.contains(.near))

        // .any should be the same as [.near, .mid, .far]
        let allProximities: ProximityOptions = [.near, .mid, .far]
        XCTAssertEqual(allProximities, .any)


        // the rest is ProximityOptions <=> Proximity interoperability, rawValues should match

        let convert = { (proximity: Proximity) -> ProximityOptions in
            return ProximityOptions(rawValue: proximity.rawValue)
        }

        XCTAssertTrue(ProximityOptions.any.contains(convert(Proximity.near)))
        XCTAssertTrue(ProximityOptions.any.contains(convert(Proximity.mid)))
        XCTAssertTrue(ProximityOptions.any.contains(convert(Proximity.far)))

        XCTAssertTrue(ProximityOptions.near.contains(convert(Proximity.near)))
        XCTAssertFalse(ProximityOptions.near.contains(convert(Proximity.mid)))
        XCTAssertFalse(ProximityOptions.near.contains(convert(Proximity.far)))

        XCTAssertFalse(ProximityOptions.mid.contains(convert(Proximity.near)))
        XCTAssertTrue(ProximityOptions.mid.contains(convert(Proximity.mid)))
        XCTAssertFalse(ProximityOptions.mid.contains(convert(Proximity.far)))

        XCTAssertFalse(ProximityOptions.far.contains(convert(Proximity.near)))
        XCTAssertFalse(ProximityOptions.far.contains(convert(Proximity.mid)))
        XCTAssertTrue(ProximityOptions.far.contains(convert(Proximity.far)))
    }

    func testHysteresisCalculator() {
        let calc = HysteresisProximityCalculator(hysteresis: 10, thresholds: ProximityThresholds(near: -60, mid: -80))

        // let's try to simulate a real series of events
        //
        // but let's also make sure we test all the possibilities, there should be 6 of them:
        //
        //   1. far => mid
        //   2. far => near
        //   3. mid => far
        //   4. mid => near
        //   5. near => mid
        //   6. near => far

        // first call immediately kicks it off
        XCTAssertEqual(calc.calculateProximity(rssi: -79), .mid)

        // then, small fluctuations don't change the proximity
        // also, an interesting edge case: the edge fluctuates between rising and falling here, but this shouldn't affect the result
        XCTAssertEqual(calc.calculateProximity(rssi: -82), .mid)
        XCTAssertEqual(calc.calculateProximity(rssi: -82), .mid)
        XCTAssertEqual(calc.calculateProximity(rssi: -81), .mid)
        XCTAssertEqual(calc.calculateProximity(rssi: -83), .mid)
        XCTAssertEqual(calc.calculateProximity(rssi: -83), .mid)

        // but if we fall below the hysteresis threshold, proximity changes
        // [tests #3 mid => far]
        XCTAssertEqual(calc.calculateProximity(rssi: -86), .far)

        // this is still not enough to kick into .mid
        XCTAssertEqual(calc.calculateProximity(rssi: -79), .far)

        // but this is
        // [tests #1 far => mid]
        XCTAssertEqual(calc.calculateProximity(rssi: -74), .mid)

        // another possibly interesting edge case
        // going from .far, -59 is not enough to trigger .near, BUT, it SHOULD immediately trigger .mid
        XCTAssertEqual(calc.calculateProximity(rssi: -90), .far)
        XCTAssertEqual(calc.calculateProximity(rssi: -59), .mid)

        // and this should finally trigger .near
        // [tests #4 mid => near]
        XCTAssertEqual(calc.calculateProximity(rssi: -54), .near)

        // remaining cases:

        // [tests #5 near => mid]
        XCTAssertEqual(calc.calculateProximity(rssi: -66), .mid)

        // [tests #6 near => far]
        XCTAssertEqual(calc.calculateProximity(rssi: -54), .near)
        XCTAssertEqual(calc.calculateProximity(rssi: -86), .far)

        // [tests #2 far => near]
        XCTAssertEqual(calc.calculateProximity(rssi: -53), .near)
    }

}
