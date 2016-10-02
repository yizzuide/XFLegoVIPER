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
 *  上一个关联的模块路由
 */
@property (nonatomic, weak) XFRouting *previousRouting;
/**
 *  下一个关联的模块路由
 */
@property (nonatomic, weak) XFRouting *nextRouting;

/**
 *  当前视图
 */
@property (nonatomic, strong) id<XFUserInterfacePort> currentUserInterface;
/**
 *  当前导航
 */
@property (nonatomic, strong) UINavigationController *currentNavigator;

/**
 *  所有用侦听通知的对象
 */
@property (nonatomic, strong) NSMutableArray *observers;
@end

@implementation XFRouting

- (void)showRootActivityOnWindow:(UIWindow *)mainWindow
{
    id navigator = [self realNavigator];
    if (navigator) {
        mainWindow.rootViewController = LEGORealInterface(navigator);
    }else{
        mainWindow.rootViewController = LEGORealInterface([self realInterface]);
    }
    [mainWindow makeKeyAndVisible];
}

#pragma mark - MVx控制器切换
- (void)pushMVxViewController:(UIViewController *)viewController
{
    WS(weakSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        [[LEGORealInterface(weakSelf.realInterface) navigationController] pushViewController:viewController animated:YES];
    });
}

- (void)presentMVxViewContrller:(UIViewController *)viewController
{
    WS(weakSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        [LEGORealInterface(weakSelf.realInterface) presentViewController:viewController animated:YES completion:nil];
    });
}

#pragma mark - 路由切换
// Modal方式
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

// PUSH方式
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

// 自定义切换
- (void)addRouting:(XFRouting *)nextRouting withTrasitionBlock:(void(^)())trasitionBlock intent:(id)intentData {
    // 绑定关系
    [self _flowToNextRouting:nextRouting];
    // 移除当前视图焦点
    [self.uiOperator viewWillResignFocus];
    // 执行切换界面
    if (trasitionBlock) {
        trasitionBlock();
    }
    // 下一个视图获得焦点，并传送意图数据
    if (self.nextRouting) {
        [self.nextRouting.uiOperator viewWillBecomeFocusWithIntentData:intentData];
    }
}


// 移除当前Routing
- (void)removeRoutingWithTrasitionBlock:(void(^)())trasitionBlock
{
    // 移除当前视图焦点
    [self.uiOperator viewWillResignFocus];
    // 执行切换界面
    if (trasitionBlock) {
        trasitionBlock();
    }
    // 上一个视图获得焦点，并传送意图数据
    if (self.previousRouting) {
        [self.previousRouting.uiOperator viewWillBecomeFocusWithIntentData:[self.uiOperator intentData]];
    }
}

// 释放当前Routing资源
- (void)xfLego_removeRouting
{
    // 解除上一个路由关系链
    if(self.previousRouting) {
        self.previousRouting.nextRouting = nil;
        self.previousRouting = nil;
    }
    
    // 从路由管理中心移除
    [XFRoutingLinkManager removeRouting:self];
    [XFRoutingLinkManager log];
    
    if (!self.observers) return;
    // 删除所有侦听
    for (id<NSObject> observer in self.observers) {
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }
    self.observers = nil;
}


#pragma mark - 绑定模块
+ (instancetype)routing
{
    return [[self alloc] init];
}

- (instancetype)buildModulesAssemblyWithActivityClass:(Class)activityClass
                                       presenterClass:(Class)perstentClass
                                      interactorClass:(Class)interactorClass
                                     dataManagerClass:(Class)dataManagerClass
{
    return [self _bulildMoudlesAssemblyWithInterface:NSStringFromClass(activityClass) navigatorClass:nil presenterClass:perstentClass interactorClass:interactorClass dataManagerClass:dataManagerClass];
}

- (instancetype)buildModulesAssemblyWithActivityClass:(Class)activityClass navigatorClass:(Class)navigatorClass presenterClass:(Class)perstentClass interactorClass:(Class)interactorClass dataManagerClass:(Class)dataManagerClass
{
    return [self _bulildMoudlesAssemblyWithInterface:NSStringFromClass(activityClass) navigatorClass:navigatorClass presenterClass:perstentClass interactorClass:interactorClass dataManagerClass:dataManagerClass];
}

