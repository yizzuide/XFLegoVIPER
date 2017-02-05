//
//  LEViewModel.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/29.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "LEViewModel.h"

@implementation LEViewModel

// 导出为可运行组件
XF_EXPORT_COMPONENT

// 视图加载完成
- (void)viewDidLoad
{
}


#pragma mark - 私有方法
- (void)le_viewDidLoad
{
    [self.uiBus xfLego_destoryUInterfaceRef];
    [self viewDidLoad];
}

- (void)le_viewWillDisappear
{
    // 将组件移除
    [self.uiBus xfLego_implicitRemoveComponentWithTransitionBlock:^(Activity *thisInterface, Activity *nextInterface, TransitionCompletionBlock completionBlock) {
        completionBlock();
    }];
}

@end
