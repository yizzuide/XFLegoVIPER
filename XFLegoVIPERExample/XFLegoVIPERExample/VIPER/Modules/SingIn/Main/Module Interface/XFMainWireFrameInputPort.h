//
//  XFMainWireFrameInputPort.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFMainWireFrameInputPort_h
#define XFMainWireFrameInputPort_h

#import "XFWireFramePort.h"

@protocol XFMainWireFrameInputPort <XFWireFramePort>
// 切换到登录界面
- (void)transitionToLoginMoudle;

@end

#endif /* XFMainWireFrameInputPort_h */
