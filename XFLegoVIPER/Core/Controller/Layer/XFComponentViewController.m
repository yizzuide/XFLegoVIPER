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

// 实现事件层的退出键盘事件
- (void)dismissKeyboard
{
    // 调用视图层的方法
    [self needDismissKeyboard];
}

@end
