//
//  LEMVVMModuleReflect.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/29.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "LEMVVMModuleReflect.h"
#import "XFLegoMarco.h"
#import "XFModuleReflect.h"
#import "LEViewModel.h"

@implementation LEMVVMModuleReflect

+ (BOOL)verifyModuleName:(NSString *)moduleName {
    return [XFModuleReflect verifyModule:moduleName stuffixName:@"ViewModel"];
}

+ (NSString *)moduleNameForViewModel:(LEViewModel<XFComponentRoutable> *)viewModel {
    NSString *stuffixName = @"ViewModel";
    NSString *modulePrefix = [XFModuleReflect inspectModulePrefixWithModule:viewModel stuffixName:stuffixName];
    NSString *clazzName = NSStringFromClass(viewModel.class);
    if (modulePrefix) {
        NSString *lastPart = [clazzName componentsSeparatedByString:modulePrefix].lastObject;
        return [lastPart componentsSeparatedByString:stuffixName].firstObject;
    } else {
        return [clazzName componentsSeparatedByString:stuffixName].firstObject;
    }
}

@end
