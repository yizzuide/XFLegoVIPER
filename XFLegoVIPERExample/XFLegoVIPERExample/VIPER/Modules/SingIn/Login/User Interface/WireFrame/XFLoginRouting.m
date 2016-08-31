//
//  XFLoginRouting.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFLoginRouting.h"
#import "XFLoginActivity.h"
#import "XFLoginPresenter.h"
#import "XFLoginInteractor.h"

@implementation XFLoginRouting

+ (instancetype)routing
{
    return [[super routing] buildModulesAssemblyWithActivityClass:[XFLoginActivity class] presenterClass:[XFLoginPresenter class] interactorClass:[XFLoginInteractor class] dataManagerClass:nil];
}

- (void)loginToDissmiss
{
    [self dismiss];
}
@end
