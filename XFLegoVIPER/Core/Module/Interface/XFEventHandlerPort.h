//
//  XFEventHandlerPort.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFEventHandlerPort_h
#define XFEventHandlerPort_h

@class XFExpressPack;
@protocol XFEventHandlerPort <NSObject>

/**
 *  快速填充简单数据
 */
@property (nonatomic, strong) id expressData;
/**
 *  填充列表复杂数据（RenderData渲染数据的包装类）
 *
 */
@property (nonatomic, strong) __kindof XFExpressPack *expressPack;

/**
 *  错误消息
 */
@property (nonatomic, copy) NSString *errorMessage;

/**
 *  返回按钮被点击的处理方法（子类可以覆盖这个方法实现自己的逻辑）
 */
- (void)xfLego_onBackItemTouch;
/**
 *  取消按钮被点击的处理方法（子类可以覆盖这个方法实现自己的逻辑）
 */
- (void)xfLego_onDismissItemTouch;
@end


#endif /* XFEventHandlerPort_h */
