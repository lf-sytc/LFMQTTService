//
//  LFMQTTService.h
//  LFMQTTService
//
//  Created by liufan on 2019/9/10.
//

#import <Foundation/Foundation.h>
#import "LFMQTTProtocol.h"
#import "LFMQTTConfig.h"
#import "LFMQTTProtocol.h"
typedef void (^LFMQTTConnectError)(NSError *error);

@interface LFMQTTService : NSObject

+ (instancetype)sharedInstance;

#pragma mark - Config MQTT Parameters

/// 配置MQTT 网络连接相关
/// @param host id地址（阿里云MQTT控制台获取）
/// @param port 端口号 （阿里云MQTT文档获取）
/// @param useSSL 是否启用SSL
/// @param keeplive 心跳间隔
- (void)configHost:(NSString *)host
              port:(NSInteger)port
            useSSL:(BOOL)useSSL
          keeplive:(NSInteger)keeplive;

/// 配置MQTT 是否处理离线消息 及 发送消息等级 两者有关联
/// @param clean YES 不处理  NO 处理
/// @param qos 0、1、2 
- (void)configClean:(BOOL)clean
                qos:(NSInteger)qos;

/// 配置MQTT 登陆秘钥
/// @param accessKey  阿里云秘钥
/// @param instanceId 后台实例ID
/// @param secretKey  阿里云MQTT秘钥
- (void)configEnv:(LFMQTTEnvType)envType
         deviceID:(NSString *)deviceID
        accessKey:(NSString *)accessKey
       instanceId:(NSString *)instanceId
        secretKey:(NSString *)secretKey;

#pragma mark - Config MQTT Debug Parameters

- (void)configLog:(BOOL)open;


#pragma mark - Connect Event

- (void)startToConnect:(LFMQTTConnectError)contentError;

- (void)endToConnect:(LFMQTTConnectError)contentError;


#pragma mark - Send Message

- (void)sendMessageType:(NSString *)type messageDic:(NSDictionary *)dic;

#pragma mark - Handle Message Linder

- (BOOL)listenerMessageType:(NSString *)type
                protocolObj:(id<LFMQTTMessageProtocol>)protocolObj;
        

@end


