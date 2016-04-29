//
//  XFWireframe.h
//  VIPERGem
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFWireframe_h
#define XFWireframe_h

#import <UIKit/UIKit.h>


@class XFRouting;
@protocol XFUserInterfaceProt;

@protocol XFWireFrameProt <NSObject>
/**
 *  切换探路者（注意：如果要保存探路者的关系链，请调用父类实现）
 *
 *  @param nextRouting 探路者
 */
- (void)flowToNextRouting:(XFRouting *)nextRouting;
/**
 *  dismiss当前视图(注意：返回到上一个界面的意图数据需要在当前模块的Presenter里设置intentData属性）
 */
- (void)dismissInterface;
/**
 *  推出当前视图(注意：返回到上一个界面的意图数据在需要当前模块的Presenter里设置intentData属性）
 */
- (void)popInterface;

/**
 *  推入一个新视图
 *
 *  @param interface  视图
 *  @param intentData 意图数据
 */
- (void)pushInterface:(id<XFUserInterfaceProt>)interface intent:(id)intentData;

/**
 *  modal一个新视图
 *
 *  @param interface  视图
 *  @param intentData 意图数据
 */
- (void)presentInterface:(id<XFUserInterfaceProt>)interface intent:(id)intentData;

@end

#endif /* XFWireframe_h */
