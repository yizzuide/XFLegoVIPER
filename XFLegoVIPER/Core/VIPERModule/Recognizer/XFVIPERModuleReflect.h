//
//  XFVIPERModuleReflect.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/25.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

// 在模块组成类中获得模块名（不支持Interactor、DataManager）
#define XF_ModuleName [XFVIPERModuleReflect moduleNameForModuleLayerObject:self]
// 在子路由类中获得模块名 （只支持在子路由类方法中使用）
#define XF_ModuleNameForSuperRoutingClass [XFVIPERModuleReflect moduleNameForSuperRoutingClass:self]

@class XFRouting;
@interface XFVIPERModuleReflect : NSObject

/**
 *  获得一个路由类的模块名
 *
 *  @param routingClass 路由类
 *
 *  @return 模块名
 */
+ (NSString *)moduleNameForRoutingClass:(Class)routingClass;
/**
 *  从一个子路由类获得父路由类的模块名
 *
 *  @param subRoutingClass 子路由类
 *
 *  @return 模块名
 */
+ (NSString *)moduleNameForSuperRoutingClass:(Class)subRoutingClass;
/**
 *  获得一个路由对象的模块名
 *
 *  @param routing 路由
 *
 *  @return 模块名
 */
+ (NSString *)moduleNameForRouting:(XFRouting *)routing;
/**
 *  在模块组成对象中获得模块名（不支持Interactor、DataManager）
 *
 *  @param moduleLayerObject 模块组成对象
 *
 *  @return 模块名
 */
+ (NSString *)moduleNameForModuleLayerObject:(id)moduleLayerObject;

/**
 *  在模块组成类中获得模块名（不支持Interactor、DataManager）
 *
 *  @param moduleLayerClass 模块组成类
 *
 *  @return 模块名
 */
+ (NSString *)moduleNameForModuleLayerClass:(Class)moduleLayerClass;
/**
 *  根据模块名，获得一个路由类，这个方法两个作用：
 *  1.创建一般模块类：返回工程中存在的模块类
 *  2.创建子模块类：先检测出父模块名，创建出父模块类，再使用OC运行时创建出子模块类
 *
 *  @param moduleName 模块名
 *
 *  @return 路由类
 */
+ (Class)routingClassFromModuleName:(NSString *)moduleName;
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
/**
 *  解析父模块名
 *
 *  @param subModuleName 子模块名
 *
 *  @return 父模块名
 */
+ (NSString *)inspectSuperModuleNameFromSubModuleName:(NSString *)subModuleName;
@end
