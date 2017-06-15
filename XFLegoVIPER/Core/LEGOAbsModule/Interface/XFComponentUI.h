//
//  XFComponentUI.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/2/10.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#ifndef XFComponentUI_h
#define XFComponentUI_h

// 基于ReactiveCocoa的任意数据的双向数据绑定
#define XF_$_(UIControl, VProp, EventHandler, VDProp) \
UIControl.VProp = EventHandler.VDProp; \
RAC(EventHandler, VDProp) = [RACObserve(UIControl, VProp) distinctUntilChanged]; \
[RACObserve(EventHandler, VDProp) subscribe:RACChannelTo(UIControl, VProp)]; \

// 基于ReactiveCocoa的输入控件控件的双向数据绑定
#define XF_$_Input(UIInputControl, VProp, EventHandler, VDProp) \
UIInputControl.VProp = EventHandler.VDProp; \
RAC(EventHandler, VDProp) = [UIInputControl.rac_textSignal distinctUntilChanged]; \
[RACObserve(EventHandler, VDProp) subscribe:RACChannelTo(UIInputControl, VProp)]; \

// 基于ReactiveCocoa的命令绑定
#define XF_C_(UIButton,EventHandler,Command) UIButton.rac_command = [EventHandler Command];

// 设置UIView的Frame
#define XF_SetFrame_(view,ExecuteCode) \
CGRect frame = view.frame; \
ExecuteCode \
view.frame = frame;

/**
 *  这个协议是视图层实现，用来响应事件层的UI改变
 */
@protocol XFComponentUI <NSObject>

@optional

/**
 *  发起请求显示的消息
 *
 *  @param msg 消息
 */
- (void)needSendRequestWithMsg:(NSString *)msg;
/**
 *  结束请求显示的消息
 *
 *  @param msg 消息
 */
- (void)needEndRequestWithMsg:(NSString *)msg;

/**
 *  键盘弹起，需要更新输入界面的的Y值
 *
 *  @param y            键盘移动的Y值
 *  @param durationTime 持续时间
 */
- (void)needUpdateInputUInterfaceY:(CGFloat)y durationTime:(CGFloat)durationTime;
/**
 *  需要退出键盘
 */
- (void)needDismissKeyboard;

@end

#endif /* XFComponentUI_h */
