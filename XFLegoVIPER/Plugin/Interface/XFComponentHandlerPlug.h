//
//  XFComponentHandlerPlug.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/23.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#ifndef XFComponentHandlerPlug_h
#define XFComponentHandlerPlug_h

#import <UIKit/UIKit.h>
#import "XFComponentRoutable.h"

/**
 *  组件处理器插件接口
 */
@protocol XFComponentHandlerPlug <NSObject>

/**
 *  插件是否能处理这个组件对象
 *
 *  @param component 组件名或组件对象
 *
 */
+ (BOOL)matchComponent:(id)component;
/**
 *   插件是否能处理这个界面层
 *
 *  @param uInterface 界面层
 *
 */
+ (BOOL)matchUInterface:(UIViewController *)uInterface;
/**
 *  根据组件名创建一个组件
 *
 *  @param componentName 组件名
 *
 *  @return 组件
 */
+ (id<XFComponentRoutable>)createComponentFromName:(NSString *)componentName;

/**
 *  根据组件对象返回组件名
 *
 *  @param component 组件对象
 *
 *  @return 组件名
 */
+ (NSString *)componentNameFromComponent:(id<XFComponentRoutable>)component;

/**
 *  根据组件可运行对象返回界面层
 *
 *  @param component 组件可运行对象
 *
 */
+ (UIViewController *)uInterfaceForComponent:(id<XFComponentRoutable>)component;
/**
 *  根据界面层返回组件对象
 *
 *  @param uInterface 界面层
 *
 */
+ (id<XFComponentRoutable>)componentForUInterface:(UIViewController *)uInterface;

/**
 *  从起始组件根据组件名返回下一个可运行组件对象
 *
 *  @param component        起始组件
 *  @param componentName    组件名
 *
 *  @return 组件可运行对象
 */
+ (id<XFComponentRoutable>)component:(__kindof id<XFComponentRoutable>)component createNextComponentFromName:(NSString *)componentName;

/**
 *  UI总线在执行移除组件动画前调用
 *
 *  @param component 组件
 */
+ (void)willRemoveComponent:(__kindof id<XFComponentRoutable>)component;
/**
 *  UI总线在执行释放组件前调用
 *
 *  @param component 组件
 */
+ (void)willReleaseComponent:(__kindof id<XFComponentRoutable>)component;
@end


#endif /* XFComponentHandlerPlug_h */
