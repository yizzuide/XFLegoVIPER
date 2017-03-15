//
//  XFComponentBindEvent.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/2/10.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#ifndef XFComponentBindEvent_h
#define XFComponentBindEvent_h

/**
 *  这个协议是框架内部使用，用于事件层同步视图层的生命周期
 */
@protocol XFComponentBindEvent <NSObject>

@required
// 绑定视图
- (void)xfLego_bindView:(id)view;
/**
 *  视图将被pop或dismiss
 */
- (void)xfLego_viewWillPopOrDismiss;


@optional
// 同步视图生命周期
- (void)viewDidLoad;
- (void)viewWillAppear;
- (void)viewDidAppear;
- (void)viewWillDisappear;
- (void)viewDidDisappear;

/**
 *  初始化命令（绑定视图层的事件动作<Action>）
 */
- (void)initCommand;

/**
 *  注册MVx架构通知 (不用手动移除通知，内部会进行管理)
 */
- (void)registerMVxNotifactions;

/**
 *  初始化渲染视图数据,在viewDidLoad之后，viewWillAppear之前调用
 */
- (void)initRenderView;
@end



#endif /* XFComponentBindEvent_h */
