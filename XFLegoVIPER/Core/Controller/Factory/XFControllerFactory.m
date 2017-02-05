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

@implementation XFControllerFactory

+ (UIViewController *)createControllerFromComponentName:(NSString *)componentName
{
    id<XFComponentRoutable> controller = [XFComponentManager findComponentForName:componentName];
    if (controller) {
        return (id)controller;
    }
    NSString *clazzName = [NSString stringWithFormat:@"%@%@%@",XF_Class_Prefix,componentName,@"ViewController"];
    return [[NSClassFromString(clazzName) alloc] init];
}

+ (UINavigationController *)createNavigationControllerFromPrefixName:(NSString *)prefixName withRootController:(UIViewController *)rootViewController {
    UINavigationController *nav;
    // 默认导航控制器
    if ([prefixName isEqualToString:@"UI"]) {
         nav = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    } else { // 自定义导航控制器
        NSString *className = [NSString stringWithFormat:@"%@NavigationController",prefixName];
        nav = [[NSClassFromString(className) alloc] initWithRootViewController:rootViewController];
    }
    
    return nav;
}
@end
