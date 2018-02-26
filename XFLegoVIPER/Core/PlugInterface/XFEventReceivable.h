//
//  XFEventDispatchPort.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2018/1/8.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#ifndef XFEventDispatchPort_h
#define XFEventDispatchPort_h
#import "NSObject+XFPipe.h"

/**
 *  事件派发接口，实现这个接口的对象皆为事件接收者
 */
@protocol XFEventReceivable <NSObject>

@optional
/**
 *  接收到组件的消息事件
 *
 *  @param eventName  消息名
 *  @param intentData 消息数据
 */
- (void)receiveComponentEventName:(nonnull NSString *)eventName intentData:(nullable id)intentData;
@end

#endif /* XFEventDispatchPort_h */
