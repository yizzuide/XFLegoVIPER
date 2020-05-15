//
//  CBUITool.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 15/9/18.
//  Copyright © 2015年 Yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFUITool : NSObject
/**
 *  显示消息通知
 *
 *  @param title         内容
 *  @param completeBlock 完成回调
 */
+ (void)showToastWithTitle:(NSString *)title complete:(void (^)())completeBlock;

/**
 *  显示菊花
 */
+ (void)showWaitNotice;
/**
 *  从某个视图显示菊花
 *
 *  @param view 显示视图
 */
+ (void)showWaitNoticeFormView:(UIView *)view;
/**
 *  隐藏菊花
 */
+ (void)hideWaitNotice;
/**
 *  从某个视图移除菊花
 *
 *  @param view 显示视图
 */
+ (void)hideWaitNoticeFormView:(UIView *)view;
@end
