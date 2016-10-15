//
//  XFDetailsRouting.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/9/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFDetailsRouting.h"
#import "XFDetailsPresenter.h"

@implementation XFDetailsRouting

/* xib方式加载*/
//XF_InjectMoudleWith_IB(@"x-XFDetailsActivity", [XFDetailsPresenter class], nil, nil)

/* storyboard方式*/
XF_InjectMoudleWith_IB(@"s-XFDetails-XFDetailsID", [XFDetailsPresenter class], nil, nil)


@end
