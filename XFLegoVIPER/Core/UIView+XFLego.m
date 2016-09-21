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
    return objc_getAssociatedObject(self, &xfViewRender_eventHandler_porpertyKey);
}

// 自动绑定事件处理层，只有在视图添加到一个父视图中时有效
- (void)didMoveToSuperview
{
    [self xfLogo_bindEventHandler];
}

- (void)xfLogo_bindEventHandler {
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


@end