- (instancetype)buildModulesAssemblyWithIB:(NSString *)ibSymbol
                            presenterClass:(Class)perstentClass
                           interactorClass:(Class)interactorClass
                          dataManagerClass:(Class)dataManagerClass
{
    return [self _bulildMoudlesAssemblyWithInterface:ibSymbol navigatorClass:nil presenterClass:perstentClass interactorClass:interactorClass dataManagerClass:dataManagerClass];
}

- (id)_bulildMoudlesAssemblyWithInterface:(NSString *)interface navigatorClass:(Class)navigatorClass  presenterClass:(Class)perstentClass interactorClass:(Class)interactorClass dataManagerClass:(Class)dataManagerClass
{
    XFActivity *activity;
    Class clazz = NSClassFromString(interface);
    // 如果是Class
    if (clazz) {
        activity = [[NSClassFromString(interface) alloc] init];
    }else{
        NSArray<NSString *> *comps = [interface componentsSeparatedByString:@"-"];
        // 如果是xib
        if (comps.count == 2 && [comps[0] containsString:@"x"]) {
            activity = [[XFActivity alloc] initWithNibName:comps[1] bundle:nil];
            
            // 如果是从storyboard中加载
        }else if(comps.count == 3 && [comps[0] containsString:@"s"]){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:comps[1] bundle:nil];
            activity = [storyboard instantiateViewControllerWithIdentifier:comps[2]];
        }else{
            NSLog(@"********************从xib或storyboard加载视图错误!!!***********************");
            NSLog(@"请检查字符串标识：\n\nxib方式:x-xibName\nstoryboard方式:s-storyboardName-controllerIdentifier\n\n");
            NSLog(@"************************************************************************");
            return nil;
        }
    }
    
    self.currentUserInterface = activity;
    
    if (navigatorClass) {
        UINavigationController *navVC = [[navigatorClass alloc] initWithRootViewController:activity];
        self.currentNavigator = navVC;
    }
    
    if (perstentClass) {
        XFPresenter *presenter = [[perstentClass alloc] init];
        [activity setValue:presenter forKey:@"eventHandler"];
        [presenter setValue:self forKey:@"routing"];
        [self setValue:presenter forKey:@"uiOperator"];
        // other...
        if (interactorClass) {
            XFInteractor *interactor = [[interactorClass alloc] init];
            [presenter setValue:interactor forKey:@"interactor"];
            
            if(dataManagerClass){
                XFDataManager *dataManager = [[dataManagerClass alloc] init];
                [interactor setValue:dataManager forKey:@"dataManager"];
            }
        }
        
    }
    
    // 如果有事件处理层
    if (self.uiOperator) {
        // 添加到路由管理中心
        [XFRoutingLinkManager addRouting:self];
        // 打印当前路由
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(LEGONextStep * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [XFRoutingLinkManager log];
        });
    }
    return self;
}

- (void)_flowToNextRouting:(XFRouting *)nextRouting
{
    self.nextRouting = nextRouting;
    nextRouting.previousRouting = self;
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
// 私有方法：路由管理中心通知当前路由发送事件
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
- (__kindof id<XFUserInterfacePort>)realInterface {
    [self _delayDestoryInterfaceRef];
    return self.currentUserInterface ? self.currentUserInterface : [self.uiOperator userInterface];
}

- (__kindof UINavigationController *)realNavigator {
    [self _delayDestoryInterfaceRef];
    return self.currentNavigator ? self.currentNavigator : [LEGORealInterface([self.uiOperator userInterface]) navigationController];
}

// 移除当前类对之的强引用
- (void)_delayDestoryInterfaceRef
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.currentUserInterface = nil;
        self.currentNavigator = nil;
    });
}

#pragma mark - 懒加载
- (NSMutableArray *)observers
{
    if (_observers == nil) {
        _observers = [NSMutableArray array];
    }
    return _observers;
}
@end
