//
//  XFWireframe.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFWireframe_h
#define XFWireframe_h

#import <UIKit/UIKit.h>
#import "XFEventBus.h"

@protocol XFWireFramePort <NSObject>

/**
 *  事件总线
 */
@property (nonatomic, strong, readonly) XFEventBus *eventBus;

/**
 *  dismiss当前视图(注意：返回到上一个界面的意图数据需要在当前模块的Presenter里设置intentData属性）
 */
- (void)dismiss;

/**
 *  推出当前视图(注意：返回到上一个界面的意图数据在需要当前模块的Presenter里设置intentData属性）
 */
- (void)pop;

@end

#endif /* XFWireframe_h */
