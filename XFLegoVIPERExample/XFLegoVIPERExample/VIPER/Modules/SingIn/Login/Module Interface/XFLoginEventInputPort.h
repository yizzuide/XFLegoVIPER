//
//  XFLoginEventInputPort.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFLoginEventInputPort_h
#define XFLoginEventInputPort_h

@class NSString,RACSignal;
@protocol XFEventHandlerPort;

@protocol XFLoginEventInputPort <XFEventHandlerPort>

- (void)didRequestLoginWithUserName:(NSString *)name password:(NSString *)pwd;
- (void)didRequestLoginCancel;
@end

#endif /* XFLoginEventInputPort_h */
