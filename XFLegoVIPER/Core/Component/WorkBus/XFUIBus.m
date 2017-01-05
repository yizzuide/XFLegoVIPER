//
//  XFFluctuator.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFUIBus.h"
#import "NSObject+XFLegoInvokeMethod.h"
#import "XFRouting.h"
#import "XFRoutingFactory.h"
#import "XFURLRoute.h"
#import "XFControllerFactory.h"
#import "XFComponentRoutable.h"
#import "XFRoutingLinkManager.h"
#import "UIViewController+XFLego.h"
#import "XFComponentReflect.h"
#import "XFComponentManager.h"

// 获取模块组件路由
#define Routing ((XFRouting *)[self.componentRoutable routing])
// 当前组件界面
#define ThisInterface (Activity *)(IS_Module(self.componentRoutable) ? Routing.realInterface: self.componentRoutable)

@interface XFUIBus ()

/**
 *  可运行组件
 */
@property (nonatomic, weak) __kindof id<XFComponentRoutable> componentRoutable;

@end

@implementation XFUIBus

- (instancetype)init
{
    return [self initWithComponentRoutable:nil];
}

- (instancetype)initWithComponentRoutable:(__kindof id<XFComponentRoutable>)componentRoutable
{
    self = [super init];
    if (self) {
        _componentRoutable = componentRoutable;
    }
    return self;
}


#pragma mark - URL组件方式
- (void)openURL:(NSString *)url onWindow:(UIWindow *)mainWindow customCode:(CustomCodeBlock)customCodeBlock
{
    [XFURLRoute open:url transitionBlock:^(NSString *componentName, NSDictionary *params) {
        [self showComponent:componentName onWindow:mainWindow customCode:customCodeBlock];
    }];
}

// 以URL组件式PUSH
- (void)openURLForPush:(NSString *)url customCode:(CustomCodeBlock)customCodeBlock
{
    [XFURLRoute open:url transitionBlock:^(NSString *componentName, NSDictionary *params) {
        [self pushComponent:componentName intent: params.count ? params : [self _intentData] customCode:customCodeBlock];
    }];
}

// 以URL组件式Present
- (void)openURLForPresent:(NSString *)url customCode:(CustomCodeBlock)customCodeBlock
{
    [XFURLRoute open:url transitionBlock:^(NSString *componentName, NSDictionary *params) {
        [self presentComponent:componentName intent: params.count ? params : [self _intentData] customCode:customCodeBlock];
    }];
}

// 自定义打开一个URL组件
- (void)openURL:(NSString *)url withTransitionBlock:(TransitionBlock)transitionBlock customCode:(CustomCodeBlock)customCodeBlock
{
    [XFURLRoute open:url transitionBlock:^(NSString *componentName, NSDictionary *params) {
        [self putComponent:componentName withTransitionBlock:transitionBlock intent:params.count ? params : [self _intentData] customCode:customCodeBlock];
    }];
}

#pragma mark - 组件名切换方式
- (void)showComponent:(NSString *)componentName onWindow:(UIWindow *)mainWindow customCode:(CustomCodeBlock)customCodeBlock
{
    id<XFComponentRoutable> component;
    // 是否是控制器组件
    if ([XFComponentReflect isControllerComponent:componentName]) {
        UIViewController<XFComponentRoutable> *viewController = (id)[XFControllerFactory controllerFromComponentName:componentName];
        component = viewController;
    } else {
        // 否则是VIPER模块组件
        XFRouting *rootRouting = [XFRoutingFactory createRoutingFastFromModuleName:componentName];
        NSAssert(rootRouting, @"模块创建失败！请检测模块名是否正确！(注意：使用帕斯卡命名法<首字母大写>）");
        component = rootRouting.uiOperator;
    }
    // 视图
    UIViewController *interface = [XFComponentReflect interfaceForComponent:component];
    if (customCodeBlock) {
        customCodeBlock(interface);
    }
    // 显示根组件
    mainWindow.rootViewController = interface.navigationController ?: interface;
    [mainWindow makeKeyAndVisible];
    
    // 添加组件到容器
    [XFComponentManager addComponent:component];
}

