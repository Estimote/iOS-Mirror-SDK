//
//  MirrorHelperBridgeManager.m
//  Trello
//
//  Created by Mac Book on 08/07/2017.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(MirrorHelper, NSObject)

RCT_EXTERN_METHOD(setTempate: (NSString _Nullable *)templateName)
RCT_EXTERN_METHOD(scanAndConnect)
RCT_EXTERN_METHOD(disconnect)

@end
