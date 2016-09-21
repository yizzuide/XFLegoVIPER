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

+ (instancetype)routing
{
    // xib方式加载
    //return [[super routing] buildModulesAssemblyWithIB:@"x-XFDetailsActivity" presenterClass:[XFDetailsPresenter class] interactorClass:nil dataManagerClass:nil];
    
    // storyboard方式
    return [[super routing] buildModulesAssemblyWithIB:@"s-XFDetails-XFDetailsID" presenterClass:[XFDetailsPresenter class] interactorClass:nil dataManagerClass:nil];
}
@end
