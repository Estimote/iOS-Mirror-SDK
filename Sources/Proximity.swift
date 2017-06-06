@objc
public enum Proximity: UInt8 {

    case near = 0b001
    case mid  = 0b010
    case far  = 0b100

}



protocol ProximityCalculator {

    func calculateProximity(rssi: Double) -> Proximity

}



struct ProximityThresholds {

    static let `default` = ProximityThresholds(near: -85, mid: -90)

    let near: Double
    let mid: Double

    // interpret this as: mid proximity starts at mid, and near starts at near
    //
    // i.e.:
    //
    //     .far < thresholds.mid <= mid < thresholds.near <= near

    init(near: Double, mid: Double) {
        self.near = near
        self.mid = mid
    }

    func shiftedBy(offset: Double) -> ProximityThresholds {
        return ProximityThresholds(near: near + offset, mid: mid + offset)
    }

}



struct NaiveProximityCalculator: ProximityCalculator {

    let thresholds: ProximityThresholds

    init(thresholds: ProximityThresholds = ProximityThresholds.default) {
        self.thresholds = thresholds
    }

    func calculateProximity(rssi: Double) -> Proximity {
        if rssi >= thresholds.near {
            return .near
        } else if rssi >= thresholds.mid {
            return .mid
        } else {
            return .far
        }
    }

}



class HysteresisProximityCalculator: ProximityCalculator {

    let hysteresis: UInt8
    let thresholds: ProximityThresholds

    init(hysteresis: UInt8 = 5, thresholds: ProximityThresholds = ProximityThresholds.default) {
        self.hysteresis = hysteresis
        self.thresholds = thresholds

        let hysteresisOffset = Double(hysteresis) / 2.0

        naiveCalc = NaiveProximityCalculator(thresholds: thresholds)
        risingEdgeCalc = NaiveProximityCalculator(thresholds: thresholds.shiftedBy(offset: hysteresisOffset))
        fallingEdgeCalc = NaiveProximityCalculator(thresholds: thresholds.shiftedBy(offset: -hysteresisOffset))
    }

    func calculateProximity(rssi: Double) -> Proximity {
        if let lastAccepted = lastAccepted {
            let calc: NaiveProximityCalculator = rssi >= lastAccepted.rssi ? risingEdgeCalc : fallingEdgeCalc
            let candidateProximity = calc.calculateProximity(rssi: rssi)

            // was it enough to breach into a new proximity?
            if candidateProximity != lastAccepted.proximity {
                // yes! accept it
                self.lastAccepted = (rssi, candidateProximity)
            }
        } else {
            // no data about previous proximity, so let's immediately accept this one
            let initialProximity = naiveCalc.calculateProximity(rssi: rssi)
            lastAccepted = (rssi, initialProximity)
        }

        return lastAccepted!.proximity
    }

    private let naiveCalc: NaiveProximityCalculator
    private let risingEdgeCalc: NaiveProximityCalculator
    private let fallingEdgeCalc: NaiveProximityCalculator

    private var lastAccepted: (rssi: Double, proximity: Proximity)?

}
