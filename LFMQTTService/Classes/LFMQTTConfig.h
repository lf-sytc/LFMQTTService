//
//  LFMQTTConfig.h
//  LFMQTTService
//
//  Created by liufan on 2019/9/10.
//

#import <Foundation/Foundation.h>
#import "LFMQTTProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface LFMQTTConfig : NSObject

//配置 网络地址相关的
@property (nonatomic,strong) NSString *host;
@property (nonatomic,assign) NSInteger port;
@property (nonatomic,assign) NSInteger keeplive;
@property (nonatomic,assign) BOOL tls;

//配置 消息相关的
@property (nonatomic,assign) BOOL clean;
@property (nonatomic,assign) NSInteger qos;

//后台 生成秘钥
@property (nonatomic,strong) NSString *instanceId;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *password;

//主题相关
@property (nonatomic,strong) NSString *subscribeTopic;
@property (nonatomic,strong) NSString *sendTopic;
@property (nonatomic,strong) NSString *groupId;

//实例id
@property (nonatomic,strong) NSString *clientId;

- (NSDictionary <NSString *,NSNumber *> *)subscriptions;
- (void)configEnv:(LFMQTTEnvType)type;
@end

NS_ASSUME_NONNULL_END
