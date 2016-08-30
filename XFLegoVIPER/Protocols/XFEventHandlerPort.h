//
//  XFEventHandlerPort.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFEventHandlerPort_h
#define XFEventHandlerPort_h

@protocol XFEventHandlerPort <NSObject>

/**
 * 视图填充数据
 *
 */
@property (nonatomic, strong) id expressData;

/**
 *  错误消息
 */
@property (nonatomic, copy) NSString *errorMessage;

/**
 *  pop当前视图
 */
- (void)requirePopModule;
@end


#endif /* XFEventHandlerPort_h */
