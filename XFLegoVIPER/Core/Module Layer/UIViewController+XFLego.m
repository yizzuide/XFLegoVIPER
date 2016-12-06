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
#import "UIView+XFLego.h"

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
    // 初始化事件处理
    [self _xfLego_initEventHandlerWithAdditionWorkBlock:nil];
    // 由于[[UITabBarController alloc] init]执行会立即调用当前viewDidLoad方法，所以这里要单独处理
    if ([self isKindOfClass:[UITabBarController class]]) {
        XF_Define_Weak
        LEGORunAfter0_015({
            XF_Define_Strong
            // 重新绑定关系层
            [self _xfLego_initEventHandlerWithAdditionWorkBlock:^{
                // 调用自定义加载完成方法
                [self xfLego_viewDidLoadForTabBarViewController];
                // 重置父子模块关系
                [XFInterfaceFactory resetSubRoutingFromSubUserInterfaces:self.childViewControllers forParentActivity:self];
            }];
        })
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.eventHandler) {
        [self.eventHandler invokeMethod:@"viewWillAppear"];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.eventHandler) {
        [self.eventHandler invokeMethod:@"viewDidAppear"];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.eventHandler) {
        [self.eventHandler invokeMethod:@"viewWillDisappear"];
        // 如果当前视图被pop或dismiss
        if (self.isMovingFromParentViewController || self.isBeingDismissed) {
            // 调用视图层，视图将被移除方法
            [self _xfLego_viewWillPopOrDismiss];
            // 如果不是通过框架方法
            if (!self.isPoppingProgrammatically) {
                // 通知事件层当前视图将移除
                [self.eventHandler invokeMethod:@"xfLego_viewWillPopOrDismiss"];
                
            }
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    if (self.eventHandler) {
        [self.eventHandler invokeMethod:@"viewDidDisappear"];
    }
}
#pragma clang diagnostic pop

- (void)_xfLego_initEventHandlerWithAdditionWorkBlock:(void(^)())additionWorkBlock
{
    // 如果当前控制器是在当前框架
    if (self.eventHandler) {
        [self setPoppingProgrammatically:[NSNumber numberWithBool:NO]];
        // 绑定当前视图引用到事件处理
        [self.eventHandler invokeMethod:@"xfLego_bindView:" param:self];
        if (additionWorkBlock) {
            additionWorkBlock();
        }
    }
}

- (void)xfLego_viewDidLoadForTabBarViewController
{
}

// 通知所有子视图当前Activity将被移除
- (void)_xfLego_viewWillPopOrDismiss
{
    for (UIView *view in self.view.subviews) {
        [view xfLego_viewWillPopOrDismiss];
    }
    [self xfLego_viewWillPopOrDismiss];
}

- (void)xfLego_viewWillPopOrDismiss
{
}

- (__kindof id<XFUserInterfacePort>)xfLego_subUInterfaceFromModuleName:(NSString *)moduleName
{
    return [XFInterfaceFactory createSubUInterfaceFromModuleName:moduleName parentUInterface:self];
}
@end
