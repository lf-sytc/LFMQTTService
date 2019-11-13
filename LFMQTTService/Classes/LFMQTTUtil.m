//
//  LFMQTTUtil.m
//  LFMQTTService
//
//  Created by liufan on 2019/9/10.
//

#import "LFMQTTUtil.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation LFMQTTUtil

+ (NSString *)macSignWithText:(NSString *)text
                    secretKey:(NSString *)secretKey
{
    NSData *saltData = [secretKey dataUsingEncoding:NSUTF8StringEncoding];
    NSData *paramData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* hash = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH ];
    CCHmac(kCCHmacAlgSHA1, saltData.bytes, saltData.length, paramData.bytes, paramData.length, hash.mutableBytes);
    NSString *base64Hash = [hash base64EncodedStringWithOptions:0];
    
    return base64Hash;
}


#pragma mark - to Dic

+ (NSDictionary *)dicWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [self dicWithData:jsonData];
}

+ (NSDictionary *)dicWithData:(NSData *)data {
    
    if (data != nil) {
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        if (err == nil) {
            return dic;
        }
    }
    return nil;
}

#pragma mark - to Data

+ (NSData *)dataWtihDic:(NSDictionary *)dic {
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&err];
    
    if (err) {
        jsonData = nil;
    }
    return jsonData;
}

#pragma mark - to String

+ (NSString *)jsonStringWithDic:(NSDictionary *)dic {
    
    NSData *jsonData = [self dataWtihDic:dic];
    if (jsonData != nil) {
        NSString *dataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return dataStr;
    }
    return nil;
}

+ (NSString *)jsonStringWithData:(NSData *)data {
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return dataString;
}



@end

