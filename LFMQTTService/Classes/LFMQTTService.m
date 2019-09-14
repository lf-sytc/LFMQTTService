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
}

#pragma mark - Config

- (void)configEnv:(LFMQTTEnvType)type{
//    [config configEnv:type];
}

- (void)configLog:(BOOL)open{
    [MQTTLog setLogLevel:open?DDLogLevelVerbose:DDLogLevelOff];
}

- (void)configMQTTWithUserId:(NSString *)userId
                  instanceId:(NSString *)instanceId {
    
    config.instanceId = instanceId;
    config.clientId = [NSString stringWithFormat:@"%@@@@%@",config.groupId,userId];
}

- (void)configMessageType:(NSString *)messageType
                 callBack:(id<LFMQTTMessageProtocol>)callBack{
//    [config configMessageType:messageType obj:callBack];
}

- (void)configLoginMessage:(NSString *)messageType data:(NSDictionary *)dic {
    _loginMessageType = messageType;
    _loginMessageData = dic;
}

#pragma mark - Connect

- (void)endToConnect:(LFMQTTConnectError)contentError {
    [self.manager disconnectWithDisconnectHandler:contentError];
}

- (void)startToConnect:(LFMQTTConnectError)contentError{
    
    if (!self.manager) {
        self.manager = [[MQTTSessionManager alloc] init];
        self.manager.delegate = self;
        self.manager.subscriptions = [config subscriptions];
        
        [self.manager connectTo:config.host
                           port:config.port
                            tls:config.tls
                      keepalive:60
                          clean:true
                           auth:true
                           user:[config userName]
                           pass:[config password]
                           will:false
                      willTopic:nil
                        willMsg:nil
                        willQos:0
                 willRetainFlag:false
                   withClientId:config.clientId
                 securityPolicy:nil
                   certificates:nil
                  protocolLevel:MQTTProtocolVersion311
                 connectHandler:^(NSError *error) {
                     if (!error) {
                         [self sendMessageType:self.loginMessageType messageDic:self.loginMessageData];
                     }
                     
                     if (contentError) {
                         contentError(error);
                     }
                 }];
        
    } else {
        [self.manager connectToLast:^(NSError *error) {
            if (!error) {
                [self sendMessageType:self.loginMessageType messageDic:self.loginMessageData];
            }
            
            if (contentError) {
                contentError(error);
            }
        }];
    }
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


#pragma mark - MQTTSessionManagerDelegate

- (void)handleMessage:(NSData *)data onTopic:(NSString *)topic retained:(BOOL)retained {
    
    NSDictionary *dic = [LFMQTTUtil dicWithData:data];
    
    NSDictionary *responseDic = [LFMQTTUtil dicWithJsonString:dic[@"data"]];
    
//    id<LFMQTTMessageProtocol> objc = [config objByMessageType:dic[@"type"]];
//    if ([objc conformsToProtocol:@protocol(LFMQTTMessageProtocol)] &&
//        [objc respondsToSelector:@selector(LFMQTTMessage:)]) {
//        [objc LFMQTTMessage:responseDic];
//    }
}

- (void)sessionManager:(MQTTSessionManager *)sessionManager didChangeState:(MQTTSessionManagerState)newState{
    
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

