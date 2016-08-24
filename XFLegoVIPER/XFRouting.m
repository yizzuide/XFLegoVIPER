//
//  XFWireframe.m
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFRouting.h"
#import "XFUIOperatorProt.h"
#import "XFActivity.h"
#import "XFPresenter.h"
#import "XFInteractor.h"
#import "XFDataManager.h"
#import "XFLegoMarco.h"

@interface XFRouting ()
/**
 *  当前视图
 */
@property (nonatomic, strong) id<XFUserInterfaceProt> currentUserInterface;
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

- (void)presentInterface:(id<XFUserInterfaceProt>)interface intent:(id)intentData
{
    __weak typeof(self) weakSelf = self;
    [self pushRoutingWithTrasitionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[weakSelf realInterface] presentViewController:LEGORealInterface(interface) animated:YES completion:nil];
        });
    } intent:intentData];
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

- (void)pushInterface:(id<XFUserInterfaceProt>)interface intent:(id)intentData
{
    __weak typeof(self) weakSelf = self;
    [self pushRoutingWithTrasitionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[weakSelf realInterface] navigationController] pushViewController:LEGORealInterface(interface) animated:YES];
        });
        
    } intent:intentData];
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


- (void)popRoutingWithTrasitionBlock:(void(^)())trasitionBlock
{
    [self.uiOperator viewWillResignFocus];
    trasitionBlock();
    if (self.previousRouting) {
            [self.previousRouting.uiOperator viewWillBecomeFocusWithIntentData:[self.uiOperator intentData]];
    }
}

- (void)pushRoutingWithTrasitionBlock:(void(^)())trasitionBlock intent:(id)intentData {
    [self.uiOperator viewWillResignFocus];
    trasitionBlock();
    if (self.nextRouting) {
        self.nextRouting.uiOperator.intentData = intentData;
        [self.nextRouting.uiOperator viewWillBecomeFocusWithIntentData:intentData];
    }
}


+ (instancetype)routing
{
    return [[self alloc] init];
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
        XFPresenter *persenter = [[perstentClass alloc] init];
        activity.eventHandler = persenter;
        persenter.routing = self;
        self.uiOperator = persenter;
        // other...
        if (interactorClass) {
            XFInteractor *interactor = [[interactorClass alloc] init];
            persenter.interactor = interactor;
            
            if(dataManagerClass){
                XFDataManager *dataManager = [[dataManagerClass alloc] init];
                interactor.dataManager = dataManager;
            }
        }
        
    }
    return self;
}

- (XFActivity *)realInterface {
    [self _delayDestoryInterfaceRef];
    return self.currentUserInterface ? LEGORealInterface(self.currentUserInterface) : LEGORealInterface([self.uiOperator userInterface]);
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
