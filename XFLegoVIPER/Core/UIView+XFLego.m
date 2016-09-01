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

- (void)awakeFromNib
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.151 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self xfLogo_bindEventHandler];
    });
}

- (void)xfLogo_bindEventHandler {
    UIViewController *activity = [self xfLogo_getCurrentViewController];
    
    id<XFEventHandlerPort> presenter = [activity performSelector:@selector(eventHandler)];
    if(presenter){
        self.eventHandler = presenter;
    }
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