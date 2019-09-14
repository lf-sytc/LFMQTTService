//
//  LFMQTTConfig.h
//  LFMQTTService
//
//  Created by liufan on 2019/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LFMQTTConfig : NSObject

//订阅主题
@property (strong, nonatomic) NSString *subscribeTopic;

//发送主题
@property (strong, nonatomic) NSString *sendTopic;

//后台生成实例ID
@property (strong, nonatomic) NSString *instanceId;

//后台生成访问key
@property (strong, nonatomic) NSString *accessKey;

//后台生成私钥
@property (strong, nonatomic) NSString *secretKey;

//群组id
@property (strong, nonatomic) NSString *groupId;

//访问host
@property (strong, nonatomic) NSString *host;

//实例id
@property (strong, nonatomic) NSString *clientId;

//端口
@property (nonatomic) NSInteger port;
@property (nonatomic) NSInteger qos;
@property (nonatomic) BOOL tls;

- (NSDictionary <NSString *,NSNumber *> *)subscriptions;

- (NSString *)password;

- (NSString *)userName;



@end

NS_ASSUME_NONNULL_END
