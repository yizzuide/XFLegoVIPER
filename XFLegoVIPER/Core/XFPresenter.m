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
- (void)initRenderView{}
- (void)viewDidUnLoad{}

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
}

- (void)xfLego_viewWillDisappear
{
    [self invokeMethod:@"xfLego_removeRouting" param:nil forObject:self.routing];
    [self viewDidUnLoad];
}

@end
