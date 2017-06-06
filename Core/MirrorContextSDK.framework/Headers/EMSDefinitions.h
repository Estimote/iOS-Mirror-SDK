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

typedef NS_ENUM(int, EMSConnectionStatus)
{
    EMSConnectionStatusDisconnected,
    EMSConnectionStatusConnecting,
    EMSConnectionStatusConnected,
    EMSConnectionStatusUpdating
};

typedef void(^EMSCompletionBlock)(NSError * _Nullable error);
typedef void(^EMSObjectCompletionBlock)(id _Nullable result, NSError * _Nullable error);
typedef void(^EMSDataCompletionBlock)(NSData * _Nullable result, NSError * _Nullable error);
typedef void(^EMSNumberCompletionBlock)(NSNumber * _Nullable value, NSError * _Nullable error);
typedef void(^EMSUnsignedShortCompletionBlock)(unsigned short value, NSError * _Nullable error);
typedef void(^EMSBoolCompletionBlock)(BOOL value, NSError * _Nullable error);
typedef void(^EMSStringCompletionBlock)(NSString * _Nullable value, NSError * _Nullable error);
typedef void(^EMSProgressBlock)(NSInteger value, NSString * _Nullable description, NSError * _Nullable error);
typedef void(^EMSArrayCompletionBlock)(NSArray * _Nullable value, NSError * _Nullable error);
typedef void(^EMSDictionaryCompletionBlock)(NSDictionary * _Nullable value, NSError * _Nullable error);
typedef void(^EMSCsRegisterCompletonBlock)(NSError * _Nullable error);
