//
//  XFRoutingLinkManager.h
//  XFLegoVIPER
//
//  Created by 付星 on 16/9/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

// 从MVx架构向VIPER模块发事件
#define XF_SendEventFromMVxForVIPERModules_(modulesName,eventName,sendData) \
[XFRoutingLinkManager sendEventName:eventName intentData:sendData forModulesName:modulesName];

@protocol XFUserInterfacePort;
@class XFRouting;
@interface XFRoutingLinkManager : NSObject
/**
 *  添加一个路由
 *
 *  @param routing 路由
 */
+ (void)addRouting:(XFRouting *)routing;
/**
 *  移除一个路由
 *
 *  @param routing 路由
 */
+ (void)removeRouting:(XFRouting *)routing;

/**
 *  跟踪将有跳转动作的路由
 *
 *  @param routing 路由
 */
+ (void)setCurrentActionRounting:(XFRouting *)routing;
/**
 *  获得将有跳转动作的路由
 *
 */
+ (XFRouting *)currentActionRouting;

/**
 *  存储共享路由
 *
 *  @param routing    路由
 *  @param moduleName 共享模块名
 */
+ (void)setSharedRounting:(XFRouting *)routing shareModule:(NSString *)moduleName;

/**
 *  返回共享路由
 *
 *  @param moduleName 共享模块名
 *
 */
+ (XFRouting *)sharedRoutingForShareModule:(NSString *)moduleName;

/**
 *  总数
 *
 *  @return 路由个数
 */
+ (NSInteger)count;

/**
 *  根据模块名查找对应路由
 *
 *  @param moduleName 模块名
 *
 *  @return 路由
 */
+ (XFRouting *)findRoutingForModuleName:(NSString *)moduleName;

/**
 *  对VIPER架构模块发送事件数据
 *
 *  @param eventName  事件名
 *  @param intentData 消息数据
 *  @param modulesName 模块名数组
 */
+ (void)sendEventName:(NSString *)eventName intentData:(id)intentData forModulesName:(NSArray<NSString *> *)modulesName;

/**
 *  设置模块前辍
 *  注意：
 1.要设置就在第一个模块加载前设置
 2.设置了前辍后，模块路由类必须以"Routing"结尾，否则内部会找不到对应模块
 *
 */
+ (void)setModulePrefix:(NSString *)prefix;
/**
 *  返回模块前辍
 *
 */
+ (NSString *)modulePrefix;

/**
 *  允许打印log
 */
+ (void)enableLog;

/**
 *  打印当前所有路由信息
 */
+ (void)log;
@end
