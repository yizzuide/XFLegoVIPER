//
//  XFModuleReflect.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/3/15.
//  Copyright © 2017年 Yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFModuleReflect : NSObject

/**
 *  根据子模块名动态创建一个子模块,这个方法两个作用：
 *  1.创建一般模块类：返回工程中存在的模块类
 *  2.创建子模块类：先检测出父模块名，创建出父模块类，再使用OC运行时创建出子模块类
 *
 *  @param subModuleName 模块名
 *  @param stuffixName   后辍后
 *  @param superModule   父模块名，返回给外面的数据
 *
 *  @return 子模块
 */
+ (Class)createDynamicSubModuleClassFromName:(NSString *)subModuleName stuffixName:(NSString *)stuffixName superModule:(NSString **)superModule;
/**
 *  解析父模块名
 *
 *  @param subModuleName 子模块名
 *  @param stuffixName 后辍名
 *
 *  @return 父模块名
 */
+ (NSString *)inspectSuperModuleNameFromSubModuleName:(NSString *)subModuleName stuffixName:(NSString *)stuffixName;

/**
 *  解析模块前辍，用于区分OC模块还是Swift模块
 *
 *  @param moduleName  模块名
 *  @param stuffixName 模块关键层后辍
 *
 *  @return 模块前辍
 */
+ (NSString *)inspectModulePrefixWithModule:(id)module stuffixName:(NSString *)stuffixName;
/**
 *  验证一个模块是否存在
 *
 *  @param moduleName 模块名
 *  @param stuffixName 后辍名
 *
 *  @return 模块是否存在
 */
+ (BOOL)verifyModule:(NSString *)moduleName stuffixName:(NSString *)stuffixName;
@end
