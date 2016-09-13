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
#import "XFRoutingLinkManager.h"

#define WS(weakSelf) __weak typeof(self) weakSelf = self;

@interface XFRouting ()
/**
 *  当前视图
 */
@property (nonatomic, strong) id<XFUserInterfacePort> currentUserInterface;
@property (nonatomic, strong) UINavigationController *currentNavigator;

/**
 *  所有用侦听通知的对象
 */
@property (nonatomic, strong) NSMutableArray *observers;
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
    WS(weakSelf)
    [self addRouting:nextRouting withTrasitionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [LEGORealInterface(weakSelf.realInterface) presentViewController:LEGORealInterface(nextRouting.realInterface) animated:YES completion:nil];
        });
    } intent:intentData];
}

- (void)dismiss
{
    WS(weakSelf)
    [self removeRoutingWithTrasitionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [LEGORealInterface(weakSelf.realInterface) dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

#pragma mark - PUSH方式
- (void)pushRouting:(XFRouting *)nextRouting intent:(id)intentData
{
    WS(weakSelf)
    [self addRouting:nextRouting withTrasitionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[LEGORealInterface(weakSelf.realInterface) navigationController] pushViewController:LEGORealInterface(nextRouting.realInterface) animated:YES];
        });
        
    } intent:intentData];
}

- (void)pop
{
    WS(weakSelf)
    [self removeRoutingWithTrasitionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[LEGORealInterface(weakSelf.realInterface) navigationController] popViewControllerAnimated:YES];
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
    // 从路由管理中心移除
    [XFRoutingLinkManager removeRouting:self];
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
    XFRouting *instance = [[self alloc] init];
    // 添加到路由管理中心
    [XFRoutingLinkManager addRouting:instance];
    //[XFRoutingLinkManager log];
    return instance;
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

#pragma mark - 模块通信
// VIPER架构里对单个模块间通信
- (void)sendEventName:(NSString *)eventName intentData:(id)intentData forMoudleName:(NSString *)moudleName
{
    [XFRoutingLinkManager sendEventName:eventName intentData:intentData forMoudlesName:@[moudleName]];
}
// VIPER架构里对多模块间通信
- (void)sendEventName:(NSString *)eventName intentData:(id)intentData forMoudlesName:(NSArray<NSString *> *)moudlesName
{
    [XFRoutingLinkManager sendEventName:eventName intentData:intentData forMoudlesName:moudlesName];
}
// 路由管理中心通知当前路由发送事件
- (void)_sendEventName:(NSString *)eventName intentData:(id)intentData
{
    [self.uiOperator receiveOtherMoudleEventName:eventName intentData:intentData];
}

// VIPER架构模块对MV*模块发送通知
- (void)sendNotificationForMVxWithName:(NSString *)notiName intentData:(id)intentData
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:nil userInfo:intentData];
}

// 注册从MVx架构中发出的通知
- (void)registerForMVxNotificationsWithNameArray:(NSArray<NSString *> *)notiNames {
    WS(weakSelf)
    for (NSString *notiName in notiNames) {
        // 侦听通知
        id<NSObject> observer=
        [[NSNotificationCenter defaultCenter] addObserverForName:notiName
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:^(NSNotification * _Nonnull note) {
                                                            // 通知事件处理层接收事件
                                                          [weakSelf.uiOperator receiveOtherMoudleEventName:note.name intentData:note.userInfo];
                                                                             }];
        // 添加到侦听数组
        [self.observers addObject:observer];
    }
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

- (void)dealloc
{
    // 删除所有侦听
    for (id<NSObject> observer in self.observers) {
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }
    self.observers = nil;
}

- (NSMutableArray *)observers
{
    if (_observers == nil) {
        _observers = [NSMutableArray array];
    }
    return _observers;
}
@end
