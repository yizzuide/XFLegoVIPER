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

+ (BOOL)isViewControllerComponent:(NSString *)componentName
{
    NSString *clazzName = [NSString stringWithFormat:@"%@%@%@",[XFRoutingLinkManager modulePrefix],componentName,@"ViewController"];
    if (NSClassFromString(clazzName)) {
        return YES;
    }
    return NO;
}

+ (UIViewController *)controllerFromComponentName:(NSString *)componentName
{
    NSString *clazzName = [NSString stringWithFormat:@"%@%@%@",[XFRoutingLinkManager modulePrefix],componentName,@"ViewController"];
    return [[NSClassFromString(clazzName) alloc] init];
}
@end
