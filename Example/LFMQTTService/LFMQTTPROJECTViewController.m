//
//  LFMQTTPROJECTViewController.m
//  LFMQTTService
//
//  Created by lf_sytc@hotmail.com on 09/10/2019.
//  Copyright (c) 2019 lf_sytc@hotmail.com. All rights reserved.
//

#import "LFMQTTPROJECTViewController.h"

#import <LFMQTTService/LFMQTTService.h>
@interface LFMQTTPROJECTViewController ()

@end

@implementation LFMQTTPROJECTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"MQTT测试页";
    
    //配置连接信息
    [[LFMQTTService sharedInstance] configHost:@""
                                          port:1883
                                        useSSL:NO
                                      keeplive:60];
    //配置收发消息类型
    [[LFMQTTService sharedInstance] configClean:YES qos:0];
    
    
    //配置秘钥
    [[LFMQTTService sharedInstance] configEnv:LFMQTTEnvType_Preview
                                     deviceID:@""
                                    accessKey:@""
                                   instanceId:@""
                                    secretKey:@""];
    
    [[LFMQTTService sharedInstance] startToConnect:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
