//
//  XFMessageViewController.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2017/1/16.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFControllerRunnable.h"

// 实现XFControllerComponentRunnable接口，使当前控制器成为组件
@interface XFMessageViewController : UIViewController <XFControllerRunnable>

// 可接收URL参数
@property (nonatomic, copy) NSDictionary *URLParams;

@end
