//
//  LFMQTTUtil.h
//  LFMQTTService
//
//  Created by liufan on 2019/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LFMQTTUtil : NSObject

+ (NSString *)macSignWithText:(NSString *)text secretKey:(NSString *)secretKey;

+ (NSDictionary *)dicWithJsonString:(NSString *)jsonString;
+ (NSDictionary *)dicWithData:(NSData *)data;


+ (NSData *)dataWtihDic:(NSDictionary *)dic;


+ (NSString *)jsonStringWithData:(NSData *)data;
+ (NSString *)jsonStringWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
