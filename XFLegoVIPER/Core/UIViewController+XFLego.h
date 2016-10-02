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

#define XFConvertPresenterToType(type) LEGORealPort(type, self.eventHandler)

// 基于ReactiveCocoa的双向数据绑定
#define XF_$_(UIControl, VProp, EventHandler, VDProp) \
RAC(EventHandler, VDProp) = [RACObserve(UIControl, VProp) distinctUntilChanged]; \
[RACObserve(EventHandler, VDProp) subscribe:RACChannelTo(UIControl, VProp)]; \

// 基于ReactiveCocoa的命令绑定
#define XF_C_(UIButton,EventHandler,Command) UIButton.rac_command = [EventHandler Command];

/**
 *  这个分类会自行绑定事件处理者Presenter,绑定成功会调用它的`viewDidLoad`方法。
 */
@interface UIViewController (XFLego) <XFUserInterfacePort>

@property (nonatomic, strong, readonly) id<XFEventHandlerPort> eventHandler;
@end
