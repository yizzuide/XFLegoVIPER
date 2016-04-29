//
//  XFLoginUserInterfaceProt.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFLoginUserInterfaceProt_h
#define XFLoginUserInterfaceProt_h

@protocol XFUserInterfaceProt;
@protocol XFLoginUserInterfaceProt <XFUserInterfaceProt>

- (void)requestFinish;
- (void)showError:(NSString *)error;
@end

#endif /* XFLoginUserInterfaceProt_h */
