//
//  XFInterfaceFactory.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/5.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

/* ------------- 在MVx架构中创建VIPER架构视图以供导航Push或Present展示 ------------------ */
#define XF_UInterfaceForMVx_Show(moduleName) \
[XFInterfaceFactory createUInterfaceForMVxFromModuleName:moduleName asChildViewController:NO]

/* ------ 在MVx架构中创建VIPER架构视图用于UIPageViewController和第三方库对子控制器的添加 ------- */
#define XF_SubUInterfaceForMVx_AddChild(moduleName) \
[XFInterfaceFactory createUInterfaceForMVxFromModuleName:moduleName asChildViewController:YES]

@protocol XFUserInterfacePort;
@interface XFInterfaceFactory : NSObject

/**
 *  在VIPER架构中跟据模块名创建一个基于VIPER框架可管理模块子界面
 *  注意：
    1.内部对象只会创建一次，再次调用内部会拿缓存
    2.子模块路由类名必须以"Routing"后辍结尾
    3.使用[XFRoutingLinkManager setModulePrefix:]设置前辍
 
 *  @param moduleName       模块名
 *  @param parentUInterface 父视图
 *
 *  @return VIPER视图
 */
+ (__kindof id<XFUserInterfacePort>)createSubUInterfaceFromModuleName:(NSString *)moduleName parentUInterface:(__kindof id<XFUserInterfacePort>)parentUInterface;

/**
 *  在MVx架构中创建VIPER架构视图以供导航Push或Present展示（设置asChild为NO）,也适用于UIPageViewController和第三方库对子控制器的添加（设置asChild为YES）
 *  注意：
    1.内部对象只会创建一次，再次调用内部会拿缓存
    2.子模块路由类名必须以"Routing"后辍结尾
    3.使用[XFRoutingLinkManager setModulePrefix:]设置前辍
 *
 *  @param moduleName   模块名
 *  @param asChild      是否作为子控制器
 *
 *  @return VIPER视图
 */
+ (__kindof id<XFUserInterfacePort>)createUInterfaceForMVxFromModuleName:(NSString *)moduleName asChildViewController:(BOOL)asChild;

/**
 *  重新构建父子视图关系链
 *
 *  @param subUserInterfaces   所有子视图
 *  @param parentUserInterface 父视图
 */
+ (void)resetSubRoutingFromSubUserInterfaces:(NSArray *)subUserInterfaces forParentActivity:(__kindof id<XFUserInterfacePort>)parentUserInterface;
@end
