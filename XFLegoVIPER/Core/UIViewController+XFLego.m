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
#import "XFInterfaceFactory.h"

@implementation UIViewController (XFLego)

static void * xfActivity_eventHandler_porpertyKey = (void *)@"xfActivity_eventHandler_porpertyKey";
static void * xfActivity_poppingProgrammatically_porpertyKey = (void *)@"xfActivity_poppingProgrammatically_porpertyKey";

- (void)setEventHandler:(id<XFEventHandlerPort>)eventHandler
{
    objc_setAssociatedObject(self, &xfActivity_eventHandler_porpertyKey, eventHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id<XFEventHandlerPort>)eventHandler
{
    return objc_getAssociatedObject(self, &xfActivity_eventHandler_porpertyKey);
}

- (void)setPoppingProgrammatically:(NSNumber *)popingBool
{
     objc_setAssociatedObject(self, &xfActivity_poppingProgrammatically_porpertyKey, popingBool, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isPoppingProgrammatically
{
    NSNumber *popingNumber = objc_getAssociatedObject(self, &xfActivity_poppingProgrammatically_porpertyKey);
    return [popingNumber boolValue];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)viewDidLoad
{
    // 如果当前控制器是在当前框架
    if (self.eventHandler) {
        [self setPoppingProgrammatically:[NSNumber numberWithBool:NO]];
        // 绑定当前视图引用到事件处理
        [self invokeMethod:@"xfLego_bindView:" param:self forObject:self.eventHandler];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.eventHandler) {
        [self invokeMethod:@"xfLego_viewWillAppear" param:nil forObject:self.eventHandler];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.eventHandler) {
        [self invokeMethod:@"viewDidAppear" param:nil forObject:self.eventHandler];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.eventHandler) {
        [self invokeMethod:@"viewWillDisappear" param:nil forObject:self.eventHandler];
        // 如果当前视图被pop或dismiss
        if ((self.isMovingFromParentViewController || self.isBeingDismissed)
            && !self.isPoppingProgrammatically) {
            // 通知事件层当前视图将消失
            [self invokeMethod:@"xfLego_viewWillDisappear" param:nil forObject:self.eventHandler];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    if (self.eventHandler) {
        [self invokeMethod:@"viewDidDisappear" param:nil forObject:self.eventHandler];
    }
}
#pragma clang diagnostic pop


- (__kindof id<XFUserInterfacePort>)xfLego_subUInterfaceFromMoudleName:(NSString *)moudleName
{
    return [XFInterfaceFactory createSubUInterfaceFromMoudleName:moudleName parentUInterface:self];
}
@end