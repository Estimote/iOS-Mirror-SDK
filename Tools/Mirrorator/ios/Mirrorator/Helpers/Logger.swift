//
//  Logger.swift
//  Trello
//
//  Created by Mac Book on 09/07/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation

struct Logger {
  private let emitter = EventEmitter.shared
  var history: [Log] = [.say("yolo")] {
    willSet {
      let newLogs = Array(Set(history).symmetricDifference(Set(newValue)))
      for log in newLogs {
        print(log.stringValue)
        self.log(message: log)
      }
    }
  }
  
  func log(message: Log) {
    self.emitter.dispatch(name: "log", body: message.stringValue)
  }
}
