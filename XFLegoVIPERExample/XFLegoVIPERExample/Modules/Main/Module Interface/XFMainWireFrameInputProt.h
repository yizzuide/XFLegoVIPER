//
//  XFMainWireFrameInputProt.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFMainWireFrameInputProt_h
#define XFMainWireFrameInputProt_h

#import "XFWireFrameProt.h"

@protocol XFMainWireFrameInputProt <XFWireFrameProt>
// 切换到登录界面
- (void)transitionToLoginMoudle;

@end

#endif /* XFMainWireFrameInputProt_h */
