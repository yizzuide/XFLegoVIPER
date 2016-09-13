//
//  XFEventHandlerPort.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFEventHandlerPort_h
#define XFEventHandlerPort_h

@protocol XFEventHandlerPort <NSObject>

/**
 * 视图填充数据
 *
 */
@property (nonatomic, strong) id expressData;

/**
 *  错误消息
 */
@property (nonatomic, copy) NSString *errorMessage;

/**
 *  返回按钮被点击的处理方法（子类可以覆盖这个方法实现自己的逻辑）
 */
- (void)xfLego_onBackItemTouch;
@end


#endif /* XFEventHandlerPort_h */
