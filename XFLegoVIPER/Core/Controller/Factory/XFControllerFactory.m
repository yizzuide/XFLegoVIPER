//
//  XFControllerFactory.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFControllerFactory.h"
#import "XFComponentManager.h"
#import "XFLegoMarco.h"
#import "XFModuleReflect.h"

@implementation XFControllerFactory

+ (UIViewController *)createControllerFromComponentName:(NSString *)componentName
{
    id<XFComponentRoutable> controller = [XFComponentManager findComponentForName:componentName];
    if (controller) {
        return (id)controller;
    }
    Class clazz = [XFModuleReflect createDynamicSubModuleClassFromName:componentName stuffixName:@"ViewController" superModule:nil];
    return [[clazz alloc] init];
}

+ (UINavigationController *)createNavigationControllerFromPrefixName:(NSString *)prefixName withRootController:(UIViewController *)rootViewController {
    // 默认导航控制器
    if ([prefixName isEqualToString:@"UI"]) {
         return  [[UINavigationController alloc] initWithRootViewController:rootViewController];
    }
    // 自定义导航控制器
    NSString *className = [NSString stringWithFormat:@"%@NavigationController",prefixName];
    return [self createNavigationControllerFromClassName:className withRootController:rootViewController];
}

+ (UINavigationController *)createNavigationControllerFromClassName:(NSString *)className withRootController:(UIViewController *)rootViewController {
    return [[NSClassFromString(className) alloc] initWithRootViewController:rootViewController];
}
@end
