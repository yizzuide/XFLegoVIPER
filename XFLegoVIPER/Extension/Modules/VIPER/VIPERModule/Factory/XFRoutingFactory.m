//
//  XFRoutingFactory.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFRoutingFactory.h"
#import "XFRoutingLinkManager.h"
#import "XFRouting.h"
#import "XFModuleReflect.h"
#import "XFComponentManager.h"
#import "XFPresenter.h"
#import "NSObject+XFLegoInvokeMethod.h"

@implementation XFRoutingFactory

+ (XFRouting *)createRouingFromModuleName:(NSString *)moduleName {
    __kindof id<XFComponentRoutable> component = [XFComponentManager findComponentForName:moduleName];
    // 清除残留的组件
    if (component) {
        XFPresenter *preseter = component;
        [preseter setValue:nil forKey:@"userInterface"];
        [XFComponentManager removeComponent:component];
        component = nil;
    }
    XFRouting *routing = [XFRoutingLinkManager findRoutingForModuleName:moduleName];
    if (routing) {
        [XFRoutingLinkManager removeRouting:routing];
        routing = nil;
    }
    
    // 从新创建
    return [self createRoutingFastFromModuleName:moduleName];
}

+ (XFRouting *)createRoutingFastFromModuleName:(NSString *)moduleName {
    // 查找并实例化
    Class routingClass = [XFModuleReflect createDynamicSubModuleClassFromName:moduleName stuffixName:@"Routing" superModule:nil];
    if (routingClass) {
        return [routingClass assembleRouting];
    }
    return nil;
}

+ (void)resetSubRoutings:(NSArray *)subRoutings forParentRouting:(XFRouting *)parentRouting {
    for (XFRouting *subRouting in subRoutings) {
        [parentRouting addSubRouting:subRouting asChildViewController:NO];
    }
}
@end
