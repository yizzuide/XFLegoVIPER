//
//  XFModuleReflect.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/3/15.
//  Copyright © 2017年 Yizzuide. All rights reserved.
//

#import "XFModuleReflect.h"
#import <objc/runtime.h>
#import "XFLegoMarco.h"

@implementation XFModuleReflect

+ (Class)createDynamicSubModuleClassFromName:(NSString *)subModuleName stuffixName:(NSString *)stuffixName superModule:(NSString **)superModule
{
    const char * className = [[NSString stringWithFormat:@"%@%@%@",XF_Class_Prefix,subModuleName,stuffixName] cStringUsingEncoding:NSASCIIStringEncoding];
    Class clazz = objc_getClass(className);
    // 如果这个类不存在，就是动态创建, 这里用于共享的子模块
    if (!clazz)
    {
        // 获得父模块名
        NSString *superModuleName = [self inspectSuperModuleNameFromSubModuleName:subModuleName stuffixName:stuffixName];
        if (superModule) {
            *superModule = superModuleName;
        }
        // 创建父模块类
        Class superClass = NSClassFromString([NSString stringWithFormat:@"%@%@%@", XF_Class_Prefix, superModuleName, stuffixName]);
        NSAssert(superClass, @"动态创建失败！不存这个类，请注意加上父模块名！");
        // 创建子类
        return objc_allocateClassPair(superClass, className, 0);
    }
    return clazz;
}

// 从子模块名检测出父模块名
+ (NSString *)inspectSuperModuleNameFromSubModuleName:(NSString *)subModuleName stuffixName:(NSString *)stuffixName
{
    NSUInteger count = subModuleName.length;
    NSMutableString *appendString = @"".mutableCopy;
    for (NSUInteger i = 0; i < count; i++) {
        char c = [subModuleName characterAtIndex:count - (i + 1)];
        // 添加
        [appendString appendString:[NSString stringWithFormat:@"%c",c]];
        // 如果是大写
        if (c > 64 && c < 91) {
            // 翻转字符串
            NSMutableString *superModuleName = [NSMutableString string];
            for (NSUInteger j = appendString.length; j > 0; j--) {
                [superModuleName appendString:[appendString substringWithRange:NSMakeRange(j - 1, 1)]];
            }
            // 如果有这个父类，直接返回
            if (NSClassFromString([NSString stringWithFormat:@"%@%@%@",XF_Class_Prefix,superModuleName,stuffixName])) {
                return superModuleName;
            }
        }
    }
    return nil;
}

+ (BOOL)verifyModule:(NSString *)moduleName stuffixName:(NSString *)stuffixName
{
    NSString *modulePrefix = XF_Class_Prefix;
    Class subModuleClass = NSClassFromString([NSString stringWithFormat:@"%@%@%@",modulePrefix,moduleName,stuffixName]);
    // 如果没有对应类
    if (!subModuleClass) {
        // 检测是否有父模块
        NSString *superModuleName = [self inspectSuperModuleNameFromSubModuleName:moduleName stuffixName:stuffixName];
        if (!superModuleName) return NO;
        // 如果与自己相同
        if ([superModuleName isEqualToString:moduleName]) {
            return NO;
        }
    }
    return YES;
}

@end
