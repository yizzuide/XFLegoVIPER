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
 *  是否控制器组件
 *
 *  @param componentName 组件名
 *
 */
+ (BOOL)isViewControllerComponent:(NSString *)componentName;
/**
 *  根据组件名创建一个控制器
 *
 *  @param componentName 组件名
 *
 */
+ (UIViewController *)controllerFromComponentName:(NSString *)componentName;
@end
