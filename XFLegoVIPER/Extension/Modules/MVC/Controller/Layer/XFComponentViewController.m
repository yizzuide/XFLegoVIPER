//
//  XFComponentViewController.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFComponentViewController.h"

@implementation XFComponentViewController

// 把控制器导出为组件
XF_EXPORT_COMPONENT

- (void)popViewAction
{
    [self.uiBus popComponent];
}

- (void)dismissViewAction
{
    [self.uiBus dismissComponent];
}

@end
