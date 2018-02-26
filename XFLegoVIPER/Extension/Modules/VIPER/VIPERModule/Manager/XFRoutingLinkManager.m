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
#import "XFVIPERModuleReflect.h"


@implementation XFRoutingLinkManager

/**
 *  路由容器
 */
static NSMapTable *__linkRoutingTable;
/**
 *  路由名有序列表
 */
static NSMutableArray *__linkRoutingKeyArr;
/**
 *  跟踪一个将要发起跳转动作的路由
 */
static NSHashTable *__trackActionRoutingTable;

/**
 * 存储共享路由
 */
static NSMapTable *__sharedRoutingTable;

+ (void)initialize
{
    if (self == [XFRoutingLinkManager class]) {
        __linkRoutingTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
        __linkRoutingKeyArr = [NSMutableArray array];
        
        __trackActionRoutingTable = [NSHashTable weakObjectsHashTable];
        __sharedRoutingTable =[NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
    }
}

#pragma mark - 模块管理
+ (void)addRouting:(XFRouting *)routing {
    NSString *key = [XFVIPERModuleReflect moduleNameForRouting:routing];
    [__linkRoutingTable setObject:routing forKey:key];
    [__linkRoutingKeyArr addObject:key];
}

+ (void)removeRouting:(XFRouting *)routing {
    NSString *key = [XFVIPERModuleReflect moduleNameForRouting:routing];
    [__linkRoutingTable removeObjectForKey:key];
    [__linkRoutingKeyArr removeObject:key];
}

+ (NSInteger)count
{
    return __linkRoutingTable.count;
}

+ (void)setCurrentActionRounting:(XFRouting *)routing
{
    [__trackActionRoutingTable removeAllObjects];
    if (routing) {
        [__trackActionRoutingTable addObject:routing];
    }
}

+ (XFRouting *)currentActionRouting
{
    return __trackActionRoutingTable.anyObject;
}

+ (void)setSharedRounting:(XFRouting *)routing shareModule:(NSString *)moduleName
{
    [__sharedRoutingTable setObject:routing forKey:moduleName];
}

+ (XFRouting *)sharedRoutingForShareModule:(NSString *)moduleName
{
    if (!moduleName) return nil;
    return [__sharedRoutingTable objectForKey:moduleName];
}

// 绑定路由的父子关系
+ (void)setSubRouting:(XFRouting *)subRouting forParentRouting:(XFRouting *)parentRouting
{
    [subRouting setValue:@YES forKey:@"subRoute"];
    [parentRouting addSubRouting:subRouting asChildViewController:NO];
}

#pragma mark - 模块通信
+ (void)sendEventName:(NSString *)eventName intentData:(id)intentData forModuleName:(NSString *)moduleName
{
    // 找到对应模块路由
    XFRouting *routing = [self findRoutingForModuleName:moduleName];
    // 通知路由发送事件
    [routing.uiOperator receiveComponentEventName:eventName intentData:intentData];
}

#pragma mark - 模块查找
+ (XFRouting *)findRoutingForModuleName:(NSString *)moduleName {
    NSEnumerator *keys = __linkRoutingTable.keyEnumerator;
    for (NSString *key in keys) {
        BOOL condition = [key isEqualToString:moduleName];
        if (condition) {
            return [__linkRoutingTable objectForKey:key];
        }
    }
    return nil;
}

#pragma mark - Debug
static BOOL __enableLog = NO;
+ (void)enableLog {
    __enableLog = YES;
}

+ (void)log {
#ifdef DEBUG
    if (__enableLog) {
#ifdef LogDebug
        LogDebug(@"current routing count: %zd",__linkRoutingTable.count);
        LogDebug(@"Routing link:");
#elif (defined DEBUG)
        NSLog(@"current routing count: %zd",__linkRoutingTable.count);
        NSLog(@"Routing link:");
#endif
        
        NSMutableString *logStrM = [NSMutableString string];
        NSUInteger count = __linkRoutingKeyArr.count;
        NSUInteger routingCount = 0;
        NSUInteger subRoutingCount = 0;
        for (int i = 0; i < count; i++) {
            XFRouting *routing = [__linkRoutingTable objectForKey:__linkRoutingKeyArr[i]];
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
