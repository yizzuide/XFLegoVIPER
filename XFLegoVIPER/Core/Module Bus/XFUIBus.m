//
//  XFFluctuator.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "NSObject+XFLegoInvokeMethod.h"
#import "XFUIBus.h"
#import "XFRouting.h"
#import "XFRoutingFactory.h"
#import "XFURLRoute.h"
#import "XFControllerFactory.h"
#import "XFComponentRoutable.h"
#import "XFRoutingLinkManager.h"

@interface XFUIBus ()
/**
 *  根路由
 */
@property (nonatomic, strong) XFRouting *rootRouting;
@end

@implementation XFUIBus

- (instancetype)initWithFromRouting:(XFRouting *)fromRouting
{
    self = [super init];
    if (self) {
        self.fromRouting = fromRouting;
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
    [self _trackRouting];
    [XFURLRoute open:url transitionBlock:^(NSString *componentName, NSDictionary *params) {
        [self pushComponent:componentName intent: params.count ? params : self.fromRouting.uiOperator.intentData customCode:customCodeBlock];
    }];
}

// 以URL组件式Present
- (void)openURLForPresent:(NSString *)url customCode:(CustomCodeBlock)customCodeBlock
{
    [self _trackRouting];
    [XFURLRoute open:url transitionBlock:^(NSString *componentName, NSDictionary *params) {
        [self presentComponent:componentName intent: params.count ? params : self.fromRouting.uiOperator.intentData customCode:customCodeBlock];
    }];
}

// 自定义打开一个URL组件
- (void)openURL:(NSString *)url withTransitionBlock:(TransitionBlock)trasitionBlock customCode:(CustomCodeBlock)customCodeBlock
{
    [self _trackRouting];
    [XFURLRoute open:url transitionBlock:^(NSString *componentName, NSDictionary *params) {
        [self putComponent:componentName withTransitionBlock:trasitionBlock intent:params.count ? params : self.fromRouting.uiOperator.intentData customCode:customCodeBlock];
    }];
}

// 跟踪当前要跳转的路由,用于对共享的路由URL匹配
- (void)_trackRouting
{
    [XFRoutingLinkManager setCurrentActionRounting:self.fromRouting];
}


#pragma mark - 组件名界面切换方式
- (void)showComponent:(NSString *)componentName onWindow:(UIWindow *)mainWindow customCode:(CustomCodeBlock)customCodeBlock
{
    // 是否是控制器组件
    if ([XFControllerFactory isViewControllerComponent:componentName]) {
        UIViewController *viewController = (id)[XFControllerFactory controllerFromComponentName:componentName];
        mainWindow.rootViewController = viewController;
        [mainWindow makeKeyAndVisible];
        return;
    }
    
    // 否则是VIPER模块组件
    self.rootRouting = [XFRoutingFactory createRoutingFastFromModuleName:componentName];
    NSAssert(self.rootRouting, @"模块创建失败！请检测模块名是否正确！(注意：使用帕斯卡命名法<首字母大写>）");
    if (customCodeBlock) {
        customCodeBlock(self.rootRouting.realInterface);
    }
    id navigator = self.rootRouting.realNavigator;
    if (navigator) {
        mainWindow.rootViewController = navigator;
    }else{
        mainWindow.rootViewController = self.rootRouting.realInterface;
    }
    [mainWindow makeKeyAndVisible];
}

// Modal方式
- (void)presentComponent:(NSString *)componentName intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock
{
    [self putComponent:componentName withTransitionBlock:^(Activity *thisInterface, Activity *nextInterface) {
        [thisInterface presentViewController:nextInterface animated:YES completion:nil];
    } intent:intentData customCode:customCodeBlock];
}

- (void)dismiss
{
    [self removeWithTransitionBlock:^(Activity *thisInterface, Activity *nextInterface) {
        [thisInterface dismissViewControllerAnimated:YES completion:nil];
    }];
}

// PUSH方式
- (void)pushComponent:(NSString *)componentName intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock
{
    [self putComponent:componentName withTransitionBlock:^(Activity *thisInterface, Activity *nextInterface) {
        [thisInterface.navigationController pushViewController:nextInterface animated:YES];
    } intent:intentData customCode:customCodeBlock];
}

- (void)pop
{
    [self removeWithTransitionBlock:^(Activity *thisInterface, Activity *nextInterface) {
        [thisInterface.navigationController popViewControllerAnimated:YES];
    }];
}


#pragma mark - 自定义切换
- (void)putComponent:(NSString *)componentName withTransitionBlock:(TransitionBlock)trasitionBlock intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock {
    // 是否是控制器组件
    if ([XFControllerFactory isViewControllerComponent:componentName]) {
        [self putViewControllerComponent:componentName withTransitionBlock:trasitionBlock intent:intentData customCode:customCodeBlock];
        return;
    }
    
    // 否则是VIPER模块组件
    [self putRoutingComponent:componentName withTransitionBlock:trasitionBlock intent:intentData customCode:customCodeBlock];
}

- (void)putViewControllerComponent:(NSString *)component withTransitionBlock:(TransitionBlock)trasitionBlock intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock
{
    UIViewController<XFComponentRoutable> *viewController = (id)[XFControllerFactory controllerFromComponentName:component];
    // 传递组件参数
    if ([intentData isKindOfClass:[NSDictionary class]] &&
        [viewController respondsToSelector:@selector(setURLParams:)]) {
        [viewController setURLParams:intentData];
    } else if ([viewController respondsToSelector:@selector(setComponentData:)]) {
        // 传递组件对象
        [viewController setComponentData:intentData];
    }
    
    if (customCodeBlock) {
        customCodeBlock(viewController);
    }
    trasitionBlock(self.fromRouting.realInterface,viewController);
}

- (void)putRoutingComponent:(NSString *)component withTransitionBlock:(TransitionBlock)trasitionBlock intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock
{
    // 初始化一个Routing
    XFRouting *nextRouting = [XFRoutingFactory createRoutingFastFromModuleName:component];
    NSAssert(nextRouting, @"模块创建失败！请检测模块名是否正确！(注意：使用帕斯卡命名法<首字母大写>）");
    
    // 传递组件参数
    id<XFComponentRoutable> componentRoutable = nextRouting.uiOperator;
    if ([intentData isKindOfClass:[NSDictionary class]]) {
        [componentRoutable setURLParams:intentData];
    } else {
        [componentRoutable setComponentData:intentData];
    }
    
    //  调用自定义代码
    if (customCodeBlock) {
        customCodeBlock(nextRouting.realInterface);
    }
    // 如果有事件处理层
    if (nextRouting.uiOperator) {
        // 绑定关系
        [self _flowToNextRouting:nextRouting];
    }
    // 移除当前视图焦点
    [self.fromRouting.uiOperator viewWillResignFocus];
    // 执行切换界面
    if (trasitionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            trasitionBlock(self.fromRouting.realInterface,LEGORealInterface(nextRouting.realInterface));
        });
    }
    LEGORunAfter0_015({
        // 下一个视图获得焦点，并传送意图数据
        if (self.fromRouting.nextRouting) {
            [self.fromRouting.nextRouting.uiOperator viewWillBecomeFocusWithIntentData:nil];
        }
    })
}

