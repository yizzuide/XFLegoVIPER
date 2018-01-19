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
@interface XFPipe : NSObject <XFPipePort>

+ (instancetype)shareInstance;
/**
 *  添加事件发射器
 *  @param emitter      发射器
 */
- (void)addEmitter:(id<XFEmitterPlug>)emitter;

@end
NS_ASSUME_NONNULL_END
