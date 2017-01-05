//
//  XFEventBus.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

// 发送组件消息（推荐，包括模块可运行组件、控制器可运行组件）
#define XF_SendEventForComponent_(componentName,eventName,sendData) \
[self.eventBus sendEventName:eventName intentData:sendData forComponentName:componentName];
#define XF_SendEventForComponents_(componentNames,eventName,sendData) \
[self.eventBus sendEventName:eventName intentData:sendData forComponentNames:componentNames];

// 发送模块组件事件消息（过时）
#define XF_SendEventForModule_(moduleName,eventName,sendData) \
XF_SendEventForComponent_(moduleName,eventName,sendData)
#define XF_SendEventForModules_(moduleNames,eventName,sendData) \
XF_SendEventForComponents_(moduleNames,eventName,sendData)


// 发通知
#define XF_SendMVxNoti_(notiName,sendData) \
[self.eventBus sendNotificationForMVxWithName:notiName intentData:sendData];
// 注册通知
#define XF_RegisterMVxNotis_(notisName) \
[self.eventBus registerForMVxNotificationsWithNameArray:notisName];

// 快速事件类型检测执行的宏
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
 *  对单个组件发送事件消息
 *
 *  @param eventName        事件名
 *  @param intentData       消息数据
 *  @param componentName    组件名
 */
- (void)sendEventName:(NSString *)eventName intentData:(id)intentData forComponentName:(NSString *)componentName;

/**
 *  对多个组件组件发送事件消息
 *
 *  @param eventName        事件名
 *  @param intentData       消息数据
 *  @param componentNames   组件名数组
 */
- (void)sendEventName:(NSString *)eventName intentData:(id)intentData forComponentNames:(NSArray<NSString *> *)componentNames;

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
 *  @param notiNames 通知名数组
 */
- (void)registerForMVxNotificationsWithNameArray:(NSArray<NSString *> *)notiNames;

@end
