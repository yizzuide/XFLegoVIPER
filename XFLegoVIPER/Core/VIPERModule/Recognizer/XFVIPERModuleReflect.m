//
//  XFVIPERModuleReflect.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/25.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFVIPERModuleReflect.h"
#import "XFRouting.h"
#import "XFRoutingLinkManager.h"
#import "XFControllerReflect.h"
#import <objc/runtime.h>
#import "XFLegoConfig.h"

@implementation XFVIPERModuleReflect

+ (NSString *)moduleNameForRouting:(XFRouting *)routing
{
    return [self moduleNameForRoutingClass:[routing class]];
}

+ (NSString *)moduleNameForModuleLayerObject:(id)moduleLayerObject
{
    if ([moduleLayerObject isKindOfClass:[XFRouting class]]) {
        return [self moduleNameForRouting:moduleLayerObject];
    }
    if ([moduleLayerObject isKindOfClass:NSClassFromString(@"XFPresenter")]) {
        return [self moduleNameForRouting:[moduleLayerObject valueForKeyPath:@"routing"]];
    }
    if ([moduleLayerObject isKindOfClass:NSClassFromString(@"UIViewController")]) {
        return [self moduleNameForRouting:[[moduleLayerObject valueForKeyPath:@"eventHandler"] valueForKeyPath:@"routing"]];
    }
    return nil;
}

+ (NSString *)moduleNameForRoutingClass:(Class)routingClass
{
    NSArray *simpleSuffix = @[@"Routing"];
    
    NSString *clazzName = NSStringFromClass(routingClass);
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


+ (NSString *)moduleNameForSuperRoutingClass:(Class)subRoutingClass
{
    return [self moduleNameForRoutingClass:[subRoutingClass superclass]];
}

+ (NSString *)moduleNameForModuleLayerClass:(Class)moduleLayerClass
{
    return [self moduleNameForModuleLayerObject:[[moduleLayerClass alloc] init]];
}

+ (Class)routingClassFromModuleName:(NSString *)moduleName
{
    NSString *prefixName = XF_Class_Prefix;
    const char * className = [[NSString stringWithFormat:@"%@%@Routing",prefixName,moduleName] cStringUsingEncoding:NSASCIIStringEncoding];
    Class clazz = objc_getClass(className);
    // 如果这个类不存在，就是动态创建, 这里用于共享的子模块
    if (!clazz)
    {
        // 获得父模块名
        NSString *superModuleName = [self inspectSuperModuleNameFromSubModuleName:moduleName];
        // 创建父路由类
        Class superClass = NSClassFromString([NSString stringWithFormat:@"%@%@Routing", prefixName, superModuleName]);
        NSAssert(superClass, @"不存这个类，请注意加上父模块名");
        // 创建子类
        clazz = objc_allocateClassPair(superClass, className, 0);
    }
    return clazz;
}

+ (BOOL)verifyModule:(NSString *)moduleName
{
    NSString *modulePrefix = XF_Class_Prefix;
    Class routingClass = NSClassFromString([NSString stringWithFormat:@"%@%@Routing",modulePrefix,moduleName]);
    // 如果没有对应路由类
    if (!routingClass) {
        // 检测是否有父模块
        NSString *superModuleName = [XFVIPERModuleReflect inspectSuperModuleNameFromSubModuleName:moduleName];
        // 如果与自己相同
        if ([superModuleName isEqualToString:moduleName]) {
            return NO;
        }
        // 是否能加载父路由类
        return !!NSClassFromString([NSString stringWithFormat:@"%@%@Routing",modulePrefix,superModuleName]);
    }
    return YES;
}

+ (BOOL)verifyModuleLinkForList:(NSArray<NSString *> *)modules
{
    // 只有一个路由，直接返回
    if (modules.count == 1) {
        return YES;
    }
    
    XFRouting *preRouting = [XFRoutingLinkManager findRoutingForModuleName:modules[XF_Index_First]];
    if (!preRouting) {
        return NO;
    }
    for (int i = XF_Index_Second; i < modules.count; i++) {
        // 是否是控制器组件
        if ([XFControllerReflect verifyController:modules[i]]) {
            return YES;
        }
        
        XFRouting *nextRouting = [XFRoutingLinkManager findRoutingForModuleName:modules[i]];
        // 忽略最后一个可能没有添加上的路由
        if (i == modules.count - 1 && !nextRouting) {
            return YES;
        }
        // 如果下一个路由找不到
        if (!nextRouting) {
            // 是否是共享的模块壳
            XFRouting *sharedRouting = [XFRoutingLinkManager currentActionRouting];
            NSString *componentName = [self moduleNameForModuleLayerObject:sharedRouting];
            // 模糊匹配模块名
            if ([componentName containsString:modules[i]]) {
                preRouting = sharedRouting;
                continue;
            }
            return NO;
        }
        // 判断父子关系
        if (nextRouting.parentRouting == preRouting) {
            preRouting = nextRouting;
            continue;
        }
        // 判断链路关系
        if (preRouting.nextRouting != nextRouting) {
            return  NO;
        }
        // 以下一个路由为起点
        preRouting = nextRouting;
    }
    return YES;
}

+ (void)inspectModulePrefixFromClass:(Class)clazz
{
    if (XF_Class_Prefix) return;
    // 开始解析模块前辍
    NSString *clazzName = NSStringFromClass(clazz);
    NSUInteger count = clazzName.length;
    NSMutableString *appendString = @"".mutableCopy;
    for (int i = 0; i < count; i++) {
        char c = [clazzName characterAtIndex:i];
        // 如果是小写
        if (c > 96 && c < 123) {
            [appendString deleteCharactersInRange:NSMakeRange(appendString.length - 1, 1)];
            break;
        }
        // 添加
        [appendString appendString:[NSString stringWithFormat:@"%c",c]];
    }
#ifdef LogDebug
    LogDebug(@"inspectModulePrefix: %@",appendString);
#elif (defined DEBUG)
    NSLog(@"inspectModulePrefix: %@",appendString);
#endif
    [[XFLegoConfig shareInstance] setClassPrefix:appendString];
}

// 从子模块名检测出父模块名
+ (NSString *)inspectSuperModuleNameFromSubModuleName:(NSString *)subModuleName
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
            NSMutableString *result = [NSMutableString string];
            for (NSUInteger j = appendString.length; j > 0; j--) {
                [result appendString:[appendString substringWithRange:NSMakeRange(j - 1, 1)]];
            }
            return result;
        }
    }
    return nil;
}
@end
