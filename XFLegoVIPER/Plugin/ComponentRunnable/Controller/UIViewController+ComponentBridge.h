//
//  UIViewController+ComponentBridge.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/19.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFUIBus.h"
#import "XFEventBus.h"

@interface UIViewController (ComponentBridge)
/**
 *  UI总线
 */
@property (nonatomic, strong, readonly) __kindof XFUIBus *uiBus;
/**
 *  事件总线
 */
@property (nonatomic, strong, readonly) __kindof XFEventBus *eventBus;

/**
 *  上一个组件（来源组件）
 */
@property (nonatomic, weak, readonly) __kindof id<XFComponentRoutable> fromComponentRoutable;

/**
 *  下一个组件
 */
@property (nonatomic, weak, readonly) __kindof id<XFComponentRoutable> nextComponentRoutable;
@end
