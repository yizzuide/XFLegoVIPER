//
//  XFNetworkEmitter.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2018/1/18.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#import "XFNetworkEmitter.h"
#import <AFNetworking.h>

@implementation XFNetworkEmitter

- (void)prepare
{
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 连接状态回调处理
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         // 框架会自动注入这个pipe对象，无需自己创建
         [self.pipe emitEventName:@"Event_AFNetworkReachabilityStatus" intentData:@{@"status":@(status)}];
     }];
}

- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}
@end
