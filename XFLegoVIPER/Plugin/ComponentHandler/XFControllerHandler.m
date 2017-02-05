//
//  XFControllerHandler.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/23.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "XFControllerHandler.h"
#import "XFControllerFactory.h"
#import "UIViewController+ComponentBridge.h"
#import "XFControllerReflect.h"

@implementation XFControllerHandler

+ (BOOL)matchComponent:(id)component
{
    if ([component isKindOfClass:[NSString class]]) {
        return [XFControllerReflect verifyController:component];
    }
    return [component respondsToSelector:@selector(parentViewController)];
}

+ (BOOL)matchUInterface:(UIViewController *)uInterface
{
    return YES;
}

+ (id<XFComponentRoutable>)createComponentFromName:(NSString *)componentName
{
    return (id)[XFControllerFactory createControllerFromComponentName:componentName];
}

+ (NSString *)componentNameFromComponent:(id<XFComponentRoutable>)component
{
    return [XFControllerReflect controllerNameForComponent:component];
}

+ (UIViewController *)uInterfaceForComponent:(id<XFComponentRoutable>)component
{
    return (id)component;
}

+ (id<XFComponentRoutable>)componentForUInterface:(UIViewController *)uInterface
{
    return (id)uInterface;
}

+ (id<XFComponentRoutable>)component:(__kindof id<XFComponentRoutable>)component createNextComponentFromName:(NSString *)componentName
{
    return [self createComponentFromName:componentName];
}

+ (void)willRemoveComponent:(__kindof id<XFComponentRoutable>)component
{
}

+ (void)willReleaseComponent:(__kindof id<XFComponentRoutable>)component
{
}
@end
