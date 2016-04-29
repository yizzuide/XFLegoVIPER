//
//  XFMainEventInputProt.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFMainEventInputProt_h
#define XFMainEventInputProt_h

@protocol XFEventHandlerProt;

@protocol XFMainEventInputProt <XFEventHandlerProt>

- (void)didRequestToLoginTransition;
@end
#endif /* XFMainEventInputProt_h */
