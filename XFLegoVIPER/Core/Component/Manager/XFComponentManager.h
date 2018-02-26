//
//  XFComponentManager.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/20.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

// 给某个组件发事件数据
#define XF_SendEventForComponent_(eventName, sendData, componentName) \
[XFComponentManager sendEventName:eventName intentData:sendData forComponent:componentName];

@protocol XFEventReceivable;
@protocol XFComponentRoutable;
NS_ASSUME_NONNULL_BEGIN
@interface XFComponentManager : NSObject

/**
 *  添加组件
 *
 *  @param component 组件
 *  @param enableLog 允许组件跟踪打印
 */
+ (void)addComponent:(id<XFComponentRoutable>)component enableLog:(BOOL)enableLog;
/**
 * 添加组件，并自定义组件名
 */
+ (void)addComponent:(id<XFComponentRoutable>)component forName:(NSString *)componentName;
/**
 *  删除组件
 *
 *  @param component 组件
 */
+ (void)removeComponent:(id<XFComponentRoutable>)component;
/**
 * 根据组件名删除组件
 */
+ (void)removeComponentForName:(NSString *)componentName;

/**
 * 添加一个不兼容组件（在viewDidLoad里可以把旧项目的控制器添加到容器，实现事件机制功能）
 * @param incompatibleComponent 实现事件派发端口的任意对象
 * @param componentName         组件名
 */
+ (void)addIncompatibleComponent:(id<XFEventReceivable>)incompatibleComponent componentName:(NSString *)componentName;
/**
 * 移除一个不兼容组件（在dealloc里使用这个方法移除）
 * @param componentName  组件名
 */
+ (void)removeIncompatibleComponentWithName:(NSString *)componentName;

/**
 * 添加一个事件接受者
 * @param receiver       实现事件派发端口的任意对象
 * @param componentName  组件名
 */
+ (void)addEventReceiver:(id<XFEventReceivable>)receiver componentName:(NSString *)componentName;
/**
 * 移除一个事件接受者
 * @param componentName  组件名
 */
+ (void)removeEventReceiverComponentWithName:(NSString *)componentName;

/**
 *  组件总数
 *
 */
+ (NSInteger)count;
/**
 *  查找一个组件
 *
 *  @param componentName 组件名
 *
 *  @return 组件
 */
+ (id<XFComponentRoutable>)findComponentForName:(NSString *)componentName;
/**
 *  发送组件事件消息
 *
 *  @param eventName      事件名
 *  @param intentData     消息意图数据
 *  @param componentName  组件名
 */
+ (void)sendEventName:(NSString *)eventName intentData:(nullable id)intentData forComponent:(NSString *)componentName;
/**
 *  发送多个组件事件消息
 *
 *  @param eventName      事件名
 *  @param intentData     消息意图数据
 *  @param componentNames 组件名数组
 */
+ (void)sendEventName:(NSString *)eventName intentData:(nullable id)intentData forComponents:(NSArray<NSString *> *)componentNames;
/**
 *  接管事件发射器发送事件
 *
 *  @param eventName      事件名
 *  @param intentData     消息意图数据
 */
+ (void)sendGlobalEventName:(NSString *)eventName intentData:(nullable id)intentData;

@end
NS_ASSUME_NONNULL_END
