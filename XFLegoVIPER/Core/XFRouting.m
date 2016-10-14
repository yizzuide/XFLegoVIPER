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
#import "NSObject+XFLegoInvokeMethod.h"

#define WS(weakSelf) __weak typeof(self) weakSelf = self;

@interface XFRouting ()

/**
 *  上一个关联的模块路由
 */
@property (nonatomic, weak, readwrite) XFRouting *previousRouting;
/**
 *  下一个关联的模块路由
 */
@property (nonatomic, weak, readwrite) XFRouting *nextRouting;

/**
 *  父路由
 */
@property (nonatomic, weak, readwrite) XFRouting *parentRouting;

/**
 *  子路由
 */
@property (nonatomic, strong, readwrite) NSMutableArray<XFRouting *> *subRoutes;

/**
 *  当前视图
 */
@property (nonatomic, strong) id<XFUserInterfacePort> currentUserInterface;
/**
 *  当前导航
 */
@property (nonatomic, strong) UINavigationController *currentNavigator;

/**
 *  事件层
 */
@property (nonatomic, weak, readwrite) id<XFUIOperatorPort> uiOperator;

/**
 *  所有用侦听通知的对象
 */
@property (nonatomic, strong) NSMutableArray *observers;
/**
 *  标识当前路由是否被释放过资源
 */
@property (nonatomic, assign, getter=hadReleaseStuff) BOOL releaseStuff;
@end

@implementation XFRouting

- (void)showRootActivityOnWindow:(UIWindow *)mainWindow
{
    id navigator = [self realNavigator];
    if (navigator) {
        mainWindow.rootViewController = LEGORealInterface(navigator);
    }else{
        mainWindow.rootViewController = MainActivity;
    }
    [mainWindow makeKeyAndVisible];
}

#pragma mark - MVx控制器切换
- (void)pushMVxViewController:(UIViewController *)viewController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[MainActivity navigationController] pushViewController:viewController animated:YES];
    });
}

- (void)presentMVxViewController:(UIViewController *)viewController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MainActivity presentViewController:viewController animated:YES completion:nil];
    });
}

#pragma mark - 路由切换
// Modal方式
- (void)presentRouting:(XFRouting *)nextRouting intent:(id)intentData
{
    [self putRouting:nextRouting withTrasitionBlock:^(XFActivity *thisInterface, XFActivity *nextInterface) {
        [thisInterface presentViewController:nextInterface animated:YES completion:nil];
    } intent:intentData];
}

- (void)dismiss
{
    [self removeRoutingWithTrasitionBlock:^(XFActivity *thisInterface, XFActivity *nextInterface) {
        [thisInterface dismissViewControllerAnimated:YES completion:nil];
    }];
}

// PUSH方式
- (void)pushRouting:(XFRouting *)nextRouting intent:(id)intentData
{
    [self putRouting:nextRouting withTrasitionBlock:^(XFActivity *thisInterface, XFActivity *nextInterface) {
        [thisInterface.navigationController pushViewController:nextInterface animated:YES];
    } intent:intentData];
}

- (void)pop
{
    [self removeRoutingWithTrasitionBlock:^(XFActivity *thisInterface, XFActivity *nextInterface) {
        [thisInterface.navigationController popViewControllerAnimated:YES];
    }];
}

// 自定义切换
- (void)putRouting:(XFRouting *)nextRouting withTrasitionBlock:(TrasitionBlock)trasitionBlock intent:(id)intentData {
    // 绑定关系
    [self _flowToNextRouting:nextRouting];
    // 移除当前视图焦点
    [self.uiOperator viewWillResignFocus];
    // 执行切换界面
    if (trasitionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            trasitionBlock(MainActivity,LEGORealInterface(nextRouting.realInterface));
        });
    }
    // 下一个视图获得焦点，并传送意图数据
    if (self.nextRouting) {
        [self.nextRouting.uiOperator viewWillBecomeFocusWithIntentData:intentData];
    }
}


#pragma mark - 路由管理
// 添加子路由
- (__kindof id<XFUserInterfacePort>)addSubRouting:(XFRouting *)subRouting asChildInterface:(BOOL)asChildInterface
{
    subRouting.subRoute = YES;
    XFActivity *subInterface = LEGORealInterface(subRouting.realInterface);
    if (asChildInterface) {
        [MainActivity addChildViewController:subInterface];
    }
    [self.subRoutes addObject:subRouting];
    subRouting.parentRouting = self;
    return subInterface;
}


