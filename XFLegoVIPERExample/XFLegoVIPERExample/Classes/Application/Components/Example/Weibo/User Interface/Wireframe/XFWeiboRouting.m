//
//  XFWeiboRouting.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2016/10/27.
//    Copyright © 2016年 Yizzuide. All rights reserved.
//


#import "XFWeiboRouting.h"
#import "XFRoutingLinkManager.h"
#import "XFComponentManager.h"

@implementation XFWeiboRouting

// 组装模块
XF_AutoAssemblyModule_Fast

- (void)pop2Root
{
    [self.uiBus popComponent:@"Search" animated:YES];
}

@end
