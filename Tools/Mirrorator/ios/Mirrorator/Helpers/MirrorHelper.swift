//
//  MirrorHelper.swift
//  Mirrorator
//
//  Created by Mac Book on 31/07/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation
import MirrorCoreSDK

@objc(MirrorHelper)
class MirrorHelper: NSObject {
  var logger = Logger.init()
  
  var treshold: Int = 50
  var mirror: EMSDeviceMirror?
  lazy var manager: EMSDeviceManager = {
    let m = EMSDeviceManager.init()
    m.delegate = self
    return m
  }()
  
  override init() {
    super.init()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.startScan()
    }
  }
  
  @objc(sendData:) func sendData(data: NSDictionary) {
    var message: [String:String] = [:]
    _ = data.map({
      let m = ($0.value as! [String:String])
      message += [m["key"]! : m["value"]!]
    })
    self.mirror?.display(message, completion: { error in
      guard error == nil else {
        self.logger.history += .failedToDisplay(error: error!)
        return
      }
      
      self.logger.history += .successDisplaying(data: message)
    })
  }
  
  @objc(setThreshold:) func setThreshold(t: NSInteger) {
    self.treshold = t
    
    guard self.mirror != nil else { return }
    if (abs((self.mirror?.rssi.i32)!) > self.treshold) {
      self.mirror?.disconnect()
    }
  }
  
  @objc(sync) func sync() {
    self.mirror?.synchronizeSettings(completion: { error in
      self.logger.history += .synchronizedSettings(error: error)
    })
  }
  
  func startScan() {
    self.manager.startDeviceDiscovery(with: EMSDeviceFilterMirror.init())
  }
}


extension MirrorHelper: EMSDeviceManagerDelegate {
  func deviceManager(_ manager: EMSDeviceManager, didDiscoverDevices devices: [Any]) {
    let mirror = (devices as! [EMSDeviceConnectable])
      .sorted(by: { $0.0.rssi > $0.1.rssi })
      .filter({ abs($0.rssi) < treshold })
      .first
    
    mirror?.delegate = self
    mirror?.connect()
    
    self.logger.history += .attemptingToConnect
  }
  
  func emsDevice(_ device: EMSDeviceConnectable, didUpdateRSSI RSSI: NSNumber, withError error: Error?) {
    self.logger.history += Log.rssiUpdate(RSSI: abs(RSSI.intValue))
  }
}

extension MirrorHelper: EMSDeviceConnectableDelegate {
  func emsDeviceConnectionDidSucceed(_ device: EMSDeviceConnectable) {
    guard let mirror = device as? EMSDeviceMirror else { return }
    self.mirror = mirror
    self.manager.stopDeviceDiscovery()
    
    self.logger.history += Log.identifierMessage(device: self.mirror)
  }
  
  
  func emsDevice(_ device: EMSDeviceConnectable, didDisconnectWithError error: Error?) {
    print("disconnected")
    self.mirror = nil
    self.manager.startDeviceDiscovery(with: EMSDeviceFilterMirror.init())
  }
}

extension MirrorHelper {
  func deviceManagerDidFailDiscovery(_ manager: EMSDeviceManager) {
    self.logger.history += Log.say("failed discovery")
  }
  func emsDevice(_ device: EMSDeviceConnectable, didFailConnectionWithError error: Error) {
    self.logger.history += Log.say("failed to connect")
  }
}
