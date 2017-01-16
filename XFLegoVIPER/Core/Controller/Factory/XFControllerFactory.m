//
//  XFControllerFactory.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFControllerFactory.h"
#import "XFRoutingLinkManager.h"

@implementation XFControllerFactory

+ (UIViewController *)controllerFromComponentName:(NSString *)componentName
{
    NSString *clazzName = [NSString stringWithFormat:@"%@%@%@",[XFRoutingLinkManager modulePrefix],componentName,@"ViewController"];
    return [[NSClassFromString(clazzName) alloc] init];
}

+ (UINavigationController *)navigationControllerFromPrefixName:(NSString *)prefixName withRootController:(UIViewController *)rootViewController {
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
