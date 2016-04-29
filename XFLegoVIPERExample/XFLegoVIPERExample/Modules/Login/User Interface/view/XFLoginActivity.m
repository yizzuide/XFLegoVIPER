//
//  XFLoginActivity.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFLoginActivity.h"
#import "XFLoginEventInputProt.h"
#import "XFUITool.h"

@interface XFLoginActivity ()

@property (weak, nonatomic) IBOutlet UITextField *usrTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@end

@implementation XFLoginActivity

- (IBAction)cancelLogin:(id)sender {
    [XFConvertPresenterToType(id<XFLoginEventInputProt>) didRequestLoginCancel];
}
- (IBAction)loginAction:(id)sender {
    if ([self.usrTextField.text isEqualToString:@""] || [self.pwdTextField.text isEqualToString:@""]) {
        [[XFUITool sharedUI] showToastWithTitle:@"输入为空！" complete:nil];
        return;
    }
    [XFUITool showWaitNoticeFormView:self.view];
    [XFConvertPresenterToType(id<XFLoginEventInputProt>) didRequestLoginWithUserName:self.usrTextField.text password:self.pwdTextField.text];
}

- (void)requestFinish
{
    [XFUITool hideWaitNoticeFormView:self.view];
}

- (void)showError:(NSString *)error
{
    [XFUITool hideWaitNoticeFormView:self.view];
    [[XFUITool sharedUI] showToastWithTitle:error complete:nil];
}

@end
