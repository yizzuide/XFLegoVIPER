//
//  UIView+XFLego.m
//  XFLegoVIPER
//
//  Created by 付星 on 16/8/26.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "UIView+XFLego.h"
#import <objc/runtime.h>

@implementation UIView (XFLego)

static void * xfViewRender_eventHandler_porpertyKey = (void *)@"xfViewRender_eventHandler_porpertyKey";

- (void)setEventHandler:(id<XFEventHandlerPort>)eventHandler
{
    objc_setAssociatedObject(self, &xfViewRender_eventHandler_porpertyKey, eventHandler, OBJC_ASSOCIATION_ASSIGN);
}
- (id<XFEventHandlerPort>)eventHandler
{
    // 绑定事件层
    [self xfLogo_bindEventHandler];
    return objc_getAssociatedObject(self, &xfViewRender_eventHandler_porpertyKey);
}

- (void)xfLogo_bindEventHandler {
    if (objc_getAssociatedObject(self, &xfViewRender_eventHandler_porpertyKey)) return;
    UIViewController *activity = [self xfLogo_getCurrentViewController];
    self.eventHandler = [activity performSelector:@selector(eventHandler)];
}

- (id)xfLogo_getCurrentViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder xfLogo_getCurrentViewController];
    } else {
        return nil;
    }
}

- (void)xfLego_viewWillPopOrDismiss {
	
}


@end
