//
//  XFLoginEventInputProt.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFLoginEventInputProt_h
#define XFLoginEventInputProt_h

@class NSString,RACSignal;
@protocol XFEventHandlerProt;

@protocol XFLoginEventInputProt <XFEventHandlerProt>

- (void)didRequestLoginWithUserName:(NSString *)name password:(NSString *)pwd;
- (void)didRequestLoginCancel;
@end

#endif /* XFLoginEventInputProt_h */
