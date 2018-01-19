//
//  XFPipePort.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2018/1/18.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#ifndef XFPipePort_h
#define XFPipePort_h

/**
 *  事件发射源插件化接口
 */
NS_ASSUME_NONNULL_BEGIN
@protocol XFPipePort <NSObject>

/**
 * 调用管道发射事件，开始让乐高框架接管分发出去
 *  @param eventName      事件名
 *  @param intentData     消息意图数据
 */
- (void)emitEventName:(NSString *)eventName intentData:(nullable id)intentData;
@end
NS_ASSUME_NONNULL_END


#endif /* XFPipePort_h */
