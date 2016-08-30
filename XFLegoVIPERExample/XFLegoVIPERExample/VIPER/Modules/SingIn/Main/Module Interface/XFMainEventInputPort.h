//
//  XFMainEventInputPort.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFMainEventInputPort_h
#define XFMainEventInputPort_h

@protocol XFEventHandlerPort;

@protocol XFMainEventInputPort <XFEventHandlerPort>

- (void)didRequestToLoginTransition;
@end
#endif /* XFMainEventInputPort_h */
