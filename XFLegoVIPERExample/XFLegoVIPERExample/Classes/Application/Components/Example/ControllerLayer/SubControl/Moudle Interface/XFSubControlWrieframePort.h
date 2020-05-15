//
//  XFSubControlWrieframePort.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2016/10/3.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#ifndef XFSubControlWrieframePort_h
#define XFSubControlWrieframePort_h
#import "XFWireFramePort.h"

@protocol XFSubControlWrieframePort <XFWireFramePort>

- (UIView *)fluctuate2CollectSubRoutes;

- (void)switch2CollectSubRoute;
- (void)switch2WorksSubRoute;

@end


#endif /* XFSubControlWrieframePort_h */
