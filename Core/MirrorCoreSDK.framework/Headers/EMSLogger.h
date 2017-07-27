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
#include <string.h>

/**
 *  User friendly ready to use macros for logging with each `EMSLogLevel`.
 */
#define EMSVerboseLog(fmt, ...) [EMSLogger log:[NSString stringWithFormat:(@"%s:%d " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__] withLevel:EMSLogLevelVerbose]
#define EMSInfoLog(fmt, ...) [EMSLogger log:[NSString stringWithFormat:(@"%s:%d " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__] withLevel:EMSLogLevelInfo]
#define EMSErrorLog(fmt, ...) [EMSLogger log:[NSString stringWithFormat:(@"%s:%d " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__] withLevel:EMSLogLevelError]
#define EMSWarningLog(fmt, ...) [EMSLogger log:[NSString stringWithFormat:(@"%s:%d " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__] withLevel:EMSLogLevelWarning]
#define EMSDebugLog(fmt, ...) [EMSLogger log:[NSString stringWithFormat:(@"%s:%d " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__] withLevel:EMSLogLevelDebug]

/**
 *  Log levels are used to filter out logs to print and cache.
 */
typedef enum : int
{
    /**
     *  No logs.
     */
    EMSLogLevelNone,
    /**
     *  Error logs only.
     */
    EMSLogLevelError,
    /**
     *  Error and warnings logs only.
     */
    EMSLogLevelWarning,
    /**
     *  This level is for printing all errors, warnings and debug related information. Should be used for current developement.
     *  @warning    When finished developing/enhancing code please turn logs from EMSLogLevelDebug to EMSLogLevelInfo.
     */
    EMSLogLevelDebug,
    /**
     *  This level is for printing all errors, warnings, debug related and informative logs.
     *  @warning    Not the same as EMSLogLevelDebug
     *  @sa EMSLogLevelDebug
     */
    EMSLogLevelInfo,
    /**
     *  Level for all possible logs you want to print. Should be used for lowest possible level of information, e.g. printing CoreBluetooth data. 
     *  @warning    *Important*: Keep in mind EMSLogLevelVerbose will produce a lot of logs.
     */
    EMSLogLevelVerbose
    
} EMSLogLevel;

/**
 *  EMSLogger is a helper class to faciliate handling logs and debugging. Class is compatible with KZLinkedConsole.
 */

@interface EMSLogger : NSObject

/**
 *  Method allows to set `EMSLogLevel` for console. Logs above given level will not be printed to console.
 */
+ (void)setConsoleLogLevel:(EMSLogLevel)level;

/**
 *  Method allows to set `EMSLogLevel` for cache. Logs above given level will not be cached by logger.
 */
+ (void)setCacheLogLevel:(EMSLogLevel)level;

/**
 *  Method retrieves logs from cache.
 */
+ (NSString *)getLogCache;

/**
 *  Method clears cached logs.
 */
+ (void)clearLogCache;

/**
 *  Method logs given string with specific level. @warning *Warning:* Using this method with `EMSLoglevel` higher than currently
 *  set with `enableLogger:withLevel:` or `setConsoleLogLevel:` will not print message.
 */
+ (void)log:(NSString *)message
  withLevel:(EMSLogLevel)level;

/**
 *  Write cached logs to document file. To retrieve it use iTunes File Sharing. For more info visit: https://support.apple.com/en-us/HT201301 .
 *
 *  Remember to set UIFileSharingEnabled to YES (also known as "Application supports iTunes file sharing") in your app's Info.plist.
 */
+ (void)dumpLogCacheToFile;

@end
