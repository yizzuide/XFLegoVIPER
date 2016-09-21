//
//  UIViewController+XFLego.m
//  XFLegoVIPER
//
//  Created by yizzuide on 16/2/24.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "UIViewController+XFLego.h"
#import <objc/runtime.h>
#import "NSObject+XFLegoInvokeMethod.h"

@implementation UIViewController (XFLego)

static void * xfActivity_eventHandler_porpertyKey = (void *)@"xfActivity_eventHandler_porpertyKey";

- (void)setEventHandler:(id<XFEventHandlerPort>)eventHandler
{
    objc_setAssociatedObject(self, &xfActivity_eventHandler_porpertyKey, eventHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id<XFEventHandlerPort>)eventHandler
{
    return objc_getAssociatedObject(self, &xfActivity_eventHandler_porpertyKey);
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)viewDidLoad
{
    // 如果当前控制器是在当前框架
    if (self.eventHandler) {
        // 绑定当前视图引用到事件处理
        [self invokeMethod:@"xfLego_bindView:" param:self forObject:self.eventHandler];
        
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.eventHandler) {
        // 如果当前视图被pop或dismiss
        if (self.isMovingFromParentViewController || self.isBeingDismissed) {
            // 通知事件层当前视图将消失
            [self invokeMethod:@"xfLego_viewWillDisappear" param:nil forObject:self.eventHandler];
        }
    }
    
}
#pragma clang diagnostic pop

@end