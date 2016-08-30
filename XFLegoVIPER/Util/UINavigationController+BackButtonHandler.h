//
//  UINavigationController+BackButtonHandler.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UINavigationControllerBackButtonDelegate <NSObject>
/**
 * Indicates that the back button was pressed.
 * If this message is implemented the pop logic must be manually handled.
 */
- (void)backButtonPressed;
@end

@interface UINavigationController (BackButtonHandler)

@end
