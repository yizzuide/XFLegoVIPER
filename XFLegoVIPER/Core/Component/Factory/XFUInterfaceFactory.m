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
#import "XFComponentReflect.h"
#import "XFUIBus.h"
#import "XFComponentManager.h"

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
    // 添加子组件到容器，为了不妨碍父组件的跟踪功能，使用延后处理
    LEGORunAfter0_015({
        [XFComponentManager addComponent:component enableLog:NO];
    })
    Class<XFComponentHandlerPlug> matchedComponentHandler = [XFComponentReflect componentHandlerForComponent:component];
    return [matchedComponentHandler subUIterfaceFromSubComponent:component parentUInterface:parentUInterface];
}

@end
