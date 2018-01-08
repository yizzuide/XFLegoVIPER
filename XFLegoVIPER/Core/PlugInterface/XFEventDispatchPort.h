//
//  XFEventDispatchPort.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2018/1/8.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#ifndef XFEventDispatchPort_h
#define XFEventDispatchPort_h

@protocol XFEventDispatchPort <NSObject>

/**
 *  接收到组件的消息事件
 *
 *  @param eventName  消息名
 *  @param intentData 消息数据
 */
- (void)receiveComponentEventName:(NSString *)eventName intentData:(nullable id)intentData;
@end

#endif /* XFEventDispatchPort_h */
