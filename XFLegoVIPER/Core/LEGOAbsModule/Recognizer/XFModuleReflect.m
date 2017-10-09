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
#import "XFLegoConfig.h"

@implementation XFModuleReflect

+ (Class)createDynamicSubModuleClassFromName:(NSString *)subModuleName stuffixName:(NSString *)stuffixName superModule:(NSString **)superModule
{
    NSString *modulePrefix = [self inspectModulePrefixWithModule:(id)subModuleName stuffixName:(NSString *)stuffixName];
    const char * className = [[NSString stringWithFormat:@"%@%@%@",modulePrefix,subModuleName,stuffixName]cStringUsingEncoding:NSASCIIStringEncoding];
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
        Class superClass = NSClassFromString([NSString stringWithFormat:@"%@%@%@", modulePrefix, superModuleName, stuffixName]);
        NSAssert(superClass, @"动态创建失败！不存这个类，请注意加上父模块名！");
        // 创建子类
        Class subClazz = objc_allocateClassPair(superClass, className, 0);
        return subClazz;
    }
    return clazz;
}

// 从子模块名检测出父模块名
+ (NSString *)inspectSuperModuleNameFromSubModuleName:(NSString *)subModuleName stuffixName:(NSString *)stuffixName
{
    // 从后往前找方案
    /*NSUInteger count = subModuleName.length;
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
            return superModuleName;
        }
    }*/
    
    // 从前面往后找
    NSUInteger count = subModuleName.length;
    for (NSUInteger i = 1; i < count; i++) {
        char c = [subModuleName characterAtIndex: i];
        // 如果是大写
        if (c > 64 && c < 91) {
            return [subModuleName substringFromIndex: i];
        }
    }
    return nil;
}

+ (NSString *)inspectModulePrefixWithModule:(id)module stuffixName:(NSString *)stuffixName
{
    NSString *ns = [[XFLegoConfig shareInstance] swiftNamespace];
    NSString *classPrefix = [[XFLegoConfig shareInstance] classPrefix];
    
    if ([module isKindOfClass:[NSString class]]) {
        NSString *moduleName = module;
        // 首先判断是否swift模块，因为如果全用swift写是不需要设置前辍的
        // 是否存在这个swift模块
        if (NSClassFromString([NSString stringWithFormat:@"%@%@%@",ns,moduleName,stuffixName])) {
            return ns;
        }
        NSString *superModuleName = [self inspectSuperModuleNameFromSubModuleName:moduleName stuffixName:stuffixName];
        // 是否存在这个swift子模块
        if (superModuleName &&
            ![superModuleName isEqualToString:moduleName] &&
            NSClassFromString([NSString stringWithFormat:@"%@%@%@", ns, superModuleName, stuffixName])) {
            return ns;
        }
        
        // 判断OC模块
        // 是否存在这个OC模块
        if (NSClassFromString([NSString stringWithFormat:@"%@%@%@",classPrefix,moduleName,stuffixName])) {
            return classPrefix ?: @"";
        }
        // 是否存在这个OC子模块
        if (superModuleName &&
            ![superModuleName isEqualToString:moduleName] &&
            NSClassFromString([NSString stringWithFormat:@"%@%@%@", classPrefix, superModuleName, stuffixName])) {
            return classPrefix  ?: @"";
        }
        
        // 判断无类前辍的OC模块
        // 是否存在这个OC模块
        if (NSClassFromString([NSString stringWithFormat:@"%@%@",moduleName,stuffixName])) {
            return @"";
        }
        // 是否存在这个OC子模块
        if (superModuleName &&
            ![superModuleName isEqualToString:moduleName] &&
            NSClassFromString([NSString stringWithFormat:@"%@%@", superModuleName, stuffixName])) {
            return @"";
        }
        return nil;
    } else {
        // 如果传过来是一个模块层对象
        NSString *moduleClazzName = NSStringFromClass([module class]);
        if ([moduleClazzName containsString:@"."]) { // 是否含有swift命名空间
            return ns;
        } else {
            // 是否是无前辍的模块
            char c = [moduleClazzName characterAtIndex: 1];
            if (c > 96 && c < 123) { // 如果是小写
                return @"";
            }
            // 有前辍的模块
            return classPrefix ?: @"";
        }
    }
}



+ (BOOL)verifyModule:(NSString *)moduleName stuffixName:(NSString *)stuffixName
{
    return [self inspectModulePrefixWithModule:moduleName stuffixName:stuffixName] != nil;
}

@end
