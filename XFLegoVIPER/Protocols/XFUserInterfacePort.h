//
//  XFUserInterface.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFUserInterfacePort_h
#define XFUserInterfacePort_h

@protocol XFUserInterfacePort <NSObject>

@optional
/**
 *  视图加载后要填充的数据
 *
 *  @param data 数据
 */
- (void)fillData:(id)data;

@end


#endif /* XFUserInterfacePort_h */
