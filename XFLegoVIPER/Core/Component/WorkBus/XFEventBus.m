//
//  XFEventBus.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFEventBus.h"
#import "XFComponentRoutable.h"
#import "XFLegoMarco.h"
#import "XFComponentManager.h"


@interface XFEventBus ()

/**
 *  可运行组件
 */
@property (nonatomic, weak) __kindof id<XFComponentRoutable> componentRoutable;

/**
 *  所有用侦听通知的对象
 */
@property (nonatomic, strong) NSMutableArray *observers;
@end

@implementation XFEventBus

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

- (void)sendEventName:(NSString *)eventName intentData:(id)intentData forComponentName:(NSString *)componentName
{
    [XFComponentManager sendEventName:eventName intentData:intentData forComponents:@[componentName]];
}

- (void)sendEventName:(NSString *)eventName intentData:(id)intentData forComponentNames:(NSArray<NSString *> *)componentNames
{
    [XFComponentManager sendEventName:eventName intentData:intentData forComponents:componentNames];
}

- (void)sendNotificationForMVxWithName:(NSString *)notiName intentData:(id)intentData
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:nil userInfo:intentData];
}

- (void)registerForMVxNotificationsWithNameArray:(NSArray<NSString *> *)notiNames {
    // 如果没有接收方法，直接返回
    if (![self.componentRoutable respondsToSelector:@selector(receiveComponentEventName:intentData:)]) {
        NSAssert(NO, @"当前可运行组件没有接收方法！");
        return;
    }
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
                    // 通知组件接收事件
                    [self.componentRoutable receiveComponentEventName:note.name intentData:note.userInfo];
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

// 删除所有侦听
- (void)_removeObservers {
    if (_observers) {
        for (id<NSObject> observer in _observers) {
            [[NSNotificationCenter defaultCenter] removeObserver:observer];
        }
        _observers = nil;
    }
}

- (void)dealloc
{
    [self _removeObservers];
}
@end
