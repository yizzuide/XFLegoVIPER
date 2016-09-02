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
 *  根据模块业务名查找一个路由
 *
 *  @param moudleName 模块业务名
 *
 *  @return 路由
 */
+ (id)findRoutingForMoudleName:(NSString *)moudleName;
/**
 *  打印log
 */
+ (void)log;
@end
