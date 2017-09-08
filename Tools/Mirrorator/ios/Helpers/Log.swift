//
//  Log.swift
//  Trello
//
//  Created by Mac Book on 07/07/2017.
//

import Foundation
import MirrorContextSDK

enum Log {
  case attemptingToConnect(device: EMSDeviceMirror)
  case connectionSuccess(devices: (EMSDeviceMirror?, EMSDeviceMirror))
  case identifierMessage(device: EMSDeviceMirror?)
  case failedToDisplay(error: Error)
  case successDisplaying
  case rssiUpdate(RSSI: Int)
  case noConfig
  case say(_: String)
  
  var stringValue: String {
    switch self {
    case .attemptingToConnect(let mirror):
      return "attempting to connect to mirror with id: \(mirror.identifier)"
    case .connectionSuccess(let mirrors):
      return "connection success status: \(mirrors.0?.identifier == mirrors.1.identifier)"
    case .identifierMessage(let mirror):
      return "connected to mirror with id: \(mirror?.identifier ?? "unknown identifier")"
    case .failedToDisplay(let error):
      return "failed to display with error: \(error.localizedDescription)"
    case .successDisplaying:
      return "successfully displayed to mirror"
    case .rssiUpdate(let RSSI):
      return "RSSI: \(RSSI)"
    case .say(let s):
      return s
    case .noConfig:
      return "so config passed"
    default:
      return ""
    }
  }
}

extension Log: Hashable {
  var hashValue: Int {
    return self.stringValue.hashValue
  }
  
  static func ==(lhs: Log, rhs: Log) -> Bool {
    return lhs.stringValue == rhs.stringValue
  }
}
