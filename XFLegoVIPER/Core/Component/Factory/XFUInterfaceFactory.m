//
//  XFUInterfaceFactory.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/10/5.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFUInterfaceFactory.h"
#import "XFRouting.h"
#import "XFRoutingFactory.h"
#import "XFLegoMarco.h"
#import "NSObject+XFLegoInvokeMethod.h"
#import "XFActivity.h"
#import "XFComponentReflect.h"
#import "XFUIBus.h"
#import "XFRoutingLinkManager.h"

@implementation XFUInterfaceFactory

+ (__kindof UIViewController *)createSubUInterfaceFromComponentName:(NSString *)componentName parentUInterface:(__kindof UIViewController *)parentUInterface
{
    Class<XFComponentHandlerPlug> matchedComponentHandler = [XFComponentReflect componentHandlerForComponent:componentName];
    id<XFComponentRoutable> component = [matchedComponentHandler createComponentFromName:componentName];
    return [self _subUIterfaceFromSubComponent:component parentUInterface:parentUInterface];
}

+ (__kindof UIViewController *)createSubUInterfaceFromURLComponent:(NSString *)url parentUInterface:(__kindof UIViewController *)parentUInterface
{
    id<XFComponentRoutable> component = [XFUIBus openURLForGetComponent:url];
    return [self _subUIterfaceFromSubComponent:component parentUInterface:parentUInterface];
}

+ (__kindof UIViewController *)_subUIterfaceFromSubComponent:(__kindof id<XFComponentRoutable>)component parentUInterface:(__kindof UIViewController *)parentUInterface
{
    if ([XFComponentReflect isVIPERModuleComponent:component]) {
        XFRouting *subRouting = [component routing];
        if ([parentUInterface eventHandler]) {
            XFRouting *parentRouting = [[parentUInterface eventHandler] valueForKey:@"_routing"];
            [XFRoutingLinkManager setSubRouting:subRouting forParentRouting:parentRouting];
        }
        return subRouting.realUInterface;
    }
    return [XFComponentReflect uInterfaceForComponent:component];
}


+ (void)resetSubUserInterfaces:(NSArray *)subUserInterfaces forParentActivity:(__kindof UIViewController *)parentUserInterface {
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
