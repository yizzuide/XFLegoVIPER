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


/**
 *  这个分类会自行绑定事件处理器Presenter,绑定成功会调用它的`viewDidLoad`方法。
 */
@interface UIViewController (XFLego) <XFUserInterfacePort>

/**
 *  事件处理层
 */
@property (nonatomic, strong, readonly) __kindof id<XFEventHandlerPort> eventHandler;

@end
