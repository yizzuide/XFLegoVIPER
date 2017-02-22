//
//  UIViewController+LEView.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/29.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "UIViewController+LEView.h"
#import <objc/runtime.h>


@implementation UIViewController (LEView)

- (void)setDataDriver:(__kindof id<LEDataDriverProtocol>)dataDriver
{
    objc_setAssociatedObject(self, @selector(dataDriver), dataDriver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (__kindof id<LEDataDriverProtocol>)dataDriver
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
