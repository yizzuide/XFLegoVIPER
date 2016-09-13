//
//  XFWireframe.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFWireframe_h
#define XFWireframe_h

#import <UIKit/UIKit.h>

@protocol XFWireFramePort <NSObject>

/**
 *  dismiss当前视图(注意：返回到上一个界面的意图数据需要在当前模块的Presenter里设置intentData属性）
 */
- (void)dismiss;

/**
 *  推出当前视图(注意：返回到上一个界面的意图数据在需要当前模块的Presenter里设置intentData属性）
 */
- (void)pop;

/**
 *  VIPER架构里对单个模块间通信
 *
 *  @param eventName  事件名
 *  @param intentData 消息数据
 *  @param moudleName 业务模块名
 */
- (void)sendEventName:(NSString *)eventName intentData:(id)intentData forMoudleName:(NSString *)moudleName;

/**
 *  VIPER架构里对多模块间通信
 *
 *  @param name       事件名
 *  @param intentData 消息数据
 *  @param moudlesName 业务模块名数组
 */
- (void)sendEventName:(NSString *)eventName intentData:(id)intentData forMoudlesName:(NSArray<NSString *> *)moudlesName;

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
@end

#endif /* XFWireframe_h */
