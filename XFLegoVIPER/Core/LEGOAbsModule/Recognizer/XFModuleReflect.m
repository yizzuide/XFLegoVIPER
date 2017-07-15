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
            return superModuleName;
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
        
        // 判断OC模块，如果没有设置前辍直接返回nil
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
        return nil;
    } else {
        // 如果传过来是一个模块层对象
        NSString *moduleClazzName = NSStringFromClass([module class]);
        if ([moduleClazzName containsString:@"."]) { // 是否含有swift命名空间
            return ns;
        } else {
            return classPrefix ?: @"";
        }
    }
}



+ (BOOL)verifyModule:(NSString *)moduleName stuffixName:(NSString *)stuffixName
{
    return [self inspectModulePrefixWithModule:moduleName stuffixName:stuffixName] != nil;
}

@end
