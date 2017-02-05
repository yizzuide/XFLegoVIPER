//
//  XFRoutingFactory.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFRoutingFactory.h"
#import "XFRoutingLinkManager.h"
#import "XFRouting.h"
#import "XFVIPERModuleReflect.h"

@implementation XFRoutingFactory

+ (XFRouting *)createRouingFromModuleName:(NSString *)moduleName {
    // 返回已经创建的模块视图
    XFRouting *routing = [XFRoutingLinkManager findRoutingForModuleName:moduleName];
    if (routing) {
        return routing;
    }
    // 从新创建
    return [self createRoutingFastFromModuleName:moduleName];
}

+ (XFRouting *)createRoutingFastFromModuleName:(NSString *)moduleName {
    // 查找并实例化
    NSString *prefixName = XF_Class_Prefix;
    if (prefixName == nil) return nil;
    Class routingClass = [XFVIPERModuleReflect routingClassFromModuleName:moduleName];
    if (routingClass) {
        return [routingClass assembleRouting];
    }
    return nil;
}

+ (void)resetSubRoutings:(NSArray *)subRoutings forParentRouting:(XFRouting *)parentRouting {
    for (XFRouting *subRouting in subRoutings) {
        [parentRouting addSubRouting:subRouting asChildViewController:NO];
    }
}
@end
