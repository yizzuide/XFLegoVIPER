//
//  XFNetworkEmitter.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2018/1/18.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#import "XFNetworkEmitter.h"
#import <AFNetworking.h>

#define AFNetworkReachabilityStatusArray \
@"AFNetworkReachabilityStatusUnknown", \
@"AFNetworkReachabilityStatusNotReachable", \
@"AFNetworkReachabilityStatusReachableViaWWAN", \
@"AFNetworkReachabilityStatusReachableViaWiFi"

@implementation XFNetworkEmitter

- (void)prepare
{
    XF_Def_TypeStringArray(AFNetworkReachabilityStatusArray)
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 连接状态回调处理
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         [self.pipe emitEventName:XF_Func_TypeEnumToString(status+1, typeList) intentData:nil];
     }];
}

- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}
@end
