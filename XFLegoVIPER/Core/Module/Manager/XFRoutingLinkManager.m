//
//  XFRoutingLinkManager.m
//  XFLegoVIPER
//
//  Created by 付星 on 16/9/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "NSObject+XFLegoInvokeMethod.h"
#import "XFLegoMarco.h"
#import "XFRouting.h"
#import "XFRoutingLinkManager.h"
#import "XFRoutingReflect.h"


@implementation XFRoutingLinkManager

/**
 *  路由容器
 */
static NSMapTable *linkRoutingTable_;
/**
 *  路由名有序列表
 */
static NSMutableArray *linkRoutingKeyArr_;
/**
 *  跟踪一个将要发起跳转动作的路由
 */
static NSHashTable *trackActionRoutingTable_;

/**
 * 存储共享路由
 */
static NSMapTable *sharedRoutingTable_;

+ (void)initialize
{
    if (self == [XFRoutingLinkManager class]) {
        linkRoutingTable_ = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
        linkRoutingKeyArr_ = [NSMutableArray array];
        
        trackActionRoutingTable_ = [NSHashTable weakObjectsHashTable];
        sharedRoutingTable_ =[NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
    }
}

#pragma mark - 模块管理
+ (void)addRouting:(XFRouting *)routing {
    NSString *key = modulePrefix_ ? [XFRoutingReflect moduleNameForRouting:routing] : NSStringFromClass([routing class]);
    [linkRoutingTable_ setObject:routing forKey:key];
    [linkRoutingKeyArr_ addObject:key];
}

+ (void)removeRouting:(XFRouting *)routing {
    NSString *key = modulePrefix_ ? [XFRoutingReflect moduleNameForRouting:routing] : NSStringFromClass([routing class]);
    [linkRoutingTable_ removeObjectForKey:key];
    [linkRoutingKeyArr_ removeObject:key];
}

+ (NSInteger)count
{
    return linkRoutingTable_.count;
}

+ (void)setCurrentActionRounting:(XFRouting *)routing
{
    [trackActionRoutingTable_ removeAllObjects];
    if (routing) {
        [trackActionRoutingTable_ addObject:routing];
    }
}

+ (XFRouting *)currentActionRouting
{
    return [trackActionRoutingTable_ anyObject];
}

+ (void)setSharedRounting:(XFRouting *)routing shareModule:(NSString *)moduleName
{
    [sharedRoutingTable_ setObject:routing forKey:moduleName];
}

+ (XFRouting *)sharedRoutingForShareModule:(NSString *)moduleName
{
    if (!moduleName) return nil;
    return [sharedRoutingTable_ objectForKey:moduleName];
}

#pragma mark - 模块通信
+ (void)sendEventName:(NSString *)eventName intentData:(id)intentData forModulesName:(NSArray<NSString *> *)modulesName
{
    for (NSString *moduleName in modulesName) {
        // 找到对应模块路由
        XFRouting *routing = [self findRoutingForModuleName:moduleName];
        // 通知路由发送事件
        [routing.uiOperator receiveComponentEventName:eventName intentData:intentData];
    }
}

#pragma mark - 模块查找
+ (XFRouting *)findRoutingForModuleName:(NSString *)moduleName {
    NSEnumerator *keys = linkRoutingTable_.keyEnumerator;
    for (NSString *key in keys) {
        BOOL condition = modulePrefix_ ? [key isEqualToString:moduleName] : [key containsString:moduleName];
        if (condition) {
            return [linkRoutingTable_ objectForKey:key];
        }
    }
    return nil;
}

#pragma mark - 模块前辍
static NSString *modulePrefix_;
+ (void)setModulePrefix:(NSString *)prefix
{
    modulePrefix_ = prefix;
}

+ (NSString *)modulePrefix
{
    return modulePrefix_;
}

#pragma mark - Debug
static BOOL enableLog_ = NO;
+ (void)enableLog {
    enableLog_ = YES;
}

+ (void)log {
#ifdef DEBUG
    if (enableLog_) {
#ifdef LogDebug
        LogDebug(@"current routing count: %zd",linkRoutingTable_.count);
        LogDebug(@"Routing link:");
#elif (defined DEBUG)
        NSLog(@"current routing count: %zd",linkRoutingTable_.count);
        NSLog(@"Routing link:");
#endif
        
        NSMutableString *logStrM = [NSMutableString string];
        NSUInteger count = linkRoutingKeyArr_.count;
        NSUInteger routingCount = 0;
        NSUInteger subRoutingCount = 0;
        for (int i = 0; i < count; i++) {
            XFRouting *routing = [linkRoutingTable_ objectForKey:linkRoutingKeyArr_[i]];
            // 过滤掉非根路由
            if (routing.previousRouting) {
                break;
            }
            NSString *firstFix = [NSString stringWithFormat:@"\nRoot Routing(%zd): (\n\t%@",routingCount,NSStringFromClass([routing class])];
            routingCount++;
            if (routing.isSubRoute && routing.parentRouting) {
                firstFix = [NSString stringWithFormat:@"\nSub Routing from %@(%zd): (\n\t%@",NSStringFromClass([routing.parentRouting class]),subRoutingCount,NSStringFromClass([routing class])];
                routingCount--;
                subRoutingCount++;
            }
            [logStrM appendString:firstFix];
            
            XFRouting *nextRouting = routing;
            NSUInteger subRoutingDepthCount = 1;
            do {
                // 打印子路由
                NSArray<XFRouting *> *subRoutings = [nextRouting valueForKey:@"_subRoutings"];
                if (subRoutings) {
                    [logStrM appendString:@"\n"];
                    for (NSUInteger t = 0; t < subRoutingDepthCount; t++) {
                        [logStrM appendString:@"\t"];
                    }
                    [logStrM appendString:@"Sub Routing: ("];
                    for (XFRouting *subRouting in subRoutings) {
                        [logStrM appendString:@"\n"];
                        for (NSUInteger t = 0; t < subRoutingDepthCount * 2; t++) {
                            [logStrM appendString:@"\t"];
                        }
                        [logStrM appendString:[NSString stringWithFormat:@"%@",NSStringFromClass([subRouting class])]];
                    }
                    [logStrM appendString:@"\n"];
                    for (NSUInteger t = 0; t < subRoutingDepthCount; t++) {
                        [logStrM appendString:@"\t"];
                    }
                    [logStrM appendString:@")"];
                    
                    subRoutingDepthCount++;
                }
                
                // 打印下一个关连的路由
                nextRouting = nextRouting.nextRouting;
                if (nextRouting != nil) {
                    [logStrM appendString:[NSString stringWithFormat:@"\n\t-> %@",NSStringFromClass([nextRouting class])]];
                    continue;
                }
                [logStrM appendString:@"\n)"];
            } while (nextRouting != nil);
        }
#ifdef LogDebug
        LogDebug(@"%@",logStrM);
#elif (defined DEBUG)
        NSLog(@"%@",logStrM);
#endif
    }
#endif
}

@end
