//
//  XFViewRender.m
//  VIPERGem
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFViewRender.h"
#import "XFEventHandlerProt.h"
#import <objc/runtime.h>
#import "XFLegoMarco.h"
#import "XFPresenter.h"

@implementation XFViewRender

- (instancetype)init
{
    self = [super init];
    if (self) {
        [LEGORealProt(XFPresenter *, self.eventHandler) viewDidLoad];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [LEGORealProt(XFPresenter *, self.eventHandler) viewDidLoad];
    }
    return self;
}

- (void)dealloc
{
    if (self.eventHandler) {
        [LEGORealProt(XFPresenter *, self.eventHandler) viewDidUnLoad];
    }
}
@end



@implementation UIView (XFLego)

static void * xfViewRender_eventHandler_porpertyKey = (void *)@"xfViewRender_eventHandler_porpertyKey";

- (void)setEventHandler:(id<XFEventHandlerProt>)eventHandler
{
    objc_setAssociatedObject(self, &xfViewRender_eventHandler_porpertyKey, eventHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id<XFEventHandlerProt>)eventHandler
{
    return objc_getAssociatedObject(self, &xfViewRender_eventHandler_porpertyKey);
}

- (void)awakeFromNib
{
    if (self.eventHandler) {
        [LEGORealProt(XFPresenter *, self.eventHandler) viewDidLoad];
    }
}


@end