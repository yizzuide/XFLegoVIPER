//
//  XFComponentUIEvent.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/3/15.
//  Copyright © 2017年 Yizzuide. All rights reserved.
//

#ifndef XFComponentUIEvent_h
#define XFComponentUIEvent_h

/**
 *  这个协议用于模块事件层实现，针对视图要做的统一事件处理
 */
@protocol XFComponentUIEvent <NSObject>

@optional
/**
 *  使视图层退下键盘
 */
- (void)dismissKeyboard;

@end


#endif /* XFComponentUIEvent_h */
