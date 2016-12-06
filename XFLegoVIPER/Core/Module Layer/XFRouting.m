//
//  XFWireframe.m
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "NSObject+XFLegoInvokeMethod.h"
#import "XFRouting.h"
#import "XFRoutingLinkManager.h"

@interface XFRouting ()

/**
 *  模块组装器
 */
@property (nonatomic, strong, readwrite) XFModuleAssembly *assembly;
/**
 *  UI总线
 */
@property (nonatomic, strong, readwrite) XFUIBus *uiBus;
/**
 *  事件总线
 */
@property (nonatomic, strong, readwrite) XFEventBus *eventBus;
/**
 *  上一个关联的模块路由
 */
@property (nonatomic, strong, readwrite) XFRouting *previousRouting;
/**
 *  下一个关联的模块路由
 */
@property (nonatomic, strong, readwrite) XFRouting *nextRouting;

/**
 *  父路由
 */
@property (nonatomic, weak, readwrite) XFRouting *parentRouting;

/**
 *  子路由
 */
@property (nonatomic, strong, readwrite) NSMutableArray<XFRouting *> *subRoutings;

/**
 *  事件层
 */
@property (nonatomic, weak, readwrite) id<XFUIOperatorPort> uiOperator;

/**
 *  当前视图
 */
@property (nonatomic, strong) id<XFUserInterfacePort> currentUserInterface;
/**
 *  当前导航
 */
@property (nonatomic, strong) UINavigationController *currentNavigator;
/**
 *  释放标识
 */
@property (nonatomic, assign, getter=hadReleaseSuff) BOOL releaseSuff;

@end

@implementation XFRouting

#pragma mark - 初始化
+ (instancetype)routing
{
    XFRouting *routing = [[self alloc] init];
    routing.assembly = [[XFModuleAssembly alloc] initWithFromRouting:routing];
    routing.uiBus = [[XFUIBus alloc] initWithFromRouting:routing];
    routing.eventBus = [[XFEventBus alloc] initWithFromRouting:routing];
    return routing;
}

// **子类要自己实现组装当前模块方式**
+ (instancetype)assembleRouting
{
    NSAssert(NO, @"当前子类没有覆盖当前方法以实现组装模块方式");
    return nil;
}

#pragma mark - 子路由管理
// 添加子路由
- (void)addSubRouting:(XFRouting *)subRouting asChildViewController:(BOOL)asChild
{
    subRouting.subRoute = YES;
    if (asChild) {
        [MainActivity addChildViewController:LEGORealInterface(subRouting.realInterface)];
    }
    [self.subRoutings addObject:subRouting];
    subRouting.parentRouting = self;
}

#pragma mark - 快速弹出视图方法
- (void)pop
{
    [self.uiBus pop];
}

- (void)dismiss
{
    [self.uiBus dismiss];
}

#pragma mark - 获取当前视图
- (__kindof id<XFUserInterfacePort>)realInterface {
    return self.currentUserInterface ? self.currentUserInterface : [self.uiOperator userInterface];
}

- (__kindof UINavigationController *)realNavigator {
    return self.currentNavigator ? self.currentNavigator : [LEGORealInterface([self.uiOperator userInterface]) navigationController];
}

#pragma mark - 资源回收
// 移除当前路由对视图层的强引用
- (void)xfLego_destoryInterfaceRef
{
    self.currentUserInterface = nil;
    self.currentNavigator = nil;
}

// 视图层willDisappear时，判断是否能释放当前Routing资源
- (void)xfLego_removeRouting
{
    // 如果当前是子路由(作为VIPER框架模块的子模块或MVx架构的子控制器)
    // 或者如果当前路由的父路由存在，过滤掉受管理的子视图移除显示的情况，路由资源的释放由父路由管理
    if (self.isSubRoute || self.parentRouting) {
        return;
    }
    // 开始移除当前路由
    [self.uiBus invokeMethod:@"xfLego_startRemoveModuleWithTransitionBlock:" param:nil];
}

// 递归释放路由方法
- (void)xfLego_releaseRouting:(XFRouting *)routing
{
    // 释放相对当前路由的关系链
    if(routing.previousRouting) {
        routing.previousRouting.nextRouting = nil;
        routing.previousRouting = nil;
    }
    
    // 移除通知侦听者
    [routing.eventBus removeObservers];
    
    // 释放子路由
    if (routing->_subRoutings) {
        for (XFRouting *subRouting in routing->_subRoutings) {
            [self xfLego_releaseRouting:subRouting];
        }
        // 删除所有子路由
        [routing->_subRoutings removeAllObjects];
        routing->_subRoutings = nil;
    }
    
    // 从路由管理中心移除
    [XFRoutingLinkManager removeRouting:routing];
    if (!(routing.isSubRoute || routing.parentRouting)) {
        // 打印路由关系链
        [XFRoutingLinkManager log];
    }
    
    // 标识释放成功
    self.releaseSuff = YES;
}

- (void)dealloc
{
    // 释放添加到MVx父控制器里的VIPER子模块为子控制器的情况
    if (self.isSubRoute && !self.hadReleaseSuff && !self.parentRouting) {
        [self.uiBus invokeMethod:@"xfLego_startRemoveModuleWithTransitionBlock:" param:nil];
    }
}

#pragma mark - 懒加载
- (NSMutableArray<XFRouting *> *)subRoutings
{
    if (_subRoutings == nil) {
        _subRoutings = [NSMutableArray array];
    }
    return _subRoutings;
}
@end
