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
        
    }
    return self;
}

- (NSDictionary <NSString *,NSNumber *> *)subscriptions {
    
    return @{self.subscribeTopic:[NSNumber numberWithInteger:self.qos]};
}


#pragma mark - Passwrod

- (NSString *)password {
    return [LFMQTTUtil macSignWithText:self.clientId secretKey:self.secretKey];
}

- (NSString *)userName {
    return [NSString stringWithFormat:@"Signature|%@|%@",self.accessKey,self.instanceId];
}

@end;
