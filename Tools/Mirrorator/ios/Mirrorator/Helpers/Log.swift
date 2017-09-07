//
//  Log.swift
//  Trello
//
//  Created by Mac Book on 07/07/2017.
//

import Foundation
import MirrorCoreSDK

enum Log {
  case attemptingToConnect
  case identifierMessage(device: EMSDeviceMirror?)
  case failedToDisplay(error: Error)
  case successDisplaying(data: [String:String])
  case rssiUpdate(RSSI: Int)
  case synchronizedSettings(error: Error?)
  case noConfig
  case say(_: String)
  
  var stringValue: String {
    switch self {
    case .attemptingToConnect:
      return "attempting to connect to mirror"
    case .identifierMessage(let mirror):
      return "connected to mirror with id: \(mirror?.identifier ?? "unknown identifier")"
    case .failedToDisplay(let error):
      return "failed to display with error: \(error.localizedDescription)"
    case .successDisplaying(let data):
      return "successfully displayed to mirror with data: \(data)"
    case .rssiUpdate(let RSSI):
      return "RSSI: \(RSSI)"
    case .synchronizedSettings(let error):
      return "synchronized settings: \(error?.localizedDescription ?? "success")"
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
