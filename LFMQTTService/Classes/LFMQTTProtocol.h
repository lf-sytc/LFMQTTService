//
//  LFMQTTProtocol.h
//  LFMQTTService
//
//  Created by liufan on 2019/9/10.
//

#ifndef LFMQTTProtocol_h
#define LFMQTTProtocol_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,LFMQTTEnvType){
    LFMQTTEnvType_Beta,      //测试
    LFMQTTEnvType_Preview,   //预生产
    LFMQTTEnvType_Release,   //生产
};

@protocol LFMQTTMessageProtocol <NSObject>

- (void)LFMQTTMessageType:(NSString *)type data:(id)data;

@end

#endif /* LFMQTTProtocol_h */
