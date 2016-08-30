//
//  XFMainRouting.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFMainRouting.h"
#import "XFMainActivity.h"
#import "XFMainPersenter.h"
#import "XFLoginRouting.h"

@implementation XFMainRouting

+ (instancetype)routing
{
    return [[super routing] buildModulesAssemblyWithActivityClass:[XFMainActivity class] presenterClass:[XFMainPersenter class] interactorClass:nil dataManagerClass:nil];
}

- (void)transitionToLoginMoudle
{
    XFLoginRouting *loginRouting = [XFLoginRouting routing];
    
    // 开始Model显示
    [self presentRouting:loginRouting intent:nil];
}

@end
