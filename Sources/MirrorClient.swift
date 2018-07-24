import MirrorCoreSDK

@objc
public class MirrorClient: NSObject {
    
    fileprivate let mirrorDeviceManager = EMSDeviceManager()
    fileprivate var connectedMirrors = Set<EMSDeviceMirror>()
    fileprivate var displayRequests = Dictionary<String,DisplayRequest>()

    @objc
    public convenience init(appID: String, appToken: String) {
        self.init()
        
        EMSConfig.setupAppID(appID, andAppToken: appToken)
        mirrorDeviceManager.delegate = self
    }
    
    @objc (displayView:onMirrorWithIdentifier:)
    public func display(_ view: View, onMirror identifier:String) {
        
        let displayRequest = DisplayRequest(mirrorIdentifier: identifier, view: view)
        self.display(displayRequest, onMirror: identifier)
    }
    
    @objc (displayDictionary:onMirrorWithIdentifier:)
    public func display(_ dictionary:Dictionary<String,Any>, onMirror identifier:String) {
        
        let displayRequest = DisplayRequest(mirrorIdentifier: identifier, dictionary: dictionary)
        self.display(displayRequest, onMirror: identifier)
    }
    
    fileprivate func display(_ displayRequest:DisplayRequest, onMirror identifier:String) {
        
        self.displayRequests[identifier] = displayRequest
        self.executeDisplayRequests()
        self.startScan(basedOn: self.displayRequests.map({return $0.value}))
    }
    
    fileprivate func startScan(basedOn displayRequests:[DisplayRequest]) {
       
        let mirrorIdentifiers = displayRequests.map({return $0.mirrorIdentifier})
        self.startScan(for: mirrorIdentifiers)
    }
    
    fileprivate func startScan(for identifiers:[String]) {
       
        self.mirrorDeviceManager.startDeviceDiscovery(with: EMSDeviceFilterMirror(identifierArray: identifiers))
    }
    
    fileprivate func executeDisplayRequests() {
      
        for mirror in self.connectedMirrors {
            if let displayRequest = self.displayRequests[mirror.identifier] {
                
                mirror.display(displayRequest.dictionary) { (error) in
                    self.executedDisplayRequest(onMirror: mirror.identifier, error: error)
                }
            }
        }
    }
    
    fileprivate func executedDisplayRequest(onMirror identifier:String, error:Error?) {
        if let completion = self.displayRequests[identifier]?.completionBlock {
            completion(error)
        }
        self.displayRequests.removeValue(forKey: identifier)
    }
}

extension MirrorClient: EMSDeviceManagerDelegate {
    
    public func deviceManager(_ manager: EMSDeviceManager, didDiscoverDevices devices: [Any]) {
        
        for mirror in devices as! [EMSDeviceMirror] {
            if !self.connectedMirrors.contains(mirror) {
                mirror.delegate = self
                mirror.connect()
            }
        }
    }
    
    public func deviceManagerDidFailDiscovery(_ manager: EMSDeviceManager) {
               
    }
}

extension MirrorClient: EMSDeviceConnectableDelegate {
    
    public func emsDeviceConnectionDidSucceed(_ device: EMSDeviceConnectable) {
        
        guard let mirror = device as? EMSDeviceMirror else {
            print("Something went wrong! Connected to device that is not Estimote Mirror.")
            device.disconnect()
            return
        }
        
        self.connectedMirrors.insert(mirror)
        self.executeDisplayRequests()
    }
    
    public func emsDevice(_ device: EMSDeviceConnectable, didFailConnectionWithError error: Error) {
        
        guard let mirror = device as? EMSDeviceMirror else {
            print("Something went wrong! App tried to establish connection with a device that was not an Estimote Mirror.")
            return
        }
        
        self.executedDisplayRequest(onMirror: mirror.identifier, error: error)
    }
}
