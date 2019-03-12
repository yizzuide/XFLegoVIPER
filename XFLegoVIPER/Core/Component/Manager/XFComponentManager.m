//
//  XFComponentManager.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/20.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFComponentManager.h"
#import "XFComponentRoutable.h"
#import "XFComponentReflect.h"
#import "XFRoutingLinkManager.h"
#import "XFRouting.h"
#import "XFLegoMarco.h"
#import "XFLegoConfig.h"

@implementation XFComponentManager

/**
 *  组件容器
 */
static NSMapTable *__componentTable;
/**
 *  组件名有序列表
 */
static NSMutableArray *__componentKeyArr;

/**
 * 事件接收对象
 */
static NSMapTable *__eventReceiverTable;

+ (void)initialize
{
    if (self == [XFComponentManager class]) {
        __componentTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
        __componentKeyArr = [NSMutableArray array];
        
        __eventReceiverTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
    }
}

+ (void)addComponent:(id<XFComponentRoutable>)component enableLog:(BOOL)enableLog
{
    NSString *componentName = [XFComponentReflect componentNameForComponent:component];
    [__componentTable setObject:component forKey:componentName];
    [__componentKeyArr addObject:componentName];
    if (enableLog) [self _log];
}

+ (void)addComponent:(id<XFComponentRoutable>)component forName:(NSString *)componentName
{
    [__componentTable setObject:component forKey:componentName];
    [__componentKeyArr addObject:componentName];
}

+ (void)removeComponent:(id<XFComponentRoutable>)component
{
    if (!component) return;
    NSString *componentName = [XFComponentReflect componentNameForComponent:component];
    [__componentTable removeObjectForKey:componentName];
    [__componentKeyArr removeObject:componentName];
    [self _clearZombieComponent];
    [self _log];
}

+ (void)removeComponentForName:(NSString *)componentName
{
    [__componentTable removeObjectForKey:componentName];
    [__componentKeyArr removeObject:componentName];
    [self _clearZombieComponent];
}

+ (void)addIncompatibleComponent:(id<XFEventReceivable>)incompatibleComponent componentName:(NSString *)componentName
{
    [__componentTable setObject:incompatibleComponent forKey:componentName];
    [__componentKeyArr addObject:componentName];
}

+ (void)removeIncompatibleComponentWithName:(NSString *)componentName
{
    [self removeComponentForName:componentName];
}

+ (void)addEventReceiver:(id)receiver componentName:(NSString *)componentName
{
    [__eventReceiverTable setObject:receiver forKey:componentName];
}

+ (void)removeEventReceiverComponentWithName:(NSString *)componentName
{
    [__eventReceiverTable removeObjectForKey:componentName];
}

+ (void)_clearZombieComponent
{
    NSEnumerator *keys = __componentTable.keyEnumerator;
    for (NSString *key in keys) {
        if ([__componentTable objectForKey:key]) continue;
        [__componentTable removeObjectForKey:key];
        [__componentKeyArr removeObject:key];
    }
}

+ (NSInteger)count
{
    return __componentTable.count;
}

+ (id<XFComponentRoutable>)findComponentForName:(NSString *)componentName
{
    NSEnumerator *keys = __componentTable.keyEnumerator;
    for (NSString *key in keys) {
        if ([key isEqualToString:componentName]) {
            return [__componentTable objectForKey:key];
        }
    }
    return nil;
}

+ (void)sendEventName:(NSString *)eventName intentData:(nullable id)intentData forComponent:(nonnull NSString *)componentName
{
    // 先检测有没有事件接收者
    if (__eventReceiverTable.count) {
        id<XFEventReceivable> eventReceivable = [__eventReceiverTable objectForKey:componentName];
        if (eventReceivable &&
            [eventReceivable respondsToSelector:@selector(receiveComponentEventName:intentData:)]) {
            [eventReceivable receiveComponentEventName:eventName intentData:intentData];
            return;
        }
    }
    
    // 从容器里的组件找
    id<XFComponentRoutable> component = [self findComponentForName:componentName];
    if ([component respondsToSelector:@selector(receiveComponentEventName:intentData:)]) {
        [component receiveComponentEventName:eventName intentData:intentData];
    }
}

+ (void)sendEventName:(NSString *)eventName intentData:(nullable id)intentData forComponents:(nonnull NSArray<NSString *> *)componentNames
{
    for (NSString *compName in componentNames) {
        [self sendEventName:eventName intentData:intentData forComponent:compName];
    }
}

