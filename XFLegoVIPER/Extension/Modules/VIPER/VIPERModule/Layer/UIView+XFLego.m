//
//  UIView+XFLego.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 16/8/26.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "UIView+XFLego.h"

@implementation UIView (XFLego)

- (id<XFEventHandlerPort>)eventHandler
{
    return self.dispatcher;
}

@end
