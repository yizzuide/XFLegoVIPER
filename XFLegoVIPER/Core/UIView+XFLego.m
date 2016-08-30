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
    [self xfLogo_bindEventHandler];
}

- (void)xfLogo_bindEventHandler {
    UIViewController *activity = [self xfLogo_getCurrentViewController];
    
    id<XFEventHandlerPort> presenter = [activity performSelector:@selector(eventHandler)];
    if(presenter){
        self.eventHandler = presenter;
    }
}

-(UIViewController *)xfLogo_getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}


@end