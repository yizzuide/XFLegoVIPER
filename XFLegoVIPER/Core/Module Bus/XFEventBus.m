//
//  XFEventBus.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFEventBus.h"
#import "XFRouting.h"
#import "XFRoutingLinkManager.h"


@interface XFEventBus ()
/**
 *  所有用侦听通知的对象
 */
@property (nonatomic, strong) NSMutableArray *observers;
@end

@implementation XFEventBus

- (instancetype)initWithFromRouting:(XFRouting *)fromRouting
{
    self = [super init];
    if (self) {
        self.fromRouting = fromRouting;
    }
    return self;
}

// VIPER架构里对单个模块间通信
- (void)sendEventName:(NSString *)eventName intentData:(id)intentData forModuleName:(NSString *)moduleName
{
    [XFRoutingLinkManager sendEventName:eventName intentData:intentData forModulesName:@[moduleName]];
}
// VIPER架构里对多模块间通信
- (void)sendEventName:(NSString *)eventName intentData:(id)intentData forModulesName:(NSArray<NSString *> *)modulesName
{
    [XFRoutingLinkManager sendEventName:eventName intentData:intentData forModulesName:modulesName];
}

// 私有方法：路由管理中心通知当前路由发送事件
- (void)_sendEventName:(NSString *)eventName intentData:(id)intentData
{
    [self.fromRouting.uiOperator receiveComponentEventName:eventName intentData:intentData];
}

// VIPER架构模块对MV*模块发送通知
- (void)sendNotificationForMVxWithName:(NSString *)notiName intentData:(id)intentData
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:nil userInfo:intentData];
}

// 注册从MVx架构中发出的通知
- (void)registerForMVxNotificationsWithNameArray:(NSArray<NSString *> *)notiNames {
    XF_Define_Weak
    for (NSString *notiName in notiNames) {
        // 侦听通知
        id<NSObject> observer=
        [[NSNotificationCenter defaultCenter]
         addObserverForName:notiName
                    object:nil
                    queue:[NSOperationQueue mainQueue]
                usingBlock:^(NSNotification * _Nonnull note) {
                    XF_Define_Strong
                    // 通知事件处理层接收事件
                    [self.fromRouting.uiOperator receiveComponentEventName:note.name intentData:note.userInfo];
                }];
        // 添加到侦听数组
        [self.observers addObject:observer];
    }
}

- (NSMutableArray *)observers
{
    if (_observers == nil) {
        _observers = [NSMutableArray array];
    }
    return _observers;
}

- (void)removeObservers {
    // 删除所有侦听
    if (_observers) {
        for (id<NSObject> observer in _observers) {
            [[NSNotificationCenter defaultCenter] removeObserver:observer];
        }
        _observers = nil;
    }
}
@end
