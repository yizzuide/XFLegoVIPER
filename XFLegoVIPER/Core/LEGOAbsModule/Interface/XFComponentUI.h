//
//  XFComponentUI.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/2/10.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#ifndef XFComponentUI_h
#define XFComponentUI_h

@protocol XFComponentUI <NSObject>

@optional
/**
 *  键盘弹起，需要更新输入界面的的Y值
 *
 *  @param y            键盘移动的Y值
 *  @param durationTime 持续时间
 */
- (void)needUpdateInputUInterfaceY:(CGFloat)y durationTime:(CGFloat)durationTime;

@end

#endif /* XFComponentUI_h */
