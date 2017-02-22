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
 *  针对TabBarViewController的框架视图加载完成方法
 */
- (void)xfLego_viewDidLoadForTabBarViewController;
/**
 *  当前视图将被Pop或Dismiss
 */
- (void)xfLego_viewWillPopOrDismiss;
@end
