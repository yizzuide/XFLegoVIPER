//
//  XFInterfaceFactory.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/5.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFInterfaceFactory.h"
#import "XFRouting.h"
#import "XFRoutingFactory.h"
#import "XFLegoMarco.h"
#import "NSObject+XFLegoInvokeMethod.h"
#import "XFActivity.h"

@implementation XFInterfaceFactory

+ (__kindof id<XFUserInterfacePort>)createSubUInterfaceFromModuleName:(NSString *)moduleName parentUInterface:(__kindof id<XFUserInterfacePort>)parentUInterface
{
    XFRouting *parentRouting = [[parentUInterface eventHandler] valueForKey:@"_routing"];
    return [XFRoutingFactory createSubRoutingFromModuleName:moduleName forParentRouting:parentRouting].realInterface;
}

+ (__kindof id<XFUserInterfacePort>)createUInterfaceForMVxFromModuleName:(NSString *)moduleName asChildViewController:(BOOL)asChild
{
    XFRouting *routing = [XFRoutingFactory createRouingFromModuleName:moduleName];
    if (asChild) {
        routing.subRoute = YES;
    }
    return routing.realInterface;
}

+ (void)resetSubRoutingFromSubUserInterfaces:(NSArray *)subUserInterfaces forParentActivity:(__kindof id<XFUserInterfacePort>)parentUserInterface {
    NSMutableArray *subRoutings = @[].mutableCopy;
    for (__kindof id<XFUserInterfacePort> userInterface in subUserInterfaces) {
        XFActivity *subActivity = userInterface;
        // 如果子控制器是导航栏，取出顶部视图
        if ([userInterface isKindOfClass:[UINavigationController class]]) {
            UINavigationController *subNav = userInterface;
            subActivity = (id)subNav.topViewController;
        }
        XFRouting *subRouting = [[subActivity eventHandler] valueForKey:@"_routing"];
        [subRoutings addObject:subRouting];
    }
    XFRouting *parentRouting = [[parentUserInterface eventHandler] valueForKey:@"_routing"];
    [XFRoutingFactory resetSubRoutings:subRoutings forParentRouting:parentRouting];
}
@end
