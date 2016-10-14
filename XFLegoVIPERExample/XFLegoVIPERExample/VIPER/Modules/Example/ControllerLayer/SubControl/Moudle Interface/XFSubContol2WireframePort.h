//
//  XFSubContol2WireframePort.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/4.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFSubContol2WireframePort_h
#define XFSubContol2WireframePort_h

#import "XFWireFramePort.h"

@protocol XFSubContol2WireframePort <XFWireFramePort>

- (void)fluctuate2CollectSubRouteWithHostView:(UIView *)hostView;
- (void)switch2CollectSubRoute;
- (void)swith2WorksSubRoute;
@end

#endif /* XFSubContol2WireframePort_h */
