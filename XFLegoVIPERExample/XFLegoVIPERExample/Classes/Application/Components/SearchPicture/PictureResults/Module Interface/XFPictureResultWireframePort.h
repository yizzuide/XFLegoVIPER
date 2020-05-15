//
//  XFPictureResultWireframePort.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/9/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFWireFramePort.h"

@protocol XFPictureResultWireframePort <XFWireFramePort>

- (void)transitionToDetailsModule;
- (void)transitionToSubControlModule;
- (void)transitionToSubControl2Module;
- (void)transitionToPageControlModule;
- (void)transitionToWeiboModule;
@end

