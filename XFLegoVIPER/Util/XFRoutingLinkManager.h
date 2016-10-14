//
//  XFRoutingLinkManager.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/9/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFRouting.h"

// 从MVx架构向VIPER模块发事件
#define XF_SendEventFormMVxForVIPERMoudles_(moudlesName,eventName,sendData) \
[XFRoutingLinkManager sendEventName:eventName intentData:sendData forMoudlesName:moudlesName];

@protocol XFUserInterfacePort;
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
 *  根据模块名查找对应路由
 *
 *  @param moudleName 模块名
 *
 *  @return 路由
 */
+ (XFRouting *)findRoutingForMoudleName:(NSString *)moudleName;

/**
 *  对VIPER架构模块发送事件数据
 *
 *  @param eventName  事件名
 *  @param intentData 消息数据
 *  @param moudlesName 模块名数组
 */
+ (void)sendEventName:(NSString *)eventName intentData:(id)intentData forMoudlesName:(NSArray<NSString *> *)moudlesName;

/**
 *  生成一个子路由，并绑定到父路由模块
 *
 *  @param routingClass     子路由类
 *  @param parentUInterface 父视图
 *
 *  @return 子路由
 */
+ (XFRouting *)produceSubRoutingFromClass:(Class)routingClass parentUInterface:(__kindof id<XFUserInterfacePort>)parentUInterface;

/**
 *  设置模块前辍，让模块查找更佳精准，避免模块与子模块有部分位置名相同查找错误问题
 *  注意：
    1.要设置就在第一个模块加载前设置,不然后面模块搜索会出问题，要么就不要设置
    2.设置了前辍后，模块路由类必须以"Routing"结尾，否则内部会找不到对应模块
 *
 */
+ (void)setMoudlePrefix:(NSString *)prefix;
/**
 *  返回模块前辍
 *
 */
+ (NSString *)moudlePrefix;
/**
 *  允许打印log
 */
+ (void)enableLog;

/**
 *  打印当前所有路由信息
 */
+ (void)log;
@end
