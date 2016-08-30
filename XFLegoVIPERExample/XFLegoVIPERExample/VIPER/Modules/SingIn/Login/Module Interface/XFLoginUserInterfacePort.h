//
//  XFLoginUserInterfacePort.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFLoginUserInterfacePort_h
#define XFLoginUserInterfacePort_h

#import <CoreFoundation/CoreFoundation.h>

@protocol XFUserInterfacePort;
@protocol XFLoginUserInterfacePort <XFUserInterfacePort>

- (void)requestFinish;
- (void)showError:(NSString *)error;
@end

#endif /* XFLoginUserInterfacePort_h */
