//
//  LEMVVMModuleReflect.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/29.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "LEMVVMModuleReflect.h"
#import "XFLegoMarco.h"

@implementation LEMVVMModuleReflect

+ (BOOL)verifyModuleName:(NSString *)moduleName {
    Class vmClass = NSClassFromString([NSString stringWithFormat:@"%@%@ViewModel",XF_Class_Prefix,moduleName]);
    return vmClass;
}

+ (NSString *)moduleNameForViewModel:(LEViewModel<XFComponentRoutable> *)viewModel {
    NSArray *simpleSuffix = @[@"ViewModel"];
    
    NSString *clazzName = NSStringFromClass(viewModel.class);
    NSUInteger index = XF_Index_First;
    NSRange suffixRange;
    do {
        if (index == simpleSuffix.count) {
            return clazzName;
        }
        suffixRange = [clazzName rangeOfString:simpleSuffix[index++]];
    } while (suffixRange.location <= XF_Index_First);
    
    NSInteger len = XF_Class_Prefix.length;
    NSRange moduleRange = NSMakeRange(len, suffixRange.location - len);
    NSString *moduleName = [clazzName substringWithRange:moduleRange];
    return moduleName;
}

@end
