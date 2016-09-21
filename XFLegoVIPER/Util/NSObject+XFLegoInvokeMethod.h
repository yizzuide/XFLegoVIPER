//
//  NSObject+XFLegoInvokeMethod.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/28.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XFLegoInvokeMethod)
/**
 *  向对象发消息
 *
 *  @param selector 消息方法
 *  @param param    参数
 *  @param object   目标对象
 */
- (void)invokeMethod:(NSString *)selector param:(id)param forObject:(id)object;
@end
