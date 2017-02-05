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

- (void)sendEventName:(NSString *)eventName intentData:(id)intentData,...
{
    // 指向变参的指针
    va_list args;
    // 使用最后一个参数来初使化list指针
    va_start(args, intentData);
    while (YES)
    {
        // 返回可变参数，va_arg第二个参数为可变参数类型，如果有多个可变参数，依次调用可获取各个参数
        NSString *componentName = va_arg(args, NSString*);
        if (!componentName) {
            break;
        }
        [XFComponentManager sendEventName:eventName intentData:intentData forComponent:componentName];
    }
    // 结束可变参数的获取
    va_end(args);
    
}

- (void)sendNotificationForMVxWithName:(NSString *)notiName intentData:(id)intentData
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:nil userInfo:intentData];
}

- (void)registerMVxNotificationsForTarget:(id)target,... {
    // 如果没有接收方法，直接返回
    if (![self.componentRoutable respondsToSelector:@selector(receiveComponentEventName:intentData:)]) {
        NSAssert(NO, @"当前可运行组件没有接收方法！");
        return;
    }
    va_list args;
    va_start(args, target);
    while (YES)
    {
        NSString *notiName = va_arg(args, NSString*);
        if (!notiName) {
            break;
        }
        XF_Define_Weak
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
    va_end(args);
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
