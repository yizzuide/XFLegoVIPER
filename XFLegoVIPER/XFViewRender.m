//
//  XFViewRender.m
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFViewRender.h"
#import "XFEventHandlerProt.h"
#import <objc/runtime.h>
#import "XFPresenter.h"

@implementation XFViewRender


- (instancetype)init
{
    self = [super init];
    if (self) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [XFConvertPresenterToType(XFPresenter *) viewDidLoad];
#pragma clang diagnostic pop
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [XFConvertPresenterToType(XFPresenter *) viewDidLoad];
#pragma clang diagnostic pop
    }
    return self;
}

- (void)dealloc
{
    if (self.eventHandler) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [XFConvertPresenterToType(XFPresenter *) viewDidUnLoad];
#pragma clang diagnostic pop
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
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [XFConvertPresenterToType(XFPresenter *) viewDidLoad];
#pragma clang diagnostic pop
    }
}



@end