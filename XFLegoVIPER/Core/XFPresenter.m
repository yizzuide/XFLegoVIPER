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

- (void)viewDidLoad{}
- (void)initCommand{}
- (void)registerMVxNotifactions{}
- (void)initRenderView{}
- (void)viewWillAppear{}
- (void)viewDidAppear{}
- (void)viewWillDisappear{}
- (void)viewDidDisappear{}

- (void)viewWillBecomeFocusWithIntentData:(id)intentData{}
- (void)viewWillResignFocus{}

- (void)receiveOtherMoudleEventName:(NSString *)eventName intentData:(id)intentData{}

- (void)xfLego_onBackItemTouch
{
    [self.routing pop];
}

#pragma mark - 私有方法
// 绑定一个视图
- (void)xfLego_bindView:(id)view
{
    [self setValue:view forKey:@"userInterface"];
    [self viewDidLoad];
    [self initCommand];
    [self registerMVxNotifactions];
    [self initRenderView];
}

- (void)xfLego_viewWillAppear
{
    [self viewWillAppear];
}

- (void)xfLego_viewWillDisappear
{
    [self invokeMethod:@"xfLego_removeRouting" param:nil forObject:self.routing];
}

@end
