//
//  XFDetailsRouting.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/9/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFDetailsRouting.h"
#import "XFDetailsPresenter.h"

@implementation XFDetailsRouting

/* xib方式加载*/
//XF_InjectModuleWith_IB(@"x-XFDetailsActivity", [XFDetailsPresenter class], nil, nil)

/* storyboard方式*/
XF_AutoAssemblyModuleFromIB(@"s-XFDetails-XFDetailsID")

@end
