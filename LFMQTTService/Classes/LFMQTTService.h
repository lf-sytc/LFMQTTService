//
//  LFMQTTService.h
//  LFMQTTService
//
//  Created by liufan on 2019/9/10.
//

#import <Foundation/Foundation.h>
#import "LFMQTTProtocol.h"
#import "LFMQTTConfig.h"

typedef void (^LFMQTTConnectError)(NSError *error);

@interface LFMQTTService : NSObject

+ (instancetype)sharedInstance;

#pragma mark - Config

- (void)configMQTT:(LFMQTTConfig *)config;

- (void)configLog:(BOOL)open;

- (void)configMessageType:(NSString *)messageType
                 callBack:(id<LFMQTTMessageProtocol>)callBack;

#pragma mark - Connect

- (void)startToConnect:(LFMQTTConnectError)contentError;

- (void)endToConnect:(LFMQTTConnectError)contentError;


#pragma mark - Send Message

- (void)sendMessageType:(NSString *)type messageDic:(NSDictionary *)dic;

@end


