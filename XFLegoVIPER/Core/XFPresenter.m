//
//  XFPresenter.m
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFPresenter.h"

@implementation XFPresenter

// 绑定一个视图
- (void)bindView:(id)view
{
    self.userInterface = view;
}

- (void)viewDidLoad{}
- (void)viewDidUnLoad{}

- (void)viewWillBecomeFocusWithIntentData:(id)intentData{}
- (void)viewWillResignFocus{}

- (void)receiveOtherMoudleEventName:(NSString *)eventName intentData:(id)intentData{}

- (void)xfLego_onBackItemTouch
{
    [self.routing pop];
}

@end
