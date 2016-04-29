//
//  XFLoginPersenter.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFLoginPersenter.h"
#import "ReactiveCocoa.h"
#import "XFLoginWireFrameInputProt.h"
#import "XFLoginInteratorInputProt.h"
#import "XFLoginUserInterfaceProt.h"

@implementation XFLoginPersenter


- (void)didRequestLoginCancel
{
    [XFConvertRoutingToType(id<XFLoginWireFrameInputProt>) loginToDissmiss];
}

- (void)didRequestLoginWithUserName:(NSString *)name password:(NSString *)pwd
{
    @weakify(self)
    [[XFConvertInteractorToType(id<XFLoginInteractorInputProt>) loginWithUserName:name password:pwd] subscribeNext:^(id x) {
        @strongify(self)
        [XFConvertActivityToType(id<XFLoginUserInterfaceProt>) requestFinish];
        self.intentData = x;
        [self didRequestLoginCancel];
    } error:^(NSError *error) {
        [XFConvertActivityToType(id<XFLoginUserInterfaceProt>) showError:@"用户名或密码错误！"];
    }];
}
@end
