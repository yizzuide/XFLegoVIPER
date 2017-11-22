//
//  UIViewController+ComponentUI.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/2/10.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ComponentUI)

/**
 *  针对TabBarViewController的框架视图加载完成方法的勾子方法
 */
- (void)xfLego_viewDidLoadForTabBarViewController;
/**
 *  当前视图将被Pop或Dismiss的勾子方法
 */
- (void)xfLego_viewWillPopOrDismiss;
/**
 * 是否在视图被完全移除时，使用框架自动移除当前组件机制的勾子方法，默认为YES
 */
- (BOOL)xfLego_enableAutoRemoveSelfComp;
@end
