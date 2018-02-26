//
//  XFPipePort.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2018/1/18.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#ifndef XFPipePort_h
#define XFPipePort_h

@protocol XFEventReceivable;

/**
 *  事件管道源端口
 */
NS_ASSUME_NONNULL_BEGIN
@protocol XFPipePort <NSObject>

/**
 *  调用管道发射事件
 *  @param eventName      事件名
 *  @param intentData     消息意图数据
 */
- (void)emitEventName:(NSString *)eventName intentData:(nullable id)intentData;

/**
 *  调用管道订阅事件
 *  @param eventReceiver                    事件接受对象
 *  @param compName                         注册的组件名
 *  @param needReceiveEmitterEvent          是否需要接收Emitter发射的事件
 */
- (void)subscribeEventOnReceiver:(id<XFEventReceivable>)eventReceiver withRegisterCompName:(NSString *)compName needReceiveEmitterEvent:(BOOL)needReceiveEmitterEvent;
/**
 *  调用管道取消订阅事件
 *  @param compName                         注册的组件名
 *  @param needReceiveEmitterEvent          是否需要接收Emitter发射的事件
 */
- (void)unSubscribeEventWithCompName:(NSString *)compName needReceiveEmitterEvent:(BOOL)needReceiveEmitterEvent;
@end
NS_ASSUME_NONNULL_END


#endif /* XFPipePort_h */