+ (void)sendGlobalEventName:(NSString *)eventName intentData:(nullable id)intentData
{
    for(id<XFComponentRoutable> component in __componentTable.objectEnumerator) {
        if ([component respondsToSelector:@selector(receiveComponentEventName:intentData:)]) {
            // 回主线程
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                [component receiveComponentEventName:eventName intentData:intentData];
            });
        }
    }
}

#pragma mark - log
// 组件树枝深度
static int __treeDeepCount;
+ (void)_log {
#ifdef DEBUG
    if (LEGO_DEBUG) {
#ifdef LogDebug
        LogDebug(@"Component trace log:");
#elif (defined DEBUG)
        NSLog(@"Component trace log:");
#endif
        NSMutableString *logStrM = [NSMutableString string];
        __treeDeepCount = 0;
        __kindof id<XFComponentRoutable> component = [__componentTable objectForKey:__componentKeyArr[0]];
        [self _printComponentTree:component logStr:logStrM];
#ifdef LogDebug
        LogDebug(@"%@",logStrM);
#elif (defined DEBUG)
        NSLog(@"%@",logStrM);
#endif
    }
#endif
}

// 构建组件树
+ (void)_printComponentTree:(id<XFComponentRoutable>)component logStr:(NSMutableString *)logStrM
{
    // tree Begin
    [logStrM appendString:@"\n"];
    [self _printTabForAppenedString:logStrM deep:__treeDeepCount];
    [logStrM appendString:@"(\n"];
    
    // 当前组件
    [self _printTabForAppenedString:logStrM deep:__treeDeepCount + 1];
    [self _printComponent:component logStr:logStrM];
    
    // 子组件
    [self _printSubComponentTree:component logStr:logStrM];
    
    // 关联组件
    id<XFComponentRoutable> nextComponent = component;
    do {
        nextComponent = nextComponent.nextComponentRoutable;
        if (nextComponent != nil) {
            [logStrM appendString:@"\n"];
            [self _printTabForAppenedString:logStrM deep:__treeDeepCount + 1];
            // 下一个关联组件
            [self _printComponent:nextComponent logStr:logStrM];
            // 构建子树
            [self _printSubComponentTree:nextComponent logStr:logStrM];
        }
    } while (nextComponent != nil);
    
    // tree End
    [logStrM appendString:@"\n"];
    [self _printTabForAppenedString:logStrM deep:__treeDeepCount];
    [logStrM appendString:@")"];
}

// 构建组件项
+ (void)_printComponent:(id<XFComponentRoutable>)component logStr:(NSMutableString *)logStrM
{
    NSString *componentName = [XFComponentReflect componentNameForComponent:component];
    if ([__componentKeyArr.lastObject isEqualToString:componentName]) {
        [logStrM appendString:@"-> "];
    }
    [logStrM appendString:componentName];
}

// 构建组件枝丫
+ (void)_printSubComponentTree:(id<XFComponentRoutable>)component logStr:(NSMutableString *)logStrM
{
    UIViewController *currentInterface = [XFComponentReflect uInterfaceForComponent:component];
    NSArray *childInterfaces = currentInterface.childViewControllers;
    NSInteger childCount = childInterfaces.count;
    
    if (childCount) {
        __treeDeepCount += 2;
        [logStrM appendString:@"\n"];
        [self _printTabForAppenedString:logStrM deep:__treeDeepCount - 1];
        [logStrM appendString:@"["];
        for (int i = 0; i < childCount; i++) {
            UIViewController *childInterface = childInterfaces[i];
            if ([childInterface isKindOfClass:[UINavigationController class]]) {
                childInterface = ((UINavigationController *)childInterface).childViewControllers[0];
            }
            [self _printTabForAppenedString:logStrM deep:__treeDeepCount + 1];
            id<XFComponentRoutable> subComponent = [XFComponentReflect componentForUInterface:childInterface];
            // 构建子树
            [self _printComponentTree:subComponent logStr:logStrM];
        }
        [logStrM appendString:@"\n"];
        [self _printTabForAppenedString:logStrM deep:__treeDeepCount - 1];
        [logStrM appendString:@"]"];
        __treeDeepCount -= 2;
    }
}
// 打印Tab
+ (void)_printTabForAppenedString:(NSMutableString *)appenedString deep:(int)deep
{
    for (NSUInteger t = 0; t < deep; t++) {
        [appenedString appendString:@"\t"];
    }
}
@end
