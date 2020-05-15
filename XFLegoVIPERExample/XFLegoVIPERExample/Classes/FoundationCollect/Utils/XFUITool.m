//
//  CBUITool.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 15/9/18.
//  Copyright © 2015年 Yizzuide. All rights reserved.
//

#import "XFUITool.h"
#import "MBProgressHUD.h"

@implementation XFUITool


+ (void)showToastWithTitle:(NSString *)title complete:(void (^)())completeBlock
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
    hud.mode=MBProgressHUDModeText;
    hud.labelFont = [UIFont boldSystemFontOfSize:17];
    hud.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    hud.labelText = title;
    [window addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1];
    
    if (completeBlock) {
        hud.completionBlock = ^{
            completeBlock();
        };
    }
}


+ (void)showWaitNotice {
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}

+ (void)showWaitNoticeFormView:(UIView *)view
{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+ (void)hideWaitNotice {
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

+ (void)hideWaitNoticeFormView:(UIView *)view
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

@end
