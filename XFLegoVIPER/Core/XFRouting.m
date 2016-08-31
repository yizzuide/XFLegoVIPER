//
//  XFWireframe.m
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFRouting.h"
#import "XFActivity.h"
#import "XFPresenter.h"
#import "XFInteractor.h"
#import "XFDataManager.h"
#import "XFLegoMarco.h"

@interface XFRouting ()
/**
 *  当前视图
 */
@property (nonatomic, strong) id<XFUserInterfacePort> currentUserInterface;
@property (nonatomic, strong) UINavigationController *currentNavigator;
@end

@implementation XFRouting

- (void)showRootActivityOnWindow:(UIWindow *)mainWindow isNavigationControllor:(BOOL)isNavigationControllor{
    if (isNavigationControllor) {
        mainWindow.rootViewController = LEGORealInterface([self realNavigator]);
    }else{
        mainWindow.rootViewController = LEGORealInterface([self realInterface]);
    }
    [mainWindow makeKeyAndVisible];
}

#pragma mark - Modal方式
- (void)presentRouting:(XFRouting *)nextRouting intent:(id)intentData
{
    __weak typeof(self) weakSelf = self;
    [self addRouting:nextRouting withTrasitionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [LEGORealInterface([weakSelf realInterface]) presentViewController:LEGORealInterface(nextRouting.realInterface) animated:YES completion:nil];
        });
    } intent:intentData];
}

- (void)dismiss
{
    __weak typeof(self) weakSelf = self;
    [self removeRoutingWithTrasitionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [LEGORealInterface([weakSelf realInterface]) dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

#pragma mark - PUSH方式
- (void)pushRouting:(XFRouting *)nextRouting intent:(id)intentData
{
    __weak typeof(self) weakSelf = self;
    [self addRouting:nextRouting withTrasitionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[LEGORealInterface([weakSelf realInterface]) navigationController] pushViewController:LEGORealInterface(nextRouting.realInterface) animated:YES];
        });
        
    } intent:intentData];
}

- (void)pop
{
    __weak typeof(self) weakSelf = self;
    [self removeRoutingWithTrasitionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[LEGORealInterface([weakSelf realInterface]) navigationController] popViewControllerAnimated:YES];
        });
        
    }];
}

#pragma mark - 自定义切换
- (void)removeRoutingWithTrasitionBlock:(void(^)())trasitionBlock
{
    // 移除当前视图焦点
    [self.uiOperator viewWillResignFocus];
    // 执行切换代码
    trasitionBlock();
    // 上一个视图获得焦点，并传送意图数据
    if (self.previousRouting) {
            [self.previousRouting.uiOperator viewWillBecomeFocusWithIntentData:[self.uiOperator intentData]];
    }
    // 解除关系链
    self.previousRouting.nextRouting = nil;
    self.previousRouting = nil;
}

- (void)addRouting:(XFRouting *)nextRouting withTrasitionBlock:(void(^)())trasitionBlock intent:(id)intentData {
    // 绑定关系
    [self flowToNextRouting:nextRouting];
    // 移除当前视图焦点
    [self.uiOperator viewWillResignFocus];
    // 执行切换界面
    trasitionBlock();
    // 下一个视图获得焦点，并传送意图数据
    if (self.nextRouting) {
        [self.nextRouting.uiOperator viewWillBecomeFocusWithIntentData:intentData];
    }
}


#pragma mark - 绑定模块
+ (instancetype)routing
{
    return [[self alloc] init];
}

- (void)flowToNextRouting:(XFRouting *)nextRouting
{
    self.nextRouting = nextRouting;
    nextRouting.previousRouting = self;
}

- (instancetype)buildModulesAssemblyWithActivityClass:(Class)activityClass
                                       presenterClass:(Class)perstentClass
                                      interactorClass:(Class)interactorClass
                                     dataManagerClass:(Class)dataManagerClass
 {
     return [self _bulildMoudlesRelationWithActivityClass:activityClass navigatorClass:nil presenterClass:perstentClass interactorClass:interactorClass dataManagerClass:dataManagerClass];
}

- (instancetype)buildModulesAssemblyWithActivityClass:(Class)activityClass navigatorClass:(Class)navigatorClass presenterClass:(Class)perstentClass interactorClass:(Class)interactorClass dataManagerClass:(Class)dataManagerClass
{
    return [self _bulildMoudlesRelationWithActivityClass:activityClass navigatorClass:navigatorClass presenterClass:perstentClass interactorClass:interactorClass dataManagerClass:dataManagerClass];
}

- (id)_bulildMoudlesRelationWithActivityClass:(Class)activityClass navigatorClass:(Class)navigatorClass  presenterClass:(Class)perstentClass interactorClass:(Class)interactorClass dataManagerClass:(Class)dataManagerClass
{
    XFActivity *activity = [[activityClass alloc] init];
    self.currentUserInterface = activity;
    
    if (navigatorClass) {
        UINavigationController *navVC = [[navigatorClass alloc] initWithRootViewController:activity];
        self.currentNavigator = navVC;
    }
    
    if (perstentClass) {
        XFPresenter *presenter = [[perstentClass alloc] init];
        activity.eventHandler = presenter;
        presenter.routing = self;
        self.uiOperator = presenter;
        // other...
        if (interactorClass) {
            XFInteractor *interactor = [[interactorClass alloc] init];
            presenter.interactor = interactor;
            
            if(dataManagerClass){
                XFDataManager *dataManager = [[dataManagerClass alloc] init];
                interactor.dataManager = dataManager;
            }
        }
        
    }
    return self;
}

#pragma mark - 获取当前视图
- (id<XFUserInterfacePort>)realInterface {
    [self _delayDestoryInterfaceRef];
    return self.currentUserInterface ? self.currentUserInterface : [self.uiOperator userInterface];
}

- (UINavigationController *)realNavigator {
    [self _delayDestoryInterfaceRef];
    // 移除当前类对之的强引用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.currentNavigator = nil;
    });
    return self.currentNavigator;
}

// 移除当前类对之的强引用
- (void)_delayDestoryInterfaceRef
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.currentUserInterface = nil;
    });
}


@end
