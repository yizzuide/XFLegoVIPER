//
//  XFPipe.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2018/1/18.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFPipePort.h"

@protocol XFEmitterPlug;
NS_ASSUME_NONNULL_BEGIN
/**
 * 一个插在框架组件容器里的管道，从外接入发送全局事件或订阅事件消息
 */
@interface XFPipe : NSObject <XFPipePort>

+ (instancetype)shareInstance;
/**
 *  添加事件发射器
 *  @param emitter      发射器
 */
- (void)addEmitter:(id<XFEmitterPlug>)emitter;

@end
NS_ASSUME_NONNULL_END
