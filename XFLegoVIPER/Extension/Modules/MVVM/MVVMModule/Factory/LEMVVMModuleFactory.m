//
//  LEMVVMModuleFactory.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/30.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "LEMVVMModuleFactory.h"
#import "XFComponentManager.h"
#import "XFLegoMarco.h"
#import <objc/runtime.h>
#import "XFModuleReflect.h"
#import "XFComponentReflect.h"
#import "UIViewController+ComponentBridge.h"
#import "LEViewModel.h"

@implementation LEMVVMModuleFactory

+ (LEViewModel *)createViewModelFromModuleName:(NSString *)moduleName superModule:(NSString **)superModule {
    __kindof id<XFComponentRoutable> component = [XFComponentManager findComponentForName:moduleName];
    // 清除残留的组件
    if (component) {
        [component uiBus].uInterface = nil;
        [XFComponentManager removeComponent:component];
        component = nil;
    }
    
    Class clazz = [XFModuleReflect createDynamicSubModuleClassFromName:moduleName stuffixName:@"ViewModel" superModule:superModule];
    return [[clazz alloc] init];
}
@end
