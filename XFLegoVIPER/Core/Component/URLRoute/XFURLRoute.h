//
//  XFURLRoute.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/7.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XFComponentRoutable;
@interface XFURLRoute : NSObject
/**
 *  一次性初始化多个URL组件
 *
 *  @param urlGroup 参数必需是NSDictionary<URLString,ModuleName>类型或NSArray<URLString(最后一个路径必需是模块名)>类型
 */
+ (void)initURLGroup:(id)urlGroup;
/**
 *  初始化单个URL组件，如：xf://user/register
 *
 *  @param url URLString
 */
+ (void)register:(NSString *)url;
/**
 *  初始化单个URL组件
 *
 *  @param url           URLString
 *  @param componentName 组件名
 */
+ (void)register:(NSString *)url forComponent:(NSString *)componentName;
/**
 *  移除单个URL组件
 *
 *  @param url URLString
 */
+ (void)remove:(NSString *)url;

/**
 *  设置针对HTTP处理者
 *
 *  @param componentName 组件名
 */
+ (void)setHTTPHandlerComponent:(NSString *)componentName;

/**
 *  打一个URL组件,如：xf://user/register?usrid=123
 *
 *  @param url             url
 *  @param transitionBlock 界面切换代码
 *
 *  @return 打开是否成功
 */
+ (BOOL)open:(NSString *)url transitionBlock:(void(^)(NSString *componentName,NSDictionary *params))transitionBlock;
/**
 *  开启URL路径的组件关系链验证功能
 */
+ (void)enableVerifyURLRoute;
@end
