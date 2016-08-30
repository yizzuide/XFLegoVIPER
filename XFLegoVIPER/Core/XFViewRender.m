//
//  XFViewRender.m
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFViewRender.h"

@implementation XFViewRender

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self xfLogo_bindEventHandler];
    }
    return self;
}

@end