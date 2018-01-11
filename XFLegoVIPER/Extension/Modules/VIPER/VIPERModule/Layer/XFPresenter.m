//
//  XFPresenter.m
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFPresenter.h"
#import "NSObject+XFLegoInvokeMethod.h"

@implementation XFPresenter

// 导出为组件
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
    [self.routing popComponent];
}
- (void)dismissViewAction
{
    [self.routing dismissComponent];
}

#pragma mark - 私有方法
// 绑定一个视图
- (void)xfLego_bindView:(id)view
{
    [self setValue:view forKey:@"userInterface"];
    [self.routing invokeMethod:@"xfLego_destoryUInterfaceRef"];
    [self viewDidLoad];
    [self initCommand];
    [self registerMVxNotifactions];
    [self initRenderView];
}

- (void)xf_viewWillPopOrDismiss
{
    // 路由移除
    [self.routing invokeMethod:@"xfLego_removeRouting"];
    // 定时器移除
    [self.eventBus stopTimer];
}

@end
