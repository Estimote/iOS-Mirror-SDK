//
//  MirrorHelper.swift
//  Trello
//
//  Created by Mac Book on 07/07/2017.
//

import Foundation
import MirrorContextSDK

typealias Mirrors = [EMSDeviceMirror]

@objc(MirrorHelper)
open class MirrorHelper: NSObject {
  var logger = Logger.init()
  var mirror: EMSDeviceMirror?
  var deviceManager = EMSDeviceManager.init()
  
  override init() {
    super.init()
  }
  
  @objc open func scanAndConnect() {
    self.deviceManager.delegate = self
    self.deviceManager.startDeviceDiscovery(with: EMSDeviceFilterMirror.init())
  }
  
  @objc open func disconnect() {
    self.mirror?.disconnect()
    self.mirror = nil
  }
  
  @objc open func set(_ config: NSDictionary?) {
    guard let config = config as? [AnyHashable : Any] else {
      self.logger.history += .noConfig
      return
    }
    
    self.mirror?.display(config, completion: { error in
      guard error == nil else {
        self.logger.history += .failedToDisplay(error: error!)
        return
      }
      
      self.logger.history += .successDisplaying
    })
  }
}

extension MirrorHelper: EMSDeviceManagerDelegate {
  public func deviceManager(_ manager: EMSDeviceManager, didDiscoverDevices devices: [Any]) {
    guard let device = (devices as? Mirrors)?.first else { return }
    
    self.mirror = device
    self.mirror?.delegate = self
    self.mirror?.connect()
    
    self.logger.history += .attemptingToConnect(device: device)
  }
}

extension MirrorHelper: EMSDeviceConnectableDelegate {
  public func emsDeviceConnectionDidSucceed(_ device: EMSDeviceConnectable) {
    guard let connectedMirror = device as? EMSDeviceMirror else { return }
    self.deviceManager.stopDeviceDiscovery()
    
    self.logger.history += [
      Log.connectionSuccess(devices: (self.mirror, connectedMirror)),
      Log.identifierMessage(device: self.mirror)
    ]
  }
  
  public func emsDevice(_ device: EMSDeviceConnectable, didUpdateRSSI RSSI: NSNumber, withError error: Error?) {
    let absoluteRSSI = abs(RSSI.intValue)
    self.logger.history += .rssiUpdate(RSSI: absoluteRSSI)
  }
}
