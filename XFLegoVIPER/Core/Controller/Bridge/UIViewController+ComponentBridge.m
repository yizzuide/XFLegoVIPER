//
//  UIViewController+ComponentBridge.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/19.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "UIViewController+ComponentBridge.h"
#import <objc/runtime.h>
#import "NSObject+XFLegoInvokeMethod.h"
#import "NSObject+XFLegoSwizzle.h"

@implementation UIViewController (ComponentBridge)

- (void)setUiBus:(__kindof XFUIBus *)uiBus
{
    objc_setAssociatedObject(self, @selector(uiBus), uiBus, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XFUIBus *)uiBus
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEventBus:(__kindof XFEventBus *)eventBus
{
    objc_setAssociatedObject(self, @selector(eventBus), eventBus, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XFEventBus *)eventBus
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFromComponentRoutable:(id<XFComponentRoutable>)fromComponentRoutable
{
    objc_setAssociatedObject(self, @selector(fromComponentRoutable), fromComponentRoutable, OBJC_ASSOCIATION_ASSIGN);
}

- (id<XFComponentRoutable>)fromComponentRoutable
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNextComponentRoutable:(id<XFComponentRoutable>)nextComponentRoutable
{
    objc_setAssociatedObject(self, @selector(nextComponentRoutable), nextComponentRoutable, OBJC_ASSOCIATION_ASSIGN);
}

- (id<XFComponentRoutable>)nextComponentRoutable
{
    return objc_getAssociatedObject(self, _cmd);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self xfLego_swizzleMethod:@selector(viewWillDisappear:) withMethod:@selector(componentBridge_viewWillDisappear:)];
    });
}

- (void)componentBridge_viewWillDisappear:(BOOL)animated
{
    [self componentBridge_viewWillDisappear:animated];
    if (self.uiBus) {
        // 如果当前视图被pop或dismiss
        if (self.isMovingFromParentViewController || self.isBeingDismissed) {
            // 如果不是通过框架方法
            if (![[self valueForKeyPath:@"poppingProgrammatically"] boolValue]) {
                // 将组件移除
                [self.uiBus invokeMethod:@"xfLego_startRemoveComponentWithTransitionBlock:" param:^(Activity *thisInterface, Activity *nextInterface, TransitionCompletionBlock completionBlock) {
                    completionBlock();
                }];
            }
        }
    }
}

@end
