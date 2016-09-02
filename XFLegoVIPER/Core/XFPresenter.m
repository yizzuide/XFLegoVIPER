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


- (void)render
{
    __weak typeof(self) weakSelf = self;
    [self.interactor fetchRenderDataWithBlock:^(id obj) {
        weakSelf.expressData = [weakSelf filterWithData:obj];
        // 如果有接受者采用直接推送
        if ([weakSelf.userInterface respondsToSelector:@selector(fillData:)]) {
            [weakSelf.userInterface fillData:weakSelf.expressData];
        }
    }];
    
}

- (id)filterWithData:(id)data
{
    return data;
}

- (void)requirePopModule
{
    [self.routing pop];
}
@end
