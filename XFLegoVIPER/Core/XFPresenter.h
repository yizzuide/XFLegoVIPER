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

#define XFConvertInteractorToType(type) LEGORealPort(type, self.interactor)
#define XFConvertRoutingToType(type) LEGORealPort(type, self.routing)
#define XFConvertUserInterfaceToType(type) LEGORealPort(type, self.userInterface)

#define XF_EventIs_(EventName,ExecuteCode) if ([eventName isEqualToString:EventName]) { \
    ExecuteCode \
    return; \
}

@interface XFPresenter : NSObject <XFEventHandlerPort,XFUIOperatorPort>
/**
 *  显示界面
 */
@property (nonatomic, weak, readonly) id<XFUserInterfacePort> userInterface;
/**
 *  当前路由，负责界面跳转和模块切换管理
 */
@property (nonatomic, strong, readonly) id<XFWireFramePort> routing;
/**
 *  业务管理者
 */
@property (nonatomic, strong, readonly) id<XFInteractorPort> interactor;

/**
 *  模块之间传递的意图数据
 */
@property (nonatomic, strong) id intentData;

/**
 * 视图填充数据
 *
 */
@property (nonatomic, strong) id expressData;

/**
 *  错误消息
 */
@property (nonatomic, copy) NSString *errorMessage;


/**
 *  绑定视图完成(框架方法，用于子类覆盖，不要直接调用！）
 */
- (void)viewDidLoad;

/**
 *  初始化渲染视图数据(框架方法，用于子类覆盖，不要直接调用！）
 */
- (void)initRenderView;

/**
 *  视图解绑(框架方法，用于子类覆盖，不要直接调用！）
 */
- (void)viewDidUnLoad;
@end
