//
//  XFControllerFactory.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFControllerFactory : NSObject

/**
 *  根据组件名创建一个控制器
 *
 *  @param componentName 组件名
 *
 */
+ (UIViewController *)createControllerFromComponentName:(NSString *)componentName;

/**
 *  根据前辍名创建一个导航控制器
 *
 *  @param prefixName           前缀名
 *  @param rootViewController   根控制器
 *
 *  @return 导航控制器
 */
+ (UINavigationController *)createNavigationControllerFromPrefixName:(NSString *)prefixName withRootController:(UIViewController *)rootViewController;

/**
 *  通过类名创建导航控制器
 *
 *  @param className          类名
 *  @param rootViewController 根控制器
 *
 *  @return 导航控制器
 */
+ (UINavigationController *)createNavigationControllerFromClassName:(NSString *)className withRootController:(UIViewController *)rootViewController;
@end
