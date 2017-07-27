import MirrorCoreSDK

protocol ConnectivityObserver: class {

    func onFoundMirror(mirrorIdentifier: String)

    func onRSSIUpdate(mirrorIdentifier: String, rssi: Double)

    func onLostMirror(mirrorIdentifier: String)

}

fileprivate class WeakConnectivityObserver {

    // h/t http://stackoverflow.com/a/24128121/1900855

    private(set) weak var value: ConnectivityObserver?

    init(_ value: ConnectivityObserver) {
        self.value = value
    }
    
}

class ConnectivityService: NSObject, EMSDeviceManagerDelegate, EMSDeviceConnectableDelegate {

    static let sharedInstance = ConnectivityService()

    func registerObserver(_ observer: ConnectivityObserver) {
        observers.append(WeakConnectivityObserver(observer))
    }

    func send(_ data: Dictionary<String, Any>, to mirrorIdentifier: String) {
        if let mirror = connectedMirrors.first(where: { $0.identifier == mirrorIdentifier }) {
            NSLog("[ConnectivityService] attempting to send data = \(data) to Mirror with identifier = \(mirrorIdentifier)")

            mirror.display(data) { error in
                if let error = error {
                    NSLog("[ConnectivityService] failed to send data = \(data) to Mirror with identifier = \(mirrorIdentifier), error = \(error)")
                } else {
                    NSLog("[ConnectivityService] sent data = \(data) to Mirror with identififer = \(mirrorIdentifier)")
                }
            }
        } else {
            NSLog("[ConnectivityService] was asked to send data = \(data) to Mirror with identifier = \(mirrorIdentifier), but we're not currently connected to such Mirror ... so, uhm, ignoring the request")
        }
    }

    // MARK: Implementation

    private var observers = [WeakConnectivityObserver]()

    private let mirrorDeviceManager = EMSDeviceManager()

    private var connectedMirrors = Set<EMSDeviceMirror>()

    private override init() {
        super.init()

        mirrorDeviceManager.delegate = self
        // TODO: only scan if there's non-zero observers
        mirrorDeviceManager.startDeviceDiscovery(with: EMSDeviceFilterMirror())
    }

    // MARK: EMSDeviceManagerDelegate

    func deviceManager(_ manager: EMSDeviceManager, didDiscoverDevices devices: [Any]) {
        let discoveredMirrors = Set(devices as! [EMSDeviceMirror]) // we trust the EMSDeviceFilterMirror to only give us EMSDeviceMirror objects

        let newMirrors = discoveredMirrors.subtracting(connectedMirrors)

        NSLog("[ConnectivityService] discovered \(discoveredMirrors.count) Mirror(s) nearby, \(newMirrors.count) of them are pending connection")

        for mirror in newMirrors {
            NSLog("[ConnectivityService] attempting connection to Mirror with identifier = \(mirror.identifier)")

            connectedMirrors.insert(mirror)

            mirror.delegate = self
            mirror.connect()
        }
    }

    func deviceManagerDidFailDiscovery(_ manager: EMSDeviceManager) {
        NSLog("[ConnectivityService] scanning for Mirrors failed")
    }

    // MARK: EMSDeviceConnectableDelegate

    func emsDeviceConnectionDidSucceed(_ device: EMSDeviceConnectable) {
        NSLog("[ConnectivityService] connected to Mirror with identifier = \(device.identifier)")

        for observer in observers {
            observer.value?.onFoundMirror(mirrorIdentifier: device.identifier)
        }
    }

    func emsDevice(_ device: EMSDeviceConnectable, didUpdateRSSI rssi: NSNumber, withError error: Error?) {
        NSLog("[ConnectivityService] RSSI update for Mirror with identifier = \(device.identifier), RSSI = \(rssi), error = \(error != nil ? String(describing: error!) : "(no error)")")

        if (error != nil) { return }

        for observer in observers {
            observer.value?.onRSSIUpdate(mirrorIdentifier: device.identifier, rssi: rssi.doubleValue)
        }
    }

    func emsDevice(_ device: EMSDeviceConnectable, didFailConnectionWithError error: Error) {
        NSLog("[ConnectivityService] failed connecting to Mirror with identifier = \(device.identifier), error = \(error)")

        connectedMirrors.remove(device as! EMSDeviceMirror)
    }

    func emsDevice(_ device: EMSDeviceConnectable, didDisconnectWithError error: Error?) {
        NSLog("[ConnectivityService] disconnected from Mirror with identifier = \(device.identifier), error = \(error != nil ? String(describing: error!) : "(no error)")")

        connectedMirrors.remove(device as! EMSDeviceMirror)

        for observer in observers {
            observer.value?.onLostMirror(mirrorIdentifier: device.identifier)
        }
    }

}
