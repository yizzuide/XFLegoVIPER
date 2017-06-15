//
//  UIViewController+LEView.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/29.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEDataDriverProtocol.h"
#import "LEViewProtocol.h"
#import "XFLegoMarco.h"
#import "UIViewController+ComponentUI.h"

@interface UIViewController (LEView) <LEViewProtocol>

/**
 *  数据驱动器
 */
@property (nonatomic, strong, readonly) __kindof id<LEDataDriverProtocol> dataDriver;
@end
