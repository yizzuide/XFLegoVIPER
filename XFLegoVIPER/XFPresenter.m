//
//  XFPersenter.m
//  VIPERGem
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFPresenter.h"

@implementation XFPresenter

- (void)bindView:(id)view
{
    self.activity = view;
}

- (id<XFUserInterfaceProt>)currentInterface
{
    return self.activity;
}

- (void)viewDidLoad{}
- (void)viewDidUnLoad{}

- (void)viewWillBecomeFoucsWithIntentData:(id)intentData{}
- (void)viewWillResignFoucs{}


- (void)render
{
    __weak typeof(self) weakSelf = self;
    [self.interactor fetchRenderDataWithBlock:^(id obj) {
        weakSelf.expressData = [weakSelf filterWithData:obj];
        // 如果有接受者采用直接推送
        if ([weakSelf.activity respondsToSelector:@selector(fillData:)]) {
            [weakSelf.activity fillData:weakSelf.expressData];
        }
    }];
    
}

- (id)filterWithData:(id)data
{
    return data;
}
@end
