//
//  XFComponentReflect.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/20.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IS_Module(component) [component respondsToSelector:@selector(routing)]

@protocol XFComponentRoutable;
@interface XFComponentReflect : NSObject

/**
 *  返回组件名
 *
 *  @param component 组件
 *
 *  @return 组件名
 */
+ (NSString *)componentNameForComponent:(id<XFComponentRoutable>)component;
/**
 *  是否是一个组件
 *
 *  @param name 组件名
 *
 */
+ (BOOL)isComponentForName:(NSString *)name;
/**
 *  是否是模块组件
 *
 *  @param component 组件对象或组件名
 *
 */
+ (BOOL)isModuleComponent:(id)component;
/**
 *  是否是控制器组件
 *
 *  @param component 组件对象或组件名
 *
 */
+ (BOOL)isControllerComponent:(id)component;
/**
 *  当前组件界面
 *
 *  @param component 组件
 *
 *  @return 视图
 */
+ (UIViewController *)interfaceForComponent:(__kindof id<XFComponentRoutable>)component;

/**
 *  从视图返回组件名
 *
 *  @param interface 视图
 *
 *  @return 组件名
 */
+ (NSString *)componentNameForInterface:(UIViewController *)interface;
/**
 *  从视图返回组件
 *
 *  @param interface 视图
 *
 *  @return 组件
 */
+ (id<XFComponentRoutable>)componentForInterface:(UIViewController *)interface;
@end
