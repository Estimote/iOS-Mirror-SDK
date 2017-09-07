//
//  ReactNativeEventEmitter.m
//  Trello
//
//  Created by Mac Book on 08/07/2017.
//
//  See: http://facebook.github.io/react-native/releases/0.43/docs/native-modules-ios.html#exporting-swift
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(ReactNativeEventEmitter, RCTEventEmitter)

RCT_EXTERN_METHOD(supportedEvents)

@end
