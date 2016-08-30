//
//  UINavigationController+BackButtonHandler.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "UINavigationController+BackButtonHandler.h"
#import "XFLegoMarco.h"

@implementation UINavigationController (BackButtonHandler)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    UIViewController *topViewController = self.topViewController;
    BOOL wasBackButtonClicked = topViewController.navigationItem == item;
    SEL backButtonPressedSel = @selector(backButtonPressed);
    if (wasBackButtonClicked && [topViewController respondsToSelector:backButtonPressedSel]) {
        SuppressPerformSelectorLeakWarning(
            [topViewController performSelector:backButtonPressedSel];
        )
        return NO;
    }
    else {
        [self popViewControllerAnimated:YES];
        return YES;
    }
}
@end
