//
//  XFLoginInteratorInputPort.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFLoginInteratorInputPort_h
#define XFLoginInteratorInputPort_h

@class RACSignal;

@protocol XFLoginInteractorInputPort <XFInteractorPort>

- (RACSignal *)loginWithUserName:(NSString *)name password:(NSString *)pwd;
@end
#endif /* XFLoginInteratorInputPort_h */
