//
//  XFPresenter.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFEventHandlerPort.h"
#import "XFUserInterfacePort.h"
#import "XFWireFramePort.h"
#import "XFInteractorPort.h"
#import "XFUIOperatorPort.h"
#import "XFLegoMarco.h"
#import "XFVIPERModuleReflect.h"
#import "XFComponentBindEvent.h"
#import "XFComponentEventResponder.h"
#import "XFExpressDirver.h"

// 强制转换
#define XFConvertInteractorToType(type) LEGORealPort(type, self.interactor)
#define XFConvertRoutingToType(type) LEGORealPort(type, self.routing)
#define XFConvertUserInterfaceToType(type) LEGORealPort(type, self.userInterface)


NS_ASSUME_NONNULL_BEGIN
@interface XFPresenter : XFExpressDirver <XFComponentBindEvent, XFEventHandlerPort, XFUIOperatorPort>
/**
 *  显示界面
 */
@property (nonatomic, weak, readonly) __kindof id<XFUserInterfacePort> userInterface;
/**
 *  当前路由，负责界面跳转和模块切换管理
 */
@property (nonatomic, strong, readonly) __kindof id<XFWireFramePort> routing;
/**
 *  业务管理者
 */
@property (nonatomic, strong, readonly) __kindof id<XFInteractorPort> interactor;

/**
 *  事件总线
 */
@property (nonatomic, strong, readonly) XFEventBus *eventBus;

/**
 *  上一个组件（来源组件）
 */
@property (nonatomic, weak) id<XFComponentRoutable> fromComponentRoutable;

/**
 *  下一个组件
 */
@property (nonatomic, weak) id<XFComponentRoutable> nextComponentRoutable;

/**
 *  通过其它URL组件传递过来的参数
 */
@property (nonatomic, copy, nullable) NSDictionary *URLParams;
/**
 *  通过其它URL组件传递过来的数据对象
 */
@property (nonatomic, copy, nullable) id componentData;
/**
 *  预设要传递给其它组件的意图数据
 */
@property (nonatomic, copy, nullable) id intentData;

@end
NS_ASSUME_NONNULL_END
