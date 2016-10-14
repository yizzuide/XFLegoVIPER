//
//  XFInterfaceFactory.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/5.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFInterfaceFactory.h"
#import "XFRoutingLinkManager.h"
#import "XFLegoMarco.h"

@implementation XFInterfaceFactory

+ (__kindof id<XFUserInterfacePort>)createSubUInterfaceFromMoudleName:(NSString *)moudleName parentUInterface:(__kindof id<XFUserInterfacePort>)parentUInterface
{
    // 返回已经创建的模块视图
    XFRouting *routing = [XFRoutingLinkManager findRoutingForMoudleName:moudleName];
    if (routing) {
        return routing.realInterface;
    }
    Class routingClass;
    NSString *clazzName = NSStringFromClass([parentUInterface class]);
    NSUInteger findIndex = XF_Index_Second;
    NSString *prefixName;
    do {
        if (findIndex > clazzName.length * 0.5) return nil;
        prefixName = [clazzName substringToIndex:findIndex++];
        NSString *routingClassName = [NSString stringWithFormat:@"%@%@%@",prefixName,moudleName,@"Routing"];
        routingClass = NSClassFromString(routingClassName);
    } while (!routingClass);
    
    // 返回新创建的模块视图
    return [XFRoutingLinkManager produceSubRoutingFromClass:routingClass parentUInterface:parentUInterface].realInterface;
}

+ (__kindof id<XFUserInterfacePort>)createUInterfaceForMVxFromMoudleName:(NSString *)moudleName prefix:(NSString *)prefixName asChildViewController:(BOOL)asChild
{
    // 返回已经创建的模块视图
    XFRouting *routing = [XFRoutingLinkManager findRoutingForMoudleName:moudleName];
    if (routing) {
        return routing.realInterface;
    }
    
    if (prefixName == nil) prefixName = [XFRoutingLinkManager moudlePrefix];
    if (prefixName == nil) return nil;
    
    NSString *routingClassName = [NSString stringWithFormat:@"%@%@%@",prefixName,moudleName,@"Routing"];
    Class routingClass = NSClassFromString(routingClassName);
    
    routing = [routingClass routing];
    if (asChild) {
        routing.subRoute = YES;
    }
    return routing.realInterface;
}
@end
