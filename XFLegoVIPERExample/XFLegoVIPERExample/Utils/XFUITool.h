//
//  CBUITool.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface XFUITool : NSObject
SingletonH(UI)
/**
 *  显示消息通知
 *
 *  @param title         内容
 *  @param completeBlock 完成回调
 */
- (void)showToastWithTitle:(NSString *)title complete:(void (^)())completeBlock;
/**
 *  显示一个有成功状态的消息
 *
 *  @param title         标题
 *  @param success       是否成功
 *  @param completeBlock 完成回调
 */
- (void)showMessageWithTile:(NSString *)title stauts:(BOOL)success complete:(void (^)())completeBlock;
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
