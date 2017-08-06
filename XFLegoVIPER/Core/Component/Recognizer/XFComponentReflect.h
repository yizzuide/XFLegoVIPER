//
//  XFComponentReflect.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/20.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IS_Module(component) [component respondsToSelector:@selector(routing)]

@protocol XFComponentRoutable,XFComponentHandlerPlug;
NS_ASSUME_NONNULL_BEGIN
@interface XFComponentReflect : NSObject

/**
 *  根据组件返回组件处理器
 *
 *  @param component 组件名或组件对象
 *
 *  @return 组件处理器类
 */
+ (Class<XFComponentHandlerPlug>)componentHandlerForComponent:(id)component;
/**
 *  根据组件名，验证一个组件是否存在
 *
 *  @param componentName 组件名
 *
 */
+ (BOOL)existComponent:(NSString *)componentName;
/**
 *  返回组件名
 *
 *  @param component 组件
 *
 *  @return 组件名
 */
+ (NSString *)componentNameForComponent:(id<XFComponentRoutable>)component;

/**
 *  当前组件界面
 *
 *  @param component 组件
 *
 *  @return 视图
 */
+ (UIViewController *)uInterfaceForComponent:(__kindof id<XFComponentRoutable>)component;

/**
 *  从视图返回组件
 *
 *  @param uInterface 视图
 *
 *  @return 组件
 */
+ (id<XFComponentRoutable>)componentForUInterface:(UIViewController *)uInterface;
@end
NS_ASSUME_NONNULL_END