// Modal方式
- (void)presentComponent:(NSString *)componentName intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock
{
    [self putComponent:componentName withTransitionBlock:^(Activity *thisInterface, Activity *nextInterface, TransitionCompletionBlock completionBlock) {
        // 是否有导航控制器
        Activity *nextNewInterface = nextInterface.navigationController ?: nextInterface;
        // 如果当前控制器未被Present
        if (thisInterface.presentingViewController == nil &&
            !thisInterface.isBeingDismissed &&
            thisInterface.view.window) {
        } else { // 查找合适的控制器来Present
            // 根控制器
            UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
            if (rootVC != thisInterface.presentingViewController)
                thisInterface = rootVC;
            // 使用UITabBarController的选中控制器来Present
            else if ([rootVC isKindOfClass:[UITabBarController class]])
                thisInterface = ((UITabBarController *)rootVC).selectedViewController;
        }
        [thisInterface presentViewController:nextNewInterface animated:YES completion:nil];
        completionBlock();
    } intent:intentData customCode:customCodeBlock];
}

- (void)dismissComponent
{
    [self removeComponentWithTransitionBlock:^(Activity *thisInterface, Activity *nextInterface, TransitionCompletionBlock completionBlock) {
        [thisInterface dismissViewControllerAnimated:YES completion:completionBlock];
    }];
}

// PUSH方式
- (void)pushComponent:(NSString *)componentName intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock
{
    [self putComponent:componentName withTransitionBlock:^(Activity *thisInterface, Activity *nextInterface, TransitionCompletionBlock completionBlock) {
        [thisInterface.navigationController pushViewController:nextInterface animated:YES];
        completionBlock();
    } intent:intentData customCode:customCodeBlock];
}

- (void)popComponent
{
    [self removeComponentWithTransitionBlock:^(Activity *thisInterface, Activity *nextInterface, TransitionCompletionBlock completionBlock) {
        [CATransaction begin];
        [CATransaction setCompletionBlock:completionBlock];
        [thisInterface.navigationController popViewControllerAnimated:YES];
        [CATransaction commit];
    }];
}

#pragma mark - 自定义组件切换
- (void)putComponent:(NSString *)componentName withTransitionBlock:(TransitionBlock)transitionBlock intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock {
    // 下一个组件
    id<XFComponentRoutable> nextComponent;
    // 是否是控制器组件
    if ([XFComponentReflect isControllerComponent:componentName]) {
        UIViewController<XFComponentRoutable> *viewController = (id)[XFControllerFactory controllerFromComponentName:componentName];
        nextComponent = viewController;
    } else {
        // 初始化一个Routing
        XFRouting *nextRouting = [XFRoutingFactory createRoutingFastFromModuleName:componentName];
        NSAssert(nextRouting, @"模块创建失败！请检测模块名是否正确！(注意：使用帕斯卡命名法<首字母大写>）");
        
        if ([XFComponentReflect isModuleComponent:self.componentRoutable]) { // 当前是模块组件
            // 如果有事件处理层
            if (nextRouting.uiOperator) {
                // 绑定模块关系
                [self _flowToNextRouting:nextRouting];
            }
            // 跟踪当前要跳转的路由,用于对共享的路由URL匹配
            [XFRoutingLinkManager setCurrentActionRounting:Routing];
        }
        nextComponent = nextRouting.uiOperator;
    }
    UIViewController *nextInterface = [XFComponentReflect interfaceForComponent:nextComponent];
    
    // 绑定组件关系
    [self _flowToNextComponent:nextComponent];
    
    // 传递组件参数
    if (intentData) {
        if ([intentData isKindOfClass:[NSDictionary class]] &&
            [nextComponent respondsToSelector:@selector(setURLParams:)]) {
            [nextComponent setURLParams:intentData];
        } else if ([nextComponent respondsToSelector:@selector(setComponentData:)]) {
            // 传递组件对象
            [nextComponent setComponentData:intentData];
        }
    }
    
    // 移除当前组件焦点
    if ([self.componentRoutable respondsToSelector:@selector(componentWillResignFocus)]) {
        [self.componentRoutable componentWillResignFocus];
    }
    
    // 清空意图数据
    if ([self.componentRoutable respondsToSelector:@selector(intentData)]) {
        self.componentRoutable.intentData = nil;
    }
    
    //  调用自定义代码
    if (customCodeBlock) {
        customCodeBlock(nextInterface);
    }
    // 执行切换组件
    if (transitionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            transitionBlock(ThisInterface, nextInterface, ^{
                // 下一个组件获得焦点
                if ([nextComponent respondsToSelector:@selector(componentWillBecomeFocus)]) {
                    [nextComponent componentWillBecomeFocus];
                }
            });
        });
    }
    [XFComponentManager addComponent:nextComponent];
}

