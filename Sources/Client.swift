import MirrorCoreSDK.EMSConfig

@objc
public class MirrorClient: NSObject, ConnectivityObserver {

    @objc
  public override init() {
        super.init()
        connectivityService.registerObserver(self)
    }
  
    /**
       Initialize with an appID and appToken from your Estimote Cloud App for authorization.
   
       - parameters:
         - appID: The Estimote Cloud App ID. Can not be empty.
         - appToken: The Estimote Cloud App Token. Can not be empty.
   
       - returns:
       A newly created MirrorClient.
     */
    @objc
    public convenience init(appID: String, appToken: String) {
        self.init()
        EMSConfig.setupAppID(appID, andAppToken: appToken)
    }

    @objc
    public func display(_ view: View, inProximity proximity: ProximityOptions) {
        // default params don't export to ObjC, so we do it this way
        display(view, inProximity: proximity, id: UUID().uuidString)
    }

    @objc
    public func display(_ view: View, inProximity proximity: ProximityOptions, id: String) {
        display(view, predicate: ProximityPredicate(proximity), id: id)
    }

    @objc
    public func cancelDisplay(id: String) {
        displayRequests[id] = nil
    }

    @objc
    public func cancelAllDisplays() {
        displayRequests.removeAll()
    }

    // MARK: Implementation

    private func display(_ view: View, predicate: Predicate, id: String = UUID().uuidString) {
        displayRequests[id] = DisplayRequest(id: id, predicate: predicate, view: view)
    }

    private let connectivityService = ConnectivityService.sharedInstance

    private var proximityCalculators = [String: ProximityCalculator]()

    private var displayRequests = [String: DisplayRequest]()

    private var previousPredicateResults = [String: Bool]()

    private func evaluatePredicates(mirrorIdentifier: String, proximity: Proximity?) {
        var toShow = [DisplayRequest]()
        var toRemove = [DisplayRequest]()

        for displayRequest in displayRequests.values {
            let prevPredicateResult = previousPredicateResults[displayRequest.id]
            let currPredicateResult = displayRequest.predicate.eval(proximity: proximity)

            if prevPredicateResult == false && currPredicateResult == true {
                toShow.append(displayRequest)
            } else if prevPredicateResult == true && currPredicateResult == false {
                toRemove.append(displayRequest)
            }

            previousPredicateResults[displayRequest.id] = currPredicateResult
        }

        var actions = [[String: Any]]()
        for displayRequest in toShow {
            actions.append([
                "showView": [
                    "id": displayRequest.id,
                    "type": displayRequest.view.typeName,
                    "data": displayRequest.view.dataDict]
                ])
        }
        for displayRequest in toRemove {
            actions.append([
                "removeView": [
                    "id": displayRequest.id]
                ])
        }
        if !actions.isEmpty {
            connectivityService.send([
                "template": "estimote/__built-in_views",
                "actions": actions
                ], to: mirrorIdentifier)
        }
    }

    // MARK: ConnectivityObserver

    func onFoundMirror(mirrorIdentifier: String) {
        proximityCalculators[mirrorIdentifier] = HysteresisProximityCalculator()

        evaluatePredicates(mirrorIdentifier: mirrorIdentifier, proximity: nil)
    }

    func onRSSIUpdate(mirrorIdentifier: String, rssi: Double) {
        guard let calc = proximityCalculators[mirrorIdentifier] else {
            assertionFailure("Expected to have a proximity calculator for Mirror with identifier = \(mirrorIdentifier), but we don't. It should've been initialized in onFoundMirror, possibly something wrong there?")
            return
        }

        let proximity = calc.calculateProximity(rssi: rssi)

        evaluatePredicates(mirrorIdentifier: mirrorIdentifier, proximity: proximity)
    }

    func onLostMirror(mirrorIdentifier: String) {
        proximityCalculators[mirrorIdentifier] = nil

    }

}



protocol Predicate {

    func eval(proximity: Proximity?) -> Bool

}

struct ProximityPredicate: Predicate {

    let matchingOptions: ProximityOptions

    init(_ proximity: ProximityOptions) {
        self.matchingOptions = proximity
    }

    func eval(proximity: Proximity?) -> Bool {
        if matchingOptions == .any {
            return true
        }

        if let proximity = proximity {
            return matchingOptions.contains(ProximityOptions(rawValue: proximity.rawValue))
        }

        return false
    }

}

struct DisplayRequest {

    let id: String
    let predicate: Predicate
    let view: View

}