#pragma mark - MVx界面切换
- (void)pushMVxViewController:(UIViewController *)viewController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self.fromRouting.realInterface navigationController] pushViewController:viewController animated:YES];
    });
}

- (void)presentMVxViewController:(UIViewController *)viewController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.fromRouting.realInterface presentViewController:viewController animated:YES completion:nil];
    });
}

#pragma mark - 关系链管理
// 移除当前Routing
- (void)removeWithTransitionBlock:(TransitionBlock)trasitionBlock
{
    // 标识为程序移除
    [self.fromRouting.realInterface invokeMethod:@"setPoppingProgrammatically:" param:[NSNumber numberWithBool:YES]];
    // 开始移除当前路由并切换
    [self xfLego_startRemoveModuleWithTransitionBlock:trasitionBlock];
}

- (void)xfLego_startRemoveModuleWithTransitionBlock:(TransitionBlock)trasitionBlock
{
    // 移除当前视图焦点
    if (self.fromRouting.uiOperator) {
        [self.fromRouting.uiOperator viewWillResignFocus];
    }
    
    // 执行切换界面
    if (trasitionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            trasitionBlock(self.fromRouting.realInterface,nil);
        });
    }
    
    // 上一个视图获得焦点，并传送意图数据
    if (self.fromRouting.previousRouting) {
        [self.fromRouting.previousRouting.uiOperator viewWillBecomeFocusWithIntentData:[self.fromRouting.uiOperator intentData]];
    }
    
    // 释放路由
    [self.fromRouting invokeMethod:@"xfLego_releaseRouting:" param:self.fromRouting];
}

- (void)_flowToNextRouting:(XFRouting *)nextRouting
{
    [self.fromRouting setValue:nextRouting forKey:@"nextRouting"];
    [nextRouting setValue:self.fromRouting forKey:@"previousRouting"];
}

@end
