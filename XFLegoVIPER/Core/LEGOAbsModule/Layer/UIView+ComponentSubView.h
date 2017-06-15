//
//  UIView+ComponentSubView.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/2/10.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFLegoMarco.h"

// 设置UIView的Frame
#define XF_SetFrame_(view,ExecuteCode) \
CGRect frame = view.frame; \
ExecuteCode \
view.frame = frame;

@interface UIView (ComponentSubView)

/**
 *  Action派发器，可以是模块事件处理或数据驱动层
 */
@property (nonatomic, weak) __kindof id dispatcher;

/**
 *  主视图将被Pop或Dismiss
 */
- (void)xfLego_viewWillPopOrDismiss;

@end
