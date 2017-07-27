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
#import "EMSDeviceFilter.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  Filter class enabling EMSDeviceManager class to scan for devices broadcasting 
 *  Estimote Mirror bluetooth packet.
 *
 *  Class cane be initialised by providing 16-byte long identifiers defining directly
 *  set of mirror devices we want to work with.
 *
 *  @see EMSDeviceManager.
 */
@interface EMSDeviceFilterMirror : NSObject <EMSDeviceFilter>


/**
 *  Method allows to initialise filter accepting any devices broadcasting
 *  Estimote Mirror bluetooth packet.
 *
 *  @return Initialised filter.
 */
- (instancetype)init;

/**
 *  Method allows to initialise filter accepting devices broadcasting
 *  Estimote Mirror bluetooth packet containing provided identifier.
 *
 *  @param identifier 16-byte identifier of Mirror device.
 *
 *  @return Initialised filter.
 */
- (instancetype)initWithIdentifier:(nullable NSString *)identifier;

/**
 *  Method allows to initialise filter accepting devices broadcasting
 *  Estimote Mirror bluetooth packet containing one of provided identifiers.
 *
 *  @param identifierArray Array containing 16-byte identifiers of Mirror devices.
 *
 *  @return Initialised filter.
 */
- (instancetype)initWithIdentifierArray:(nullable NSArray<NSString *> *)identifierArray;

@end

NS_ASSUME_NONNULL_END
