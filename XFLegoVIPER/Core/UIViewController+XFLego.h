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
#import "XFInterfaceFactory.h"

// 转换事件层真实接口
#define XFConvertPresenterToType(type) LEGORealPort(type, self.eventHandler)

// 在VIPER架构中快速获取一个子模块的视图
#define XF_SubUInterface_(moudleName) [self xfLego_subUInterfaceFromMoudleName:moudleName]

// 基于ReactiveCocoa的双向数据绑定
#define XF_$_(UIControl, VProp, EventHandler, VDProp) \
RAC(EventHandler, VDProp) = [RACObserve(UIControl, VProp) distinctUntilChanged]; \
[RACObserve(EventHandler, VDProp) subscribe:RACChannelTo(UIControl, VProp)]; \

// 基于ReactiveCocoa的命令绑定
#define XF_C_(UIButton,EventHandler,Command) UIButton.rac_command = [EventHandler Command];

// 设置UIView的Frame
#define XF_SetFrame_(view,executeCode) \
CGRect frame = view.frame; \
executeCode \
view.frame = frame;

/**
 *  这个分类会自行绑定事件处理者Presenter,绑定成功会调用它的`viewDidLoad`方法。
 */
@interface UIViewController (XFLego) <XFUserInterfacePort>

/**
 *  事件处理层
 */
@property (nonatomic, strong, readonly) id<XFEventHandlerPort> eventHandler;

/**
 *  从指定模块加载子视图
 *  @param moudleName 模块名
 *
 *  @return 子视图
 */
- (__kindof id<XFUserInterfacePort>)xfLego_subUInterfaceFromMoudleName:(NSString *)moudleName;
@end
