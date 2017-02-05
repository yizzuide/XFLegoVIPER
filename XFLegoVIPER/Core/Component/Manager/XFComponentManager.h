//
//  XFComponentManager.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/20.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XFComponentRoutable;
@interface XFComponentManager : NSObject

/**
 *  添加组件
 *
 *  @param component 组件
 *  @param enableLog 允许组件跟踪打印
 */
+ (void)addComponent:(id<XFComponentRoutable>)component enableLog:(BOOL)enableLog;
/**
 *  删除组件
 *
 *  @param component 组件
 */
+ (void)removeComponent:(id<XFComponentRoutable>)component;
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
+ (void)sendEventName:(NSString *)eventName intentData:(id)intentData forComponent:(NSString *)componentName;
@end
