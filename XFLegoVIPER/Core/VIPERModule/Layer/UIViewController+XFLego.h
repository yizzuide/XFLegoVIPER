//
//  UIViewController+XFLego.h
//  XFLegoVIPER
//
//  Created by yizzuide on 16/2/24.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFUserInterfacePort.h"
#import "XFEventHandlerPort.h"
#import "XFLegoMarco.h"
#import "XFUInterfaceFactory.h"
#import "XFExpressPack.h"
#import "UIViewController+ComponentUI.h"

// 转换事件层真实接口
#define XFConvertPresenterToType(type) LEGORealPort(type, self.eventHandler)

// 渲染数据包
#define ExpressPack self.eventHandler.expressPack

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
 *  这个分类会自行绑定事件处理器Presenter,绑定成功会调用它的`viewDidLoad`方法。
 */
@interface UIViewController (XFLego) <XFUserInterfacePort>

/**
 *  事件处理层
 */
@property (nonatomic, strong, readonly) __kindof id<XFEventHandlerPort> eventHandler;

@end
