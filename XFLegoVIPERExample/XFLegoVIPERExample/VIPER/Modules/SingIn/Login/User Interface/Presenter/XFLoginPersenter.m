//
//  XFLoginPersenter.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFLoginPersenter.h"
#import "ReactiveCocoa.h"
#import "XFLoginWireFrameInputPort.h"
#import "XFLoginInteratorInputPort.h"
#import "XFLoginUserInterfacePort.h"

@implementation XFLoginPersenter


- (void)didRequestLoginCancel
{
    [XFConvertRoutingToType(id<XFLoginWireFrameInputPort>) loginToDissmiss];
}

- (void)didRequestLoginWithUserName:(NSString *)name password:(NSString *)pwd
{
    @weakify(self)
    [[XFConvertInteractorToType(id<XFLoginInteractorInputPort>) loginWithUserName:name password:pwd] subscribeNext:^(id x) {
        @strongify(self)
        [XFConvertUserInterfaceToType(id<XFLoginUserInterfacePort>) requestFinish];
        self.intentData = x;
        [self didRequestLoginCancel];
    } error:^(NSError *error) {
        [XFConvertUserInterfaceToType(id<XFLoginUserInterfacePort>) showError:@"用户名或密码错误！"];
    }];
}
@end