// 移除当前Routing
- (void)removeComponentWithTransitionBlock:(TransitionBlock)transitionBlock
{
    // 如果是模块组件
    if ([XFComponentReflect isModuleComponent:self.componentRoutable]) {
        // 标识为程序移除
        [Routing.realInterface invokeMethod:@"setPoppingProgrammatically:" param:[NSNumber numberWithBool:YES]];
    } else {
        [self.componentRoutable invokeMethod:@"setPoppingProgrammatically:" param:[NSNumber numberWithBool:YES]];
    }
    
    // 开始移除当前路由并切换
    [self xfLego_startRemoveComponentWithTransitionBlock:transitionBlock];
}

- (void)xfLego_startRemoveComponentWithTransitionBlock:(TransitionBlock)transitionBlock
{
    if ([self.componentRoutable respondsToSelector:@selector(componentWillResignFocus)]) {
        [self.componentRoutable componentWillResignFocus];
    }
    transitionBlock(ThisInterface,nil,^{
        // 上一个组件获得焦点
        if ([self.componentRoutable.fromComponentRoutable respondsToSelector:@selector(componentWillBecomeFocus)]) {
            [self.componentRoutable.fromComponentRoutable componentWillBecomeFocus];
        }
        // 如果组件符合回传数据的条件
        if ([self _canBackDataWithComponent:self.componentRoutable]) {
            [self.componentRoutable.fromComponentRoutable onNewIntent:self.componentRoutable.intentData];
        }
        // 如果模块组件
        if ([XFComponentReflect isModuleComponent:self.componentRoutable]) {
            // 释放路由
            [Routing invokeMethod:@"xfLego_releaseRouting:" param:Routing];
        }
        // 解除组件关系链
        [self.componentRoutable.fromComponentRoutable setValue:nil forKey:@"nextComponentRoutable"];
        [self.componentRoutable setValue:nil forKey:@"fromComponentRoutable"];
        // 从容器里移除
        [XFComponentManager removeComponent:self.componentRoutable];
    });
}

#pragma mark - 私有方法
// 能否返回组件意图数据
- (BOOL)_canBackDataWithComponent:(id<XFComponentRoutable>)componentRoutable
{
    return [componentRoutable respondsToSelector:@selector(intentData)] &&
    componentRoutable.intentData &&
    componentRoutable.fromComponentRoutable &&
    [componentRoutable.fromComponentRoutable respondsToSelector:@selector(onNewIntent:)];
}
// 获取组件意图数据
- (id)_intentData
{
    id intentData;
    if ([self.componentRoutable respondsToSelector:@selector(intentData)]) {
        intentData = self.componentRoutable.intentData;
    }
    return intentData;
}

// 绑定模块组件关系链
- (void)_flowToNextRouting:(XFRouting *)nextRouting
{
    [Routing setValue:nextRouting forKey:@"nextRouting"];
    [nextRouting setValue:Routing forKey:@"previousRouting"];
}

// 绑定组件关系
- (void)_flowToNextComponent:(__kindof id<XFComponentRoutable>)nextComponent
{
    // 关联下一个组件
     [self.componentRoutable setValue:nextComponent forKey:@"nextComponentRoutable"];
    // 关联上一个组件
    [nextComponent setValue:self.componentRoutable forKey:@"fromComponentRoutable"];
}
@end
