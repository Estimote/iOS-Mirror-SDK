//
//   ______     _   _                 _          _____ _____  _  __
//  |  ____|   | | (_)               | |        / ____|  __ \| |/ /
//  | |__   ___| |_ _ _ __ ___   ___ | |_ ___  | (___ | |  | | ' /
//  |  __| / __| __| | '_ ` _ \ / _ \| __/ _ \  \___ \| |  | |  <
//  | |____\__ \ |_| | | | | | | (_) | ||  __/  ____) | |__| | . \
//  |______|___/\__|_|_| |_| |_|\___/ \__\___| |_____/|_____/|_|\_\
//
//
//  Copyright © 2016 Estimote. All rights reserved.

#import <Foundation/Foundation.h>
#import "EMSDeviceConnectable.h"

NS_ASSUME_NONNULL_BEGIN

#define EMSDeviceMirrorErrorDomain @"EMSDeviceMirrorErrorDomain"

/**
 *  Possible errors reported by this class.
 */
typedef NS_ENUM(NSInteger, EMSDeviceMirrorError) {
    /**
     *  Bluetooth connection during connection failed.
     */
    EMSDeviceMirrorErrorBluetoothConnectionFailed,
    /**
     *  Bluetooth services discovery during connection failed.
     */
    EMSDeviceMirrorErrorServicesDiscoveryFailed,
    /**
     *  Estimote Cloud Authorization during connection failed.
     */
    EMSDeviceMirrorErrorAuthorizationFailed,
    /**
     *  Synchronizing settings from Cloud failed.
     */
    EMSDeviceMirrorErrorSynchronizationFailed
};

@interface EMSDeviceMirror : EMSDeviceConnectable

/**
 *  Flag indicating if encryption is enabled.
 */
@property (nonatomic, strong, readonly) NSNumber *displayAccessControlEnabled;

/**
 *  Designated initlizer.
 *
 *  @param  identifier  Device's identifier.
 *  @param  peripheralIdentifier    Identifier of Mirror's device peripheral.
 *  @param  rssi    RSSI of scanned peripheral.
 *  @param  discoveryDate   Date of discovery.
 *
 *  @return Initilized EMSDeviceMirror object.
 */
- (instancetype)initWithDeviceIdentifier:(NSString *)identifier
                    peripheralIdentifier:(NSUUID *)peripheralIdentifier
                                    rssi:(NSInteger)rssi
                           discoveryDate:(NSDate *)discoveryDate
             displayAccessControlEnabled:(NSNumber *)displayAccessControlEnabled;

/**
 *  This method is responsbile for passing encrypted message to the Mirror device.
 *
 *  @param  message Data that will be sent to the Mirror device.
 *  @param  completion  Completion block invoked after sending data to the device. Data in completion block is encrypted MessagePack response from Mirror device. Nil error value means success.
 */
- (void)display:(NSDictionary *)message completion:(EMSDataCompletionBlock)completion;

/**
 *  Method responsible for fetching and applying Cloud settings to Mirror device.
 */
- (void)synchronizeSettingsWithCompletion:(EMSCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
