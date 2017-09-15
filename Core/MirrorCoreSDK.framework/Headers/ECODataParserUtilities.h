//  Copyright (c) 2015 Estimote. All rights reserved.

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ECOByteDirection)
{
    ECOByteDirectionOldYoung,
    ECOByteDirectionYoungOld,
};

@interface ECODataParserUtilities : NSObject

+ (NSData *)combineByte:(char)one and:(char)two and:(char)three and:(char)four;

+ (NSString *)removeAngleBracketsAndSpacesFromString:(NSString *)string;

+ (NSString *)stringFromHex:(NSString *)hexString
              withHexOffset:(int)offset
          withLengthInBytes:(int)length
              withDirection:(ECOByteDirection)byteDirection;

+ (unsigned)unsignedFromHex:(NSString *)hexString
              withHexOffset:(int)offset
          withLengthInBytes:(int)length
              withDirection:(ECOByteDirection)byteDirection;

+ (NSString *)stringFromDeviceData:(NSData *)data
                        withOffset:(int)byteOffset
                        withLenght:(int)bytesLength
                     withDirection:(ECOByteDirection)dir;

+ (NSData *)bytesFromHexString:(NSString *)hexString;
+ (NSData *)bytesFromHexString:(NSString *)hexString withDirection:(ECOByteDirection)dir;

+ (NSString *)revertHexString:(NSString *)hexString;

+ (NSData *)reverseDataForData:(NSData *)data;

+ (NSData *)swapBytesInData:(NSData *)data;

+ (BOOL)isValidHexString:(NSString *)string;

@end
