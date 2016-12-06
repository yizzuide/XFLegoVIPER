//
//  XFEventBus.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XFRouting;
@interface XFEventBus : NSObject
/**
 *  路由
 */
@property (nonatomic, weak) XFRouting *fromRouting;

/**
 *  初始化方法
 *
 *  @param fromRouting 路由
 *
 *  @return XFEventBus
 */
- (instancetype)initWithFromRouting:(XFRouting *)fromRouting;

/**
 *  VIPER架构里对单个模块间通信
 *
 *  @param eventName  事件名
 *  @param intentData 消息数据
 *  @param moduleName 业务模块名
 */
- (void)sendEventName:(NSString *)eventName intentData:(id)intentData forModuleName:(NSString *)moduleName;

/**
 *  VIPER架构里对多模块间通信
 *
 *  @param eventName    事件名
 *  @param intentData   消息数据
 *  @param modulesName  业务模块名数组
 */
- (void)sendEventName:(NSString *)eventName intentData:(id)intentData forModulesName:(NSArray<NSString *> *)modulesName;

/**
 *  VIPER架构模块对MV*模块发送通知
 *
 *  @param notiName   通知名
 *  @param intentData 消息数据
 */
- (void)sendNotificationForMVxWithName:(NSString *)notiName intentData:(id)intentData;

/**
 *  注册MVx架构中发出的通知
 *
 *  @param notiNames 通知名数组
 */
- (void)registerForMVxNotificationsWithNameArray:(NSArray<NSString *> *)notiNames;

/**
 *  移除侦听者
 */
- (void)removeObservers;
@end
