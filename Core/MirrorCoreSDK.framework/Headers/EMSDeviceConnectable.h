//
//  EMSDeviceConnectable.h
//  EstimoteMirrorCoreSDK
//
//  Created by Estimote on 05.12.2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMSDevice.h"
#import "EMSDefinitions.h"

NS_ASSUME_NONNULL_BEGIN

@class EMSDeviceConnectable;

/**
 *  EMSDeviceConnectableDelegate defines protocol for EMSDeviceConnectable delegate object.
 */
@protocol EMSDeviceConnectableDelegate <NSObject>

@optional

/**
 *  Method invoked when connection to device was successful.
 *
 *  @param device Device connection was established with.
 */
- (void)emsDeviceConnectionDidSucceed:(EMSDeviceConnectable *)device;

/**
 *  Method invoked when device disconnect event occurred.
 *
 *  @param device Disconnected device.
 *  @param error  Error representing reason of disconnect.
 */
- (void)emsDevice:(EMSDeviceConnectable *)device didDisconnectWithError:(NSError * _Nullable)error;

/**
 *  Method invoked when connection to device failed.
 *
 *  @param device Device connection failed for.
 *  @param error  Error representing reason of failure.
 */
- (void)emsDevice:(EMSDeviceConnectable *)device didFailConnectionWithError:(NSError *)error;

/**
 *  Method invoked when connected peripheral is reading RSSI.
 *
 *  @param  device  Peripheral's device.
 *  @param  RSSI    RSSI of the connected peripheral.
 *  @param  error   Error returned from reading peripheral's RSSI.
 */
- (void)emsDevice:(EMSDeviceConnectable *)device didUpdateRSSI:(NSNumber *)RSSI withError:(NSError * _Nullable)error;

/**
 *  Method invoked when connected peripheral receives data.
 *
 *  @param  data  Received data from connected device. Data is nil in case of decoding error.
 */
- (void)didReceiveData:(NSDictionary * _Nullable)data;

@end

/**
 *  EMSDeviceConnectable is a superclass for connectable Estimote devices.
 */
@interface EMSDeviceConnectable : EMSDevice

/**
 *  Delegate object that will get callbacks realted to connection.
 */
@property (nonatomic, weak) id<EMSDeviceConnectableDelegate> _Nullable delegate;

/**
 *  Status of device connection.
 */
@property (nonatomic, assign, readonly) EMSConnectionStatus connectionStatus;

#pragma mark Connectivity
///--------------------------------------------------------------------
/// @name Connectivity
///--------------------------------------------------------------------

/**
 *  Perform connection to the device.
 */
- (void)connect;

/**
 * Cancel connection to the device.
 */
- (void)disconnect;

@end

NS_ASSUME_NONNULL_END
