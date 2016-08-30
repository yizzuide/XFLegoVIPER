//
//  XFMainActivity.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFMainActivity.h"
#import "XFMainEventInputPort.h"
#import "XFLoginInfoModel.h"

@interface XFMainActivity ()

@property (weak, nonatomic) IBOutlet UILabel *usrLabel;
@property (weak, nonatomic) IBOutlet UILabel *authType;
@end

@implementation XFMainActivity

- (IBAction)loginAction {
    [XFConvertPresenterToType(id<XFMainEventInputPort>) didRequestToLoginTransition];
}

- (void)fillData:(id)data
{
    XFLoginInfoModel *info = data;
    self.usrLabel.text = info.userName;
    self.authType.text = info.token_type;
}


@end