// 移除当前Routing
- (void)removeRoutingWithTrasitionBlock:(TrasitionBlock)trasitionBlock
{
    // 标识为程序移除
    [self invokeMethod:@"setPoppingProgrammatically:" param:[NSNumber numberWithBool:YES] forObject:MainActivity];
    // 开始移除当前路由并切换
    [self _startRemoveRoutingWithTrasitionBlock:trasitionBlock];
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
    [self _startRemoveRoutingWithTrasitionBlock:nil];
}

- (void)_startRemoveRoutingWithTrasitionBlock:(TrasitionBlock)trasitionBlock
{
    // 移除当前视图焦点
    [self.uiOperator viewWillResignFocus];
    
    // 执行切换界面
    if (trasitionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            trasitionBlock(MainActivity,nil);
        });
    }
    
    // 上一个视图获得焦点，并传送意图数据
    if (self.previousRouting) {
        [self.previousRouting.uiOperator viewWillBecomeFocusWithIntentData:[self.uiOperator intentData]];
    }
    
    // 释放路由
    [self _releaseRouting:self];
    // 打印路由关系链
    [XFRoutingLinkManager log];
}

// 递归释放路由方法
- (void)_releaseRouting:(XFRouting *)routing
{
    // 解除上一个路由关系链
    if(routing.previousRouting) {
        routing.previousRouting.nextRouting = nil;
        routing.previousRouting = nil;
    }
    
    // 删除所有侦听
    if (routing->_observers) {
        for (id<NSObject> observer in routing->_observers) {
            [[NSNotificationCenter defaultCenter] removeObserver:observer];
        }
        routing->_observers = nil;
    }
    
    // 释放子路由
    if (routing->_subRoutes) {
        for (XFRouting *subRoute in routing->_subRoutes) {
            [self _releaseRouting:subRoute];
        }
        // 删除所有子路由
        [routing->_subRoutes removeAllObjects];
        routing->_subRoutes = nil;
    }
    
    // 从路由管理中心移除
    [XFRoutingLinkManager removeRouting:routing];
    
    // 标识释放过当前路由
    routing.releaseStuff = YES;
}

- (void)dealloc
{
    // 如果当前模块为MVx父控制器的子模块，且没有释放过
    if (!self.hadReleaseStuff) {
        [self _startRemoveRoutingWithTrasitionBlock:nil];
    }
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
        if ([comps[XF_Index_First] containsString:@"x"]) {
            if (comps.count == XF_Index_Third) {
                 Class activityClass = NSClassFromString(comps[XF_Index_Second]);
                if (activityClass) { // 如果第二个参数就是Activity类
                     activity = [[activityClass alloc] initWithNibName:comps[XF_Index_Second] bundle:nil];
                }else{ // 使用XFActivity类
                    activity = [[XFActivity alloc] initWithNibName:comps[XF_Index_Second] bundle:nil];
                }
            }else if(comps.count == XF_Index_Fourth){ // 如果有指定Activity类型
                Class activityClass = NSClassFromString(comps[XF_Index_Third]);
                if (activityClass) {
                    activity = [[activityClass alloc] initWithNibName:comps[XF_Index_Second] bundle:nil];
                }else{
                    NSLog(@"********************ActivityClass加载错误!!!***********************");
                    return nil;
                }
            }
            
            // 如果是从storyboard中加载
        }else if(comps.count == XF_Index_Fourth && [comps[XF_Index_First] containsString:@"s"]){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:comps[XF_Index_Second] bundle:nil];
            activity = [storyboard instantiateViewControllerWithIdentifier:comps[XF_Index_Third]];
        }else{
            NSLog(@"********************从xib或storyboard加载视图错误!!!***********************");
            NSLog(@"请检查字符串标识：\n\nxib方式:x-xibName[-activityClass]\nstoryboard方式:s-storyboardName-controllerIdentifier\n\n");
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

// 移除当前路由对视图层的强引用
- (void)_delayDestoryInterfaceRef
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (true) {
            // 当事件层能拿到视图时，立即释放对它的强引用
            if ([self.uiOperator userInterface]) {
                self.currentUserInterface = nil;
                self.currentNavigator = nil;
                break;
            }
            sleep(1);
        }
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

- (NSMutableArray<XFRouting *> *)subRoutes
{
    if (_subRoutes == nil) {
        _subRoutes = [NSMutableArray array];
    }
    return _subRoutes;
}
@end
