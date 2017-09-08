//
//  EventEmitter.swift
//  Trello
//
//  Created by Mac Book on 08/07/2017.
//

import Foundation

class EventEmitter {

  /// Shared Instance.
  public static var shared = EventEmitter()

  // ReactNativeEventEmitter is instantiated by React Native with the bridge.
  private static var eventEmitter: ReactNativeEventEmitter!

  private init() {}

  // When React Native instantiates the emitter it is registered here.
  func registerEventEmitter(eventEmitter: ReactNativeEventEmitter) {
    EventEmitter.eventEmitter = eventEmitter
  }

  func dispatch(name: String, body: Any?) {
    EventEmitter.eventEmitter.sendEvent(withName: name, body: body)
  }

  /// All Events which must be support by React Native.
  lazy var allEvents: [String] = {
    var allEventNames: [String] = [
      "log"
    ]
    
    return allEventNames
  }()
}
