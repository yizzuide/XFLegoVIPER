//
//  UIViewController+XFLego.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 16/2/24.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "UIViewController+XFLego.h"
#import <objc/runtime.h>
#import "NSObject+XFLegoInvokeMethod.h"
#import "XFUInterfaceFactory.h"
#import "NSObject+XFLegoSwizzle.h"

@implementation UIViewController (XFLego)

- (void)setEventHandler:(id<XFEventHandlerPort>)eventHandler
{
    objc_setAssociatedObject(self, @selector(eventHandler), eventHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<XFEventHandlerPort>)eventHandler
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
