//
//  XFActivity.m
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFActivity.h"
#import <objc/runtime.h>
#import "NSObject+XFLegoInvokeMethod.h"

@interface XFActivity ()

@end

@implementation XFActivity

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self invokeMethod:@"bindView:" param:self forObject:self.eventHandler];
    [self invokeMethod:@"viewDidLoad" param:nil forObject:self.eventHandler];
}

// 处理pop返回事件
- (void)backButtonPressed
{
    [self.eventHandler requirePopModule];
}

- (void)fillData:(id)data{}

- (void)dealloc
{
    [self invokeMethod:@"viewDidUnLoad" param:nil forObject:self.eventHandler];
}
@end
