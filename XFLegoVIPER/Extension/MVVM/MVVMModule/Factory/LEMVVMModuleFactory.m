//
//  LEMVVMModuleFactory.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/30.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "LEMVVMModuleFactory.h"
#import "XFComponentManager.h"
#import "XFUIBus.h"
#import "XFLegoMarco.h"
#import "LEViewProtocol.h"

@implementation LEMVVMModuleFactory

+ (LEViewModel *)createViewModelFromModuleName:(NSString *)moduleName {
    id<XFComponentRoutable> component = [XFComponentManager findComponentForName:moduleName];
    if (component) return (id)component;
    NSString *clazzName = [NSString stringWithFormat:@"%@%@%@",XF_Class_Prefix,moduleName,@"ViewModel"];
    return [[NSClassFromString(clazzName) alloc] init];
}
@end
