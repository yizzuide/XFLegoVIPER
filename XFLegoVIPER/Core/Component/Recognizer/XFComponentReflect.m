//
//  XFComponentReflect.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/20.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFComponentReflect.h"
#import "XFRouting.h"
#import "XFRoutingReflect.h"
#import "XFControllerReflect.h"
#import "XFComponentManager.h"
#import "XFRoutingLinkManager.h"

@implementation XFComponentReflect


+ (NSString *)componentNameForComponent:(id<XFComponentRoutable>)component {
    if ([self isModuleComponent:component]) {
        return [XFRoutingReflect moduleNameForComponentObject:component];
    }
    return [XFControllerReflect controllerNameForComponent:component];
}

+ (BOOL)isComponentForName:(NSString *)name
{
    if ([XFRoutingReflect verifyModule:name]) {
        return YES;
    }
    if ([XFControllerReflect verifyController:name]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isModuleComponent:(id)component {
    if ([component isKindOfClass:[NSString class]]) {
        return [XFRoutingReflect verifyModule:component];
    }
    return IS_Module(component);
}

+ (BOOL)isControllerComponent:(id)component {
    if ([component isKindOfClass:[NSString class]]) {
        return [XFControllerReflect verifyController:component];
    }
    return !IS_Module(component);
}

+ (UIViewController *)interfaceForComponent:(__kindof id<XFComponentRoutable>)component {
    UIViewController *currentInterface;
    if ([XFComponentReflect isModuleComponent:component]) { // 模块组件
        XFRouting *routing = [component valueForKeyPath:@"routing"];
        currentInterface = routing.realInterface;
    }else{ // 控制器组件
        UIViewController<XFComponentRoutable> *viewController = component;
        currentInterface = viewController;
    }
    return currentInterface;
}

+ (NSString *)componentNameForInterface:(UIViewController *)interface
{
    if ([interface valueForKeyPath:@"eventHandler"]) { // 模块组件
        return [XFRoutingReflect moduleNameForComponentObject:interface];
    }
    return [XFControllerReflect controllerNameForComponent:(id)interface];
}

+ (id<XFComponentRoutable>)componentForInterface:(UIViewController *)interface
{
    if ([interface valueForKeyPath:@"eventHandler"]) { // 模块组件
        return [interface valueForKeyPath:@"eventHandler"];
    }
    return (id)interface;
}
@end
