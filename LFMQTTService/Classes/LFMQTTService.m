//
//  LFMQTTService.m
//  LFMQTTService
//
//  Created by liufan on 2019/9/10.
//

#import "LFMQTTService.h"
#import <MQTTClient/MQTTClient.h>
#import <MQTTClient/MQTTSessionManager.h>
#import <CommonCrypto/CommonHMAC.h>
#import <MQTTClient/MQTTLog.h>
#import "LFMQTTConfig.h"
#import "LFMQTTUtil.h"
@interface LFMQTTService()<MQTTSessionManagerDelegate>
{
    LFMQTTConfig *config;
    NSMutableDictionary *listenerDic;
}

@property (strong, nonatomic) MQTTSessionManager *manager;
@property (strong, nonatomic) NSString *loginMessageType;
@property (strong, nonatomic) NSDictionary *loginMessageData;

@end

@implementation LFMQTTService

#pragma mark - Init

+ (instancetype)sharedInstance{
    
    static LFMQTTService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[LFMQTTService alloc] init];
    });
    return service;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

#pragma mark - Init Data

- (void)initData{
    config = [[LFMQTTConfig alloc] init];
    listenerDic = [[NSMutableDictionary alloc] init];
}

#pragma mark - Config MQTT Parameters

/// 配置MQTT 网络连接相关
/// @param host id地址（阿里云MQTT控制台获取）
/// @param port 端口号 （阿里云MQTT文档获取）
/// @param useSSL 是否启用SSL
/// @param keeplive 心跳间隔
- (void)configHost:(NSString *)host
              port:(NSInteger)port
            useSSL:(BOOL)useSSL
          keeplive:(NSInteger)keeplive{
    config.host = host;
    config.port = port;
    config.tls = useSSL;
    config.keeplive = keeplive;
}


/// 配置MQTT 是否处理离线消息 及 发送消息等级
/// @param clean YES 不处理  NO 处理
/// @param qos 0、1、2
- (void)configClean:(BOOL)clean
                qos:(NSInteger)qos{
    config.clean = clean;
    config.qos = qos;
}

/// 配置MQTT 配置设备ID
/// @param deviceID 设备唯一标识
- (void)config{
   
    
}

/// 配置MQTT 秘钥相关
/// @param accessKey  阿里云秘钥
/// @param instanceId 后台实例ID
/// @param secretKey  阿里云MQTT秘钥
- (void)configEnv:(LFMQTTEnvType)envType
         deviceID:(NSString *)deviceID
        accessKey:(NSString *)accessKey
       instanceId:(NSString *)instanceId
        secretKey:(NSString *)secretKey {
    
    [config configEnv:envType];
    config.clientId = [NSString stringWithFormat:@"%@@@@%@",config.groupId,deviceID];
    config.userName = [NSString stringWithFormat:@"Signature|%@|%@",accessKey,instanceId];
    config.password = [LFMQTTUtil macSignWithText:config.clientId secretKey:secretKey];
}

#pragma mark - Config MQTT Debug Parameters

- (void)configLog:(BOOL)open{
    [MQTTLog setLogLevel:open?DDLogLevelVerbose:DDLogLevelOff];
}

#pragma mark - Connect

- (void)startToConnect:(LFMQTTConnectError)contentError {
    if (!self.manager) {
        self.manager = [[MQTTSessionManager alloc] init];
        self.manager.delegate = self;
        self.manager.subscriptions = [config subscriptions];
    }
    [self.manager connectTo:config.host
                       port:config.port
                        tls:config.tls
                  keepalive:config.keeplive
                      clean:true
                       auth:true
                       user:config.userName
                       pass:config.password
                       will:false
                  willTopic:nil
                    willMsg:nil
                    willQos:config.qos
             willRetainFlag:false
               withClientId:config.clientId
             securityPolicy:nil
               certificates:nil
              protocolLevel:MQTTProtocolVersion311
             connectHandler:^(NSError *error) {
             if (contentError) {
                 contentError(error);
             }
    }];
}

- (void)endToConnect:(LFMQTTConnectError)contentError {
    [self.manager disconnectWithDisconnectHandler:contentError];
}

#pragma mark - Send Message

- (void)sendMessageType:(NSString *)type messageDic:(NSDictionary *)dic {
    if (type && dic.allKeys.count > 0) {
        NSMutableDictionary *sendDic = [NSMutableDictionary dictionary];
        sendDic[@"type"] = type;
        sendDic[@"data"] = [LFMQTTUtil jsonStringWithDic:dic];
        NSData *data = [LFMQTTUtil dataWtihDic:sendDic];
        if (data) {
            [self.manager sendData:data topic:config.sendTopic qos:config.qos retain:false];
        }
    }
}

#pragma mark - Handle Message Linder

- (BOOL)listenerMessageType:(NSString *)type
                protocolObj:(id<LFMQTTMessageProtocol>)protocolObj{
    
    if (type.length > 0 &&
        [protocolObj conformsToProtocol:@protocol(LFMQTTMessageProtocol)] &&
        [protocolObj respondsToSelector:@selector(LFMQTTMessageType:data:)]) {
        listenerDic[type] = protocolObj;
        return YES;
    }
    return NO;
}

#pragma mark - MQTTSessionManagerDelegate

- (void)handleMessage:(NSData *)data
              onTopic:(NSString *)topic
             retained:(BOOL)retained {
    
    NSDictionary *dic = [LFMQTTUtil dicWithData:data];
    id<LFMQTTMessageProtocol> obj = listenerDic[dic[@"type"]];
    [obj LFMQTTMessageType:dic[@"type"] data:dic[@"data"]];
}

- (void)sessionManager:(MQTTSessionManager *)sessionManager
        didChangeState:(MQTTSessionManagerState)newState{
    
    NSString *stateStr = @"";
    switch (newState) {
        case MQTTSessionManagerStateStarting:
            stateStr = @"开始连接...";
            break;
        case MQTTSessionManagerStateConnecting:
            stateStr = @"连接中...";
            break;
        case MQTTSessionManagerStateError:
            stateStr = @"连接出错";
            break;
        case MQTTSessionManagerStateConnected:
            stateStr = @"连接成功";
            break;
        case MQTTSessionManagerStateClosing:
            stateStr = @"连接关闭中";
            break;
        case MQTTSessionManagerStateClosed:
            stateStr = @"连接关闭成功";
            break;
        default:
            break;
    }
    
    DDLogDebug(@"当前状态 %@",stateStr);
}

@end

