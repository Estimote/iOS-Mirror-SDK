//
//  MirrorHelperBridgeManager.m
//  Mirrorator
//
//  Created by Mac Book on 31/07/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>

//#import "Mirrorator-Swift.h"

@interface RCT_EXTERN_MODULE (MirrorHelper, NSObject)

RCT_EXTERN_METHOD(sendData:(NSDictionary *)data)
RCT_EXTERN_METHOD(setThreshold:(NSInteger)t)
RCT_EXTERN_METHOD(sync)

@end
