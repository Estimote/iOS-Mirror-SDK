//
//   ______     _   _                 _          _____ _____  _  __
//  |  ____|   | | (_)               | |        / ____|  __ \| |/ /
//  | |__   ___| |_ _ _ __ ___   ___ | |_ ___  | (___ | |  | | ' /
//  |  __| / __| __| | '_ ` _ \ / _ \| __/ _ \  \___ \| |  | |  <
//  | |____\__ \ |_| | | | | | | (_) | ||  __/  ____) | |__| | . \
//  |______|___/\__|_|_| |_| |_|\___/ \__\___| |_____/|_____/|_|\_\
//
//
//  Copyright (c) 2016 Estimote. All rights reserved.

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


@class EMSDeviceManager;

@protocol EMSDeviceManagerDelegate <NSObject>

@optional

/**
 * Tells the delegate that one or more Estimote devices were discovered in the vicinity of the iOS device.
 * Actual class of objects depend on filter used to start the manager.
 *
 * @param manager The utility manager object reporting the event.
 * @param devices An array of EMSDevice subclass objects representing the discovered devices.
 *
 * @see EMSDeviceFilterMirror
 */
- (void)deviceManager:(EMSDeviceManager *)manager didDiscoverDevices:(NSArray *)devices;

/**
 * Tells the delegate that a discovery error occurred.
 *
 * @param manager The utility manager object reporting the event.
 */
- (void)deviceManagerDidFailDiscovery:(EMSDeviceManager *)manager;

@end

@protocol EMSDeviceFilter;

/**
 * The `EMSDeviceManager` class defines the interface for utility methods related to Estimote devices. 
 * The main functionality allows to discover CoreBluetooth based representation of Estimote Beacon devices.
 *
 * One device manager instance can discover devices only with one filter at a time.
 */

@interface EMSDeviceManager : NSObject

/**
 *  Informs if a filtered or telemetry scan is in progress.
 */
@property (nonatomic, assign, readonly) BOOL isScanning;

/**
 *  Delegate to be informed about scan results every 1 sec.
 */
@property (nonatomic, weak) id<EMSDeviceManagerDelegate> delegate;

/**
 *  Start discovering Estimote devices determined by the filter, using CoreBluetooth. 
 *  One filter can be active per a EMSDeviceManager instance.
 *  If called multiple times only the last provided filter is active.
 *
 *  Causes the delegate to be called with -[EMSDeviceManagerDelegate deviceManager:didDiscoverDevices:] every 1 sec (default interval value).
 *
 *  @param  filter  Object conforming to EMSDeviceFilter protocol.
 */
- (void)startDeviceDiscoveryWithFilter:(id<EMSDeviceFilter>)filter;

/**
 *  Start discovering Estimote devices determined by the filter, using CoreBluetooth.
 *  One filter can be active per a EMSDeviceManager instance.
 *  If called multiple times only the last provided filter is active.
 *
 *  Causes the delegate to be called with -[EMSDeviceManagerDelegate deviceManager:didDiscoverDevices:] every `interval` seconds.
 *
 *  @param  filter  Object conforming to EMSDeviceFilter protocol.
 *  @param  interval    Device discovery interval in seconds. Interval's value cannot be smaller than 100 ms. Providing smaller value will be overriden with default 1 second interval.
 */
- (void)startDeviceDiscoveryWithFilter:(id<EMSDeviceFilter>)filter withInterval:(NSTimeInterval)interval;

/**
 *  Stops Estimote device discovery.
 */
- (void)stopDeviceDiscovery;


@end

NS_ASSUME_NONNULL_END
