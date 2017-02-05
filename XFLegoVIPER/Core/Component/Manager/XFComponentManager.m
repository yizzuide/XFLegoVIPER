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
static NSMapTable *componentTable_;
/**
 *  组件名有序列表
 */
static NSMutableArray *componentKeyArr_;

+ (void)initialize
{
    if (self == [XFComponentManager class]) {
        componentTable_ = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
        componentKeyArr_ = [NSMutableArray array];
    }
}

+ (void)addComponent:(id<XFComponentRoutable>)component enableLog:(BOOL)enableLog
{
    NSString *componentName = [XFComponentReflect componentNameForComponent:component];
    [componentTable_ setObject:component forKey:componentName];
    [componentKeyArr_ addObject:componentName];
    if (enableLog) [self _log];
}

+ (void)removeComponent:(id<XFComponentRoutable>)component
{
    if (!component) return;
    NSString *componentName = [XFComponentReflect componentNameForComponent:component];
    [componentTable_ removeObjectForKey:componentName];
    [componentKeyArr_ removeObject:componentName];
    [self _clearZombieComponent];
    [self _log];
}

+ (void)_clearZombieComponent
{
    NSEnumerator *keys = componentTable_.keyEnumerator;
    for (NSString *key in keys) {
        if ([componentTable_ objectForKey:key]) continue;
        [componentTable_ removeObjectForKey:key];
        [componentKeyArr_ removeObject:key];
    }
}

+ (NSInteger)count
{
    return componentTable_.count;
}

+ (id<XFComponentRoutable>)findComponentForName:(NSString *)componentName
{
    NSEnumerator *keys = componentTable_.keyEnumerator;
    for (NSString *key in keys) {
        if ([key isEqualToString:componentName]) {
            return [componentTable_ objectForKey:key];
        }
    }
    return nil;
}

+ (void)sendEventName:(NSString *)eventName intentData:(id)intentData forComponent:(NSString *)componentName
{
    // 优先处理模块组件
    if([XFComponentReflect isVIPERModuleComponent:componentName]) {
        [XFRoutingLinkManager sendEventName:eventName intentData:intentData forModuleName:componentName];
        return;
    }
    // 控制器组件
    id<XFComponentRoutable> component = [self findComponentForName:componentName];
    if ([component respondsToSelector:@selector(receiveComponentEventName:intentData:)]) {
        [component receiveComponentEventName:eventName intentData:intentData];
    }
}

#pragma mark - log
// 组件树枝深度
static int treeDeepCount_;
+ (void)_log {
#ifdef DEBUG
    if (LEGO_DEBUG) {
#ifdef LogDebug
        LogDebug(@"Component trace log:");
#elif (defined DEBUG)
        NSLog(@"Component trace log:");
#endif
        NSMutableString *logStrM = [NSMutableString string];
        treeDeepCount_ = 0;
        __kindof id<XFComponentRoutable> component = [componentTable_ objectForKey:componentKeyArr_[0]];
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
    [self _printTabForAppenedString:logStrM deep:treeDeepCount_];
    [logStrM appendString:@"(\n"];
    
    // 当前组件
    [self _printTabForAppenedString:logStrM deep:treeDeepCount_ + 1];
    [self _printComponent:component logStr:logStrM];
    
    // 子组件
    [self _printSubComponentTree:component logStr:logStrM];
    
    // 关联组件
    id<XFComponentRoutable> nextComponent = component;
    do {
        nextComponent = nextComponent.nextComponentRoutable;
        if (nextComponent != nil) {
            [logStrM appendString:@"\n"];
            [self _printTabForAppenedString:logStrM deep:treeDeepCount_ + 1];
            // 下一个关联组件
            [self _printComponent:nextComponent logStr:logStrM];
            // 构建子树
            [self _printSubComponentTree:nextComponent logStr:logStrM];
        }
    } while (nextComponent != nil);
    
    // tree End
    [logStrM appendString:@"\n"];
    [self _printTabForAppenedString:logStrM deep:treeDeepCount_];
    [logStrM appendString:@")"];
}

// 构建组件项
+ (void)_printComponent:(id<XFComponentRoutable>)component logStr:(NSMutableString *)logStrM
{
    NSString *componentName = [XFComponentReflect componentNameForComponent:component];
    if ([componentKeyArr_.lastObject isEqualToString:componentName]) {
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
        treeDeepCount_ += 2;
        [logStrM appendString:@"\n"];
        [self _printTabForAppenedString:logStrM deep:treeDeepCount_ - 1];
        [logStrM appendString:@"["];
        for (int i = 0; i < childCount; i++) {
            UIViewController *childInterface = childInterfaces[i];
            if ([childInterface isKindOfClass:[UINavigationController class]]) {
                childInterface = ((UINavigationController *)childInterface).childViewControllers[0];
            }
            [self _printTabForAppenedString:logStrM deep:treeDeepCount_ + 1];
            id<XFComponentRoutable> subComponent = [XFComponentReflect componentForUInterface:childInterface];
            // 构建子树
            [self _printComponentTree:subComponent logStr:logStrM];
        }
        [logStrM appendString:@"\n"];
        [self _printTabForAppenedString:logStrM deep:treeDeepCount_ - 1];
        [logStrM appendString:@"]"];
        treeDeepCount_ -= 2;
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
