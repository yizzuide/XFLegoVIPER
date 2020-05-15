//
//  XFPageControlUserInterfacePort.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 2016/10/13.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFPageControlUserInterfacePort_h
#define XFPageControlUserInterfacePort_h
#import "XFUserInterfacePort.h"

@protocol XFPageControlUserInterfacePort <XFUserInterfacePort>

- (void)switch2SubActivity:(__kindof id<XFUserInterfacePort>)subActivity;
@end

#endif /* XFPageControlUserInterfacePort_h */
