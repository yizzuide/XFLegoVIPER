//
//  XFLegoConfig.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/23.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFURLRoutePlug.h"
#import "XFComponentHandlerPlug.h"

/**
 *  乐高框架启动配置类
 */
@interface XFLegoConfig : NSObject

/**
 *  返回共享实例
 *
 *  @return 配置对象
 */
+ (instancetype)shareInstance;
/**
 *  设置框架默认配置，并返回共享实例
 *
 *  @return 配置类
 */
+ (instancetype)defaultConfig;

/**
 *  开启log
 *
 *  @return 配置类
 */
- (instancetype)enableLog;
/**
 *  是否能打印log
 *
 */
@property (NS_NONATOMIC_IOSONLY, readonly) BOOL canDebugLog;

/**
 *  设置类前缀（注意：如果没有一个使用VIPER的模块，必须手动设置）
 *
 */
- (instancetype)setClassPrefix:(NSString *)prefix;
/**
 *  返回类前缀
 *
 */
- (NSString *)classPrefix;
/**
 * 设置类前缀列表
 */
- (instancetype)setClassPrefixList:(NSArray *)prefixList;
/**
 *  返回类前缀列表
 */
- (NSArray *)classPrefixList;

/**
 *  返回swift命名空间
 */
- (NSString *)swiftNamespace;

/**
 *  设置URL路由插件
 *
 *  @param routePlugClass URL路由解析类
 *
 *  @return 配置类
 */
- (instancetype)setRoutePlug:(Class<XFURLRoutePlug>)routePlugClass;
/**
 *  URL路由插件
 *
 */
- (Class<XFURLRoutePlug>)routePlug;
/**
 *  添加组件处理器插件（内部包含VIPER模块组件处理器、控制器组件处理器）
 *
 *  @param componentHanderPlug 组件处理器插件类
 *
 *  @return 配置类
 */
- (instancetype)addComponentHanderPlug:(Class<XFComponentHandlerPlug>)componentHanderPlug;
/**
 *  所有组件处理器插件
 *
 */
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray<Class<XFComponentHandlerPlug>> *allComponentHanderPlugs;
@end
