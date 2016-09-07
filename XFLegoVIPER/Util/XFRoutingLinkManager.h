//
//  XFRoutingLinkManager.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/9/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFRoutingLinkManager : NSObject
/**
 *  添加一个路由
 *
 *  @param routing 路由
 */
+ (void)addRouting:(id)routing;
/**
 *  移除一个路由
 *
 *  @param routing 路由
 */
+ (void)removeRouting:(id)routing;

/**
 *  对VIPER架构模块发送事件数据
 *
 *  @param eventName  事件名
 *  @param intentData 消息数据
 *  @param moudlesName 模块名数组
 */
+ (void)sendEventName:(NSString *)eventName intentData:(id)intentData forMoudlesName:(NSArray<NSString *> *)moudlesName;
/**
 *  打印log
 */
+ (void)log;
@end
