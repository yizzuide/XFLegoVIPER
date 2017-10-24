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
    NSString *namespace = [LEGOConfig swiftNamespace];
    NSString *classPrefix = [LEGOConfig classPrefix];
    NSString *noneClassPrefix = @"";
    NSArray *classPrefixList = [LEGOConfig classPrefixList];
    NSUInteger count = subModuleName.length;
    NSMutableString *appendString = @"".mutableCopy;
    for (NSUInteger i = 0; i < count; i++) {
        char c = [subModuleName characterAtIndex:count - (i + 1)];
        // 添加
        [appendString appendString:[NSString stringWithFormat:@"%c",c]];

        // 如果是大写就开始检测
        if (c > 64 && c < 91) {
            // 翻转字符串
            NSMutableString *moduleName = [NSMutableString string];
            for (NSUInteger j = appendString.length; j > 0; j--) {
                [moduleName appendString:[appendString substringWithRange:NSMakeRange(j - 1, 1)]];
            }
            // 开始类匹配
            if ([self findClassFromPrefix:namespace moduleName:moduleName stuffixName:stuffixName superModuleName:nil] ||
                [self findClassFromPrefix:classPrefix moduleName:moduleName stuffixName:stuffixName superModuleName:nil] ||
                [self findClassFromPrefix:noneClassPrefix moduleName:moduleName stuffixName:stuffixName superModuleName:nil]) {
                return moduleName;
            } else {
                // 使用前辍列表来匹配
                if (classPrefixList.count) {
                    for (NSString *optClassPrefix in classPrefixList) {
                        if ([self findClassFromPrefix:optClassPrefix moduleName:moduleName stuffixName:stuffixName superModuleName:nil]) {
                            return moduleName;
                        }
                    }
                }
            }
        }
    }
    
    
    // 从前面往后找（虚拟组件只支持一个单词）
    /*NSUInteger count = subModuleName.length;
    for (NSUInteger i = 1; i < count; i++) {
        char c = [subModuleName characterAtIndex: i];
        // 如果是大写
        if (c > 64 && c < 91) {
            return [subModuleName substringFromIndex: i];
        }
    }*/
    return nil;
}

+ (NSString *)inspectModulePrefixWithModule:(id)module stuffixName:(NSString *)stuffixName
{
    NSString *namespace = [LEGOConfig swiftNamespace];
    NSString *classPrefix = [LEGOConfig classPrefix];
    NSArray *classPrefixList = [LEGOConfig classPrefixList];
    if ([module isKindOfClass:[NSString class]]) {
        NSString *moduleName = module;
        NSString *superModuleName = [self inspectSuperModuleNameFromSubModuleName:moduleName stuffixName:stuffixName];
        
        // 首先判断是否swift模块，因为如果全用swift写是不需要设置前辍的
        if ([self findClassFromPrefix:namespace moduleName:moduleName stuffixName:stuffixName superModuleName:superModuleName]) {
            return namespace;
        }
        
        // 判断OC模块
        if (classPrefix && [self findClassFromPrefix:classPrefix moduleName:moduleName stuffixName:stuffixName superModuleName:superModuleName]) {
            return classPrefix;
        }
        
        // 判断无类前辍的OC模块
        if ([self findClassFromPrefix:@"" moduleName:moduleName stuffixName:stuffixName superModuleName:superModuleName]) {
            return @"";
        }
        
        // 查找提供的前辍列表
        if (classPrefixList.count) {
            for (NSString *optClassPrefix in classPrefixList) {
                if ([self findClassFromPrefix:optClassPrefix moduleName:moduleName stuffixName:stuffixName superModuleName:superModuleName]) {
                    return optClassPrefix;
                }
            }
        }
        return nil;
    } else {
        // 如果传过来是一个模块层对象
        NSString *moduleClazzName = NSStringFromClass([module class]);
        if ([moduleClazzName containsString:@"."]) { // 是否含有swift命名空间
            return namespace;
        }
        
        // 是否是无前辍的模块（判断标准：第二个字母为小写）
        char c = [moduleClazzName characterAtIndex: 1];
        if (c > 96 && c < 123) { // 如果是小写
            return @"";
        }
        
        // 有前辍的模块，并且有统一的前辍
        if (classPrefix) {
            return classPrefix;
        }
        
        // 从前辍列表里找前辍
        NSString *frontPart = [moduleClazzName componentsSeparatedByString:stuffixName].firstObject;
        NSMutableString *prefixM = @"".mutableCopy;
        NSInteger len = moduleClazzName.length;
        for (NSString *optClassPrefix in classPrefixList) {
            for (NSInteger i = 0; i < len; i++) {
                char c = [frontPart characterAtIndex:i];
                [prefixM appendFormat:@"%c", c];
                // 长度大于2时开始匹配
                if (i >= 2) {
                    if ([optClassPrefix isEqualToString:prefixM]) {
                        return optClassPrefix;
                    }
                }
                // 长度大于4（不会有这么长的前辍），直接退出
                if (i > 4) {
                    return nil;
                }
            }
        }
        return nil;
    }
}

+ (BOOL)findClassFromPrefix:(NSString *)prefix moduleName:(NSString *)moduleName stuffixName:(NSString *)stuffixName superModuleName:(NSString *)superModuleName
{
    // 是否存在这个模块
    if (NSClassFromString([NSString stringWithFormat:@"%@%@%@",prefix,moduleName,stuffixName])) {
        return YES;
    }
    // 是否存在这个子模块
    if (superModuleName &&
        ![superModuleName isEqualToString:moduleName] &&
        NSClassFromString([NSString stringWithFormat:@"%@%@%@", prefix, superModuleName, stuffixName])) {
        return YES;
    }
    return NO;
}


+ (BOOL)verifyModule:(NSString *)moduleName stuffixName:(NSString *)stuffixName
{
    return [self inspectModulePrefixWithModule:moduleName stuffixName:stuffixName] != nil;
}

@end
