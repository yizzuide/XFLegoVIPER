//
//  XFRoutingReflect.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/25.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFRoutingReflect.h"
#import "XFRouting.h"
#import "XFRoutingLinkManager.h"
#import "XFControllerReflect.h"

@implementation XFRoutingReflect

+ (NSString *)moduleNameForRouting:(XFRouting *)routing
{
    NSArray *simpleSuffix = @[@"Routing"];
    NSString *clazzName = NSStringFromClass([routing class]);
    
    NSUInteger index = XF_Index_First;
    NSRange suffixRange;
    do {
        if (index == simpleSuffix.count) {
            return clazzName;
        }
        suffixRange = [clazzName rangeOfString:simpleSuffix[index++]];
    } while (suffixRange.location <= XF_Index_First);
    
    NSInteger len = [XFRoutingLinkManager modulePrefix].length;
    NSRange moduleRange = NSMakeRange(len, suffixRange.location - len);
    NSString *moduleName = [clazzName substringWithRange:moduleRange];
    return moduleName;
}

+ (NSString *)moduleNameForComponentObject:(id)componentObject
{
    if ([componentObject isKindOfClass:[XFRouting class]]) {
        return [self moduleNameForRouting:componentObject];
    }
    if ([componentObject isKindOfClass:NSClassFromString(@"XFPresenter")]) {
        return [self moduleNameForRouting:[componentObject valueForKeyPath:@"routing"]];
    }
    if ([componentObject isKindOfClass:NSClassFromString(@"UIViewController")]) {
        return [self moduleNameForRouting:[[componentObject valueForKeyPath:@"eventHandler"] valueForKeyPath:@"routing"]];
    }
    return nil;
}

+ (BOOL)verifyModule:(NSString *)moduleName
{
    NSString *modulePrefix = [XFRoutingLinkManager modulePrefix];
    return !!NSClassFromString([NSString stringWithFormat:@"%@%@Routing",modulePrefix,moduleName]);
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
            NSString *componentName = [self moduleNameForComponentObject:sharedRouting];
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
    if ([XFRoutingLinkManager modulePrefix]) return;
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
    [XFRoutingLinkManager setModulePrefix:appendString];
}
@end
