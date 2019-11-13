//
//  LFMQTTConfig.m
//  LFMQTTService
//
//  Created by liufan on 2019/9/10.
//

#import "LFMQTTConfig.h"
#import "LFMQTTUtil.h"

@implementation LFMQTTConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configEnv:LFMQTTEnvType_Beta];
    }
    return self;
}

- (void)configEnv:(LFMQTTEnvType)type{
    NSString *envStr = @"Develop";
    switch (type) {
        case LFMQTTEnvType_Preview:
            envStr = @"Preview";
            break;
        case LFMQTTEnvType_Release:
            envStr = @"Release";
            break;
        default:
            break;
    }
    _subscribeTopic = [NSString stringWithFormat:@"Topic_Instruct_%@",envStr];
    _sendTopic = [NSString stringWithFormat:@"Topic_Uplink_%@",envStr];
    _groupId = [NSString stringWithFormat:@"GID-Client-%@",envStr];
}

- (NSDictionary <NSString *,NSNumber *> *)subscriptions {
    
    return @{self.subscribeTopic:[NSNumber numberWithInteger:self.qos]};
}

@end;
