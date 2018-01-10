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

#pragma mark - 生命周期
- (void)viewDidLoad{}
- (void)initCommand{}
- (void)initRenderView{}
- (void)viewWillAppear{}
- (void)viewDidAppear{}
- (void)viewWillDisappear{}
- (void)viewDidDisappear{}
- (void)viewWillPopOrDismiss{}

- (void)componentWillBecomeFocus{}
- (void)componentWillResignFocus{}

#pragma mark - 组件通信
// 注册通知
- (void)registerMVxNotifactions{}
// 接收组件事件数据
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData{}
// 接收组件回传意图数据
- (void)onNewIntent:(id)intentData{}

#pragma mark - UI事件
- (void)popViewAction
{
    [self.uiBus popComponent];
}

- (void)dismissViewAction
{
    [self.uiBus dismissComponent];
}

#pragma mark - 私有方法
- (void)xfLego_bindView:(id)view
{
    [self setValue:view forKey:@"view"];
    [self.uiBus xfLego_destoryUInterfaceRef];
    [self viewDidLoad];
    [self initCommand];
    [self registerMVxNotifactions];
    [self initRenderView];
}

- (void)xf_viewWillPopOrDismiss
{
    // 将组件移除
    [self.uiBus xfLego_implicitRemoveComponentWithTransitionBlock:^(Activity *thisInterface, Activity *nextInterface, TransitionCompletionBlock completionBlock) {
        completionBlock();
    }];
}

@end
