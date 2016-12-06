//
//  XFRoutingReflect.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/25.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

// 在模块组成类中获得模块名（不支持Interactor、DataManager）
#define XF_ModuleName [XFRoutingReflect moduleNameForComponentObject:self]

@class XFRouting;
@interface XFRoutingReflect : NSObject

/**
 *  获得一个路由的模块名
 *
 *  @param routing 路由
 *
 *  @return 模块名
 */
+ (NSString *)moduleNameForRouting:(XFRouting *)routing;
/**
 *  在模块组成类中获得模块名（不支持Interactor、DataManager）
 *
 *  @param componentObject 模块组成对象
 *
 *  @return 模块名
 */
+ (NSString *)moduleNameForComponentObject:(id)componentObject;
/**
 *  验证一个模块是否存在
 *
 *  @param moduleName 模块名
 *
 *  @return 模块是否存在
 */
+ (BOOL)verifyModule:(NSString *)moduleName;
/**
 *  验证模块关系链
 *
 *  @param modules 模块名数组
 *
 *  @return 模块关系链是否正确
 */
+ (BOOL)verifyModuleLinkForList:(NSArray<NSString *> *)modules;
/**
 *  解析模块前辍
 *
 *  @param clazz 类
 */
+ (void)inspectModulePrefixFromClass:(Class)clazz;
@end
