//
//  NSObject+XFLegoInvokeMethod.h
//  XFLegoVIPER
//
//  Created by 付星 on 16/8/28.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XFLegoInvokeMethod)

/**
 *  调用当前对象发送消息,无参数
 *
 *  @param selector 消息方法
 */
- (void)invokeMethod:(NSString *)selector;
/**
 *  调用当前对象发送消息，并传递一个参数
 *
 *  @param selector 消息方法
 *  @param param    参数
 */
- (void)invokeMethod:(NSString *)selector param:(id)param;
/**
 *  调用当前对象发送消息，并传递一个参数
 *
 *  @param selector 消息方法
 *  @param param1   参数1
 *  @param param2   参数2
 */
- (void)invokeMethod:(NSString *)selector param1:(id)param1 param2:(id)param2;
@end
