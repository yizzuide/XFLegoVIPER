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

/**
 *  这个分类会自行绑定事件处理者Presenter,绑定成功会调用它的`viewDidLoad`方法，如果想在控制器dealloc调用Presenter的`viewDidUnLoad`,请使用继承`XFActivity类方式。
 */
@interface UIViewController (XFLego) <XFUserInterfacePort>

@property (nonatomic, strong) id<XFEventHandlerPort> eventHandler;
@end
