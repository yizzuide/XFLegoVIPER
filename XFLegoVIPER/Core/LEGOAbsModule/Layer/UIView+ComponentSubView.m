//
//  UIView+ComponentSubView.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/2/10.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "UIView+ComponentSubView.h"
#import <objc/runtime.h>
#import "XFComponentReflect.h"

@implementation UIView (ComponentSubView)

- (void)setDispatcher:(id)dispatcher
{
    objc_setAssociatedObject(self, @selector(dispatcher), dispatcher, OBJC_ASSOCIATION_ASSIGN);
}

- (id)dispatcher
{
    // 绑定事件层
    [self xfLogo_findDispatcher];
    return objc_getAssociatedObject(self, _cmd);
}

- (void)xfLogo_findDispatcher {
    if (objc_getAssociatedObject(self, @selector(dispatcher))) return;
    UIViewController *uInterface = [self _xfLogo_getCurrentViewController];
    self.dispatcher = [XFComponentReflect componentForUInterface:uInterface];
}

- (id)_xfLogo_getCurrentViewController {
    id nextResponder = self.nextResponder;
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder _xfLogo_getCurrentViewController];
    } else {
        return nil;
    }
}

- (void)xfLego_viewWillPopOrDismiss {
    
}

@end
