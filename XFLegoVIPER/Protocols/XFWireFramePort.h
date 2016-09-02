//
//  XFWireframe.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFWireframe_h
#define XFWireframe_h

#import <UIKit/UIKit.h>

@protocol XFWireFramePort <NSObject>

/**
 *  dismiss当前视图(注意：返回到上一个界面的意图数据需要在当前模块的Presenter里设置intentData属性）
 */
- (void)dismiss;

/**
 *  推出当前视图(注意：返回到上一个界面的意图数据在需要当前模块的Presenter里设置intentData属性）
 */
- (void)pop;

/**
 *  发送消息事件到一个模块
 *
 *  @param name       事件名
 *  @param intentData 消息数据
 *  @param moudleName 业务模块名
 */
- (void)sendEventName:(NSString *)name intentData:(id)intentData forMoudleName:(NSString *)moudleName;

@end

#endif /* XFWireframe_h */
