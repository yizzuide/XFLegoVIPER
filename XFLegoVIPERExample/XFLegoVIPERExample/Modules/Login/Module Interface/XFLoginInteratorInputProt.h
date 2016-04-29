//
//  XFLoginInteratorInputProt.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFLoginInteratorInputProt_h
#define XFLoginInteratorInputProt_h

@class RACSignal;

@protocol XFLoginInteractorInputProt <XFInteractorProt>

- (RACSignal *)loginWithUserName:(NSString *)name password:(NSString *)pwd;
@end
#endif /* XFLoginInteratorInputProt_h */
