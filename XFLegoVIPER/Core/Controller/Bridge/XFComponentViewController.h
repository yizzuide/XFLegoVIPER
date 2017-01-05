//
//  XFComponentViewController.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFControllerComponentRunnable.h"

@interface XFComponentViewController : UIViewController <XFControllerComponentRunnable>

/**
 *  通过其它URL组件传递过来的参数
 */
@property (nonatomic, copy) NSDictionary *URLParams;

/**
 *  通过其它URL组件传递过来的数据对象
 */
@property (nonatomic, copy) id componentData;

/**
 *  预设要传递给其它组件的意图数据
 */
@property (nonatomic, copy) id intentData;

@end
