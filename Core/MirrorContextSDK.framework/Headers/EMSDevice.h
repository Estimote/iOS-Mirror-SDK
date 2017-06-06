//
//  EMSDevice.h
//  EstimoteMirrorCoreSDK
//
//  Created by Estimote on 05.12.2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EMSDevice : NSObject

@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSUUID *peripheralIdentifier;
@property (nonatomic, assign, readonly) NSInteger rssi;
@property (nonatomic, strong, readonly) NSDate *discoveryDate;

/**
 *  Method allows to initialize object.
 *
 *  @param identifier           device identifier
 *  @param peripheralIdentifier CBPeripheral object's identifier
 *  @param rssi                 CBPeripheral object's RSSI
 *  @param discoveryDate        date of discovery
 *
 *  @return Initialized object.
 */
- (instancetype)initWithDeviceIdentifier:(NSString *)identifier
                    peripheralIdentifier:(NSUUID *)peripheralIdentifier
                                    rssi:(NSInteger)rssi
                           discoveryDate:(NSDate *)discoveryDate;

@end

NS_ASSUME_NONNULL_END
