//
//   ______     _   _                 _          _____ _____  _  __
//  |  ____|   | | (_)               | |        / ____|  __ \| |/ /
//  | |__   ___| |_ _ _ __ ___   ___ | |_ ___  | (___ | |  | | ' /
//  |  __| / __| __| | '_ ` _ \ / _ \| __/ _ \  \___ \| |  | |  <
//  | |____\__ \ |_| | | | | | | (_) | ||  __/  ____) | |__| | . \
//  |______|___/\__|_|_| |_| |_|\___/ \__\___| |_____/|_____/|_|\_\
//
//
//  Copyright (c) 2015 Estimote. All rights reserved.

#import <Foundation/Foundation.h>
#import "EMSDefinitions.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  EMSConfig is used to configure Estimote Cloud API. It allows to authorize app using AppID and AppToken 
 *  and configure Estimote Analytics settings.
 */

@interface EMSConfig : NSObject

#pragma mark - Estimote API Credentials

/**
 * Sets App ID and App Token, enabling communication with the Estimote Cloud API.
 *
 * You can find your API App ID and API App Token in the Account Settings section of the Estimote Cloud.
 *
 * @param appID The API App ID.
 * @param appToken The API App Token.
 */
+ (void)setupAppID:(NSString *)appID andAppToken:(NSString *)appToken;

/**
 * Returns currently used App ID.
 *
 * @return currently used App ID.
 */
+ (NSString * _Nullable)appID;

/**
 * Returns currently used App Token.
 *
 * @return currently used App Token.
 */
+ (NSString * _Nullable)appToken;

/**
 * Checks if App ID and App Token were set.
 */
+ (BOOL)isAuthorized;

@end

NS_ASSUME_NONNULL_END
