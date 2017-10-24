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
#import <objc/runtime.h>
#import "XFLegoConfig.h"
#import "XFModuleReflect.h"

@implementation XFVIPERModuleReflect

+ (NSString *)moduleNameForRouting:(XFRouting *)routing
{
    NSString *stuffixName = @"Routing";
    NSString *modulePrefix = [XFModuleReflect inspectModulePrefixWithModule:routing stuffixName:stuffixName];
    NSString *clazzName = NSStringFromClass(routing.class);
    if (modulePrefix) {
        NSString *lastPart = [clazzName componentsSeparatedByString:modulePrefix].lastObject;
        return [lastPart componentsSeparatedByString:stuffixName].firstObject;
    } else {
        return [clazzName componentsSeparatedByString:stuffixName].firstObject;
    }
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

+ (NSString *)moduleNameForSuperRoutingClass:(Class)subRoutingClass
{
    NSAssert([NSStringFromClass([subRoutingClass superclass]) containsString:@"Routing"], @"当前路由类的父类不是一个路由类！");
    return [self moduleNameForRouting:[[[subRoutingClass superclass] alloc] init]];
}

/*+ (NSString *)moduleNameForModuleLayerClass:(Class)moduleLayerClass
{
    return [self moduleNameForModuleLayerObject:[[moduleLayerClass alloc] init]];
}*/

/*+ (BOOL)verifyModuleLinkForList:(NSArray<NSString *> *)modules
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
}*/

+ (void)inspectModulePrefixFromClass:(Class)clazz
{
    if (XF_Class_Prefix || [LEGOConfig classPrefixList].count) return;
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
@end
