//
//  CBUITool.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 15/9/18.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFUITool.h"
#import "MBProgressHUD.h"

@interface XFUITool ()

@property (nonatomic, weak) MBProgressHUD *hud;
@end


@implementation XFUITool
SingletonM(UI)

- (MBProgressHUD *)hud
{
    if (_hud == nil) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] init];
        hud.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [[[UIApplication sharedApplication].windows lastObject] addSubview:hud];
        _hud = hud;
    }
    return _hud;
}

- (void)showToastWithTitle:(NSString *)title complete:(void (^)())completeBlock
{
    self.hud.mode=MBProgressHUDModeText;
    _hud.labelText = title;
    
    [_hud show:YES];
    [_hud hide:YES afterDelay:1];
    self.hud = nil;
    
    if (completeBlock) {
        _hud.completionBlock = ^{
            completeBlock();
        };
    }
}

- (void)showWaitNoticeWithTitle:(NSString *)title complete:(void (^)())completeBlock
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
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

- (void)showMessageWithTile:(NSString *)title stauts:(BOOL)success complete:(void (^)())completeBlock
{
    self.hud.mode = MBProgressHUDModeCustomView;
    if (success) {
        _hud.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"success"]];
    }else{
        _hud.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"error"]];
    }
    _hud.labelText = title;
    
    [_hud show:YES];
    [_hud hide:YES afterDelay:1];
    
    if (completeBlock) {
        _hud.completionBlock = ^{
            completeBlock();
            _hud = nil;
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
