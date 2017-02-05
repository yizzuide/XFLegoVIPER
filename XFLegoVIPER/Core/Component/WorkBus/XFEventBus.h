//
//  XFEventBus.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

// 发送组件消息（参数依次为：事件名，消息数据对象，多个组件多变参数)
#define XF_SendEventForComponents_(eventName, sendData, ...) \
[self.eventBus sendEventName:eventName intentData:sendData,##__VA_ARGS__,nil];

// 发通知
#define XF_SendMVxNoti_(notiName,sendData) \
[self.eventBus sendNotificationForMVxWithName:notiName intentData:sendData];
// 注册通知（参数为多个通知名，使用,分开）
#define XF_RegisterMVxNotis_(...) \
[self.eventBus registerMVxNotificationsForTarget:self,##__VA_ARGS__,nil];

// 快速事件类型匹配的宏
#define XF_EventIs_(EventName,ExecuteCode) \
if ([eventName isEqualToString:EventName]) { \
    ExecuteCode \
    return; \
}

@protocol XFComponentRoutable;
@interface XFEventBus : NSObject

/**
 *  初始化方法
 *
 *  @param componentRoutable 可运行组件
 *
 *  @return XFEventBus
 */
- (instancetype)initWithComponentRoutable:(__kindof id<XFComponentRoutable>)componentRoutable NS_DESIGNATED_INITIALIZER;

/**
 *  对多个组件组件发送事件消息
 *
 *  @param eventName        事件名
 *  @param intentData       消息数据
 *  @param ...              多个组件名
 */
- (void)sendEventName:(NSString *)eventName intentData:(id)intentData,...;

/**
 *  发送全局通知
 *
 *  @param notiName   通知名
 *  @param intentData 消息数据
 */
- (void)sendNotificationForMVxWithName:(NSString *)notiName intentData:(id)intentData;

/**
 *  注册通知
 *
 *  @param target 通知侦听目标
 *  @param ...    多个通知名
 */
- (void)registerMVxNotificationsForTarget:(id)target,...;

@end
