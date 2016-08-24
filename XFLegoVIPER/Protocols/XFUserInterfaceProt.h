//
//  XFUserInterface.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFUserInterfaceProt_h
#define XFUserInterfaceProt_h

@protocol XFUserInterfaceProt <NSObject>

@optional
/**
 *  视图加载后要填充的数据
 *
 *  @param data 数据
 */
- (void)fillData:(id)data;

@end


#endif /* XFUserInterfaceProt_h */
