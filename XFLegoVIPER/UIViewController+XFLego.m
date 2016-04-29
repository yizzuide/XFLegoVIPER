//
//  UIViewController+XFLego.m
//  CreativeButton
//
//  Created by yizzuide on 16/2/24.
//  Copyright © 2016年 RightBrain-Tech. All rights reserved.
//

#import "UIViewController+XFLego.h"
#import <objc/runtime.h>
#import "XFEventHandlerProt.h"
#import "XFLegoMarco.h"
#import "XFPresenter.h"

@implementation UIViewController (XFLego)

static void * xfActivity_eventHandler_porpertyKey = (void *)@"xfActivity_eventHandler_porpertyKey";

- (void)setEventHandler:(id<XFEventHandlerProt>)eventHandler
{
    objc_setAssociatedObject(self, &xfActivity_eventHandler_porpertyKey, eventHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id<XFEventHandlerProt>)eventHandler
{
    return objc_getAssociatedObject(self, &xfActivity_eventHandler_porpertyKey);
}

- (void)viewDidLoad
{
    [LEGORealProt(XFPresenter *, self.eventHandler) bindView:self];
    [LEGORealProt(XFPresenter *, self.eventHandler) viewDidLoad];
}

@end