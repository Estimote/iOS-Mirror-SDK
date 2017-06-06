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


/**
 *  Protocol that every filter class used by EMSDeviceManager should conform to.
 *
 *  Defines predicate to be evaluated on EMSDevice subclass objects resulting from scanning
 *  and scan classes to be used by a bluetooth scanner underneath the EMSDeviceManager.
 *
 *  @see EMSDeviceManager, ECOScanInfoIBeacon.
 */
@protocol EMSDeviceFilter <NSObject>

/**
 *  Predicate that EMSDeviceManager evaluates on scan result objects to execute filtering by attribute (i.e. identifier).
 */
@property (nonatomic, strong, readonly) NSPredicate *devicesPredicate;

/**
 *  Method returns array of packet classes needed by bluetooth scanner.
 *
 *  @return Array of ECOScanInfo subclasses.
 */
- (NSArray<Class> *)getScanInfoClasses;

@end

NS_ASSUME_NONNULL_END
