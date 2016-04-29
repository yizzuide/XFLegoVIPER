//
//  XFWireframe.m
//  VIPERGem
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFRouting.h"
#import "XFUIOperatorProt.h"
#import "XFActivity.h"
#import "XFPresenter.h"
#import "XFInteractor.h"
#import "XFLegoMarco.h"

@interface XFRouting ()
/**
 *  当前视图
 */
@property (nonatomic, strong) id<XFUserInterfaceProt> currentInterface;
@property (nonatomic, strong) UINavigationController *currentNavigator;
@end

@implementation XFRouting

- (void)showRootActivityOnWindow:(UIWindow *)mainWindow{
    mainWindow.rootViewController = [self realInterface];
}

- (void)flowToNextRouting:(XFRouting *)nextRouting
{
    self.nextRouting = nextRouting;
    nextRouting.previousRouting = self;
}


- (void)dismissInterface
{
    __weak typeof(self) weakSelf = self;
    [self popRoutingWithTrasitionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[weakSelf realInterface] dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

- (void)popInterface
{
    __weak typeof(self) weakSelf = self;
    [self popRoutingWithTrasitionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[weakSelf realInterface] navigationController] popViewControllerAnimated:YES];
        });
        
    }];
}

- (void)pushInterface:(id<XFUserInterfaceProt>)interface intent:(id)intentData
{
    __weak typeof(self) weakSelf = self;
    [self pushRoutingWithTrasitionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[weakSelf realInterface] navigationController] pushViewController:LEGORealInterface(interface) animated:YES];
        });
        
    } intent:intentData];
}
- (void)presentInterface:(id<XFUserInterfaceProt>)interface intent:(id)intentData
{
    __weak typeof(self) weakSelf = self;
    [self pushRoutingWithTrasitionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[weakSelf realInterface] presentViewController:LEGORealInterface(interface) animated:YES completion:nil];
        });
    } intent:intentData];
}

- (void)popRoutingWithTrasitionBlock:(void(^)())trasitionBlock
{
    [self.uiOperator viewWillResignFoucs];
    trasitionBlock();
    if (self.previousRouting) {
            [self.previousRouting.uiOperator viewWillBecomeFoucsWithIntentData:[self.uiOperator intentData]];
    }
}

- (void)pushRoutingWithTrasitionBlock:(void(^)())trasitionBlock intent:(id)intentData {
    [self.uiOperator viewWillResignFoucs];
    trasitionBlock();
    if (self.nextRouting) {
        self.nextRouting.uiOperator.intentData = intentData;
        [self.nextRouting.uiOperator viewWillBecomeFoucsWithIntentData:intentData];
    }
}


+ (instancetype)routing
{
    return [[self alloc] init];
}

- (instancetype)buildModulesAssemblyWithActivityClass:(Class)activityClass presenterClass:(Class)perstentClass interactorClass:(Class)interactorClass
 {
     return [self _bulildMoudlesRelationWithActivityClass:activityClass navigatorClass:nil presenterClass:perstentClass interactorClass:interactorClass];
}

- (instancetype)buildModulesAssemblyWithActivityClass:(Class)activityClass navigatorClass:(Class)navigatorClass presenterClass:(Class)perstentClass interactorClass:(Class)interactorClass
{
    return [self _bulildMoudlesRelationWithActivityClass:activityClass navigatorClass:navigatorClass presenterClass:perstentClass interactorClass:interactorClass];
}

- (id)_bulildMoudlesRelationWithActivityClass:(Class)activityClass navigatorClass:(Class)navigatorClass  presenterClass:(Class)perstentClass interactorClass:(Class)interactorClass
{
    XFActivity *activity = [[activityClass alloc] init];
    self.currentInterface = activity;
    
    if (navigatorClass) {
        UINavigationController *navVC = [[navigatorClass alloc] initWithRootViewController:activity];
        self.currentNavigator = navVC;
    }
    
    if (perstentClass) {
        XFPresenter *persenter = [[perstentClass alloc] init];
        activity.eventHandler = persenter;
        persenter.routing = self;
        self.uiOperator = persenter;
        // other...
        if (interactorClass) {
            XFInteractor *interactor = [[interactorClass alloc] init];
            persenter.interactor = interactor;
        }
    }
    return self;
}

- (XFActivity *)realInterface {
    [self _delayDestoryInterfaceRef];
    return self.currentInterface ? LEGORealInterface(self.currentInterface) : LEGORealInterface([self.uiOperator currentInterface]);
}

- (UINavigationController *)realNavigator {
    [self _delayDestoryInterfaceRef];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.currentNavigator = nil;
    });
    return self.currentNavigator;
}

- (void)_delayDestoryInterfaceRef
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.currentInterface = nil;
    });
}


@end
