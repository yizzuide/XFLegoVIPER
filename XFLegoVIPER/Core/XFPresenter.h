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

// 快速事件类型检测执行的宏
#define XF_EventIs_(EventName,ExecuteCode) if ([eventName isEqualToString:EventName]) { \
    ExecuteCode \
    return; \
}

// 基于ReactiveCocoa的快速命令执行宏
#define XF_CEXE_Begin @weakify(self)
// 绑定命令与执行代码（默认返回空信号，可手动返回新的信号）
#define XF_CEXE_(commandRef, executeCode) \
commandRef = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) { \
    @strongify(self) \
    executeCode \
    return [RACSignal empty]; \
}];
// 基于enable信号，绑定命令与执行代码（默认返回空信号，可手动返回新的信号）
#define XF_CEXE_Enable_(commandRef, enableSignal,executeCode)\
commandRef = [[RACCommand alloc] initWithEnabled:enableSignal signalBlock:^RACSignal *(id input) {\
    @strongify(self) \
    executeCode \
    return [RACSignal empty]; \
}];

// VIPER模块事件发送
#define XF_SendEventForMoudle_(moudleName,eventName,sendData) \
[self.routing sendEventName:eventName intentData:sendData forMoudleName:moudleName];
#define XF_SendEventForMoudles_(moudlesName,eventName,sendData) \
[self.routing sendEventName:eventName intentData:sendData forMoudlesName:moudlesName];

// 向MVx发通知
#define XF_SendMVxNoti_(notiName,sendData) \
[self.routing sendNotificationForMVxWithName:notiName intentData:sendData];
// 注册MVx通知
#define XF_RegisterMVxNotis_(notisName) \
[self.routing registerForMVxNotificationsWithNameArray:notisName];

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
 *  初始化命令（绑定视图层的事件动作<Action>）
 */
- (void)initCommand;

/**
 *  注册MVx架构通知 (不用手动移除通知，内部会进行管理)
 */
- (void)registerMVxNotifactions;

/**
 *  初始化渲染视图数据,在viewDidLoad之后，viewWillAppear之前调用(框架方法，用于子类覆盖，不要直接调用！）
 */
- (void)initRenderView;

// 同步视图生命周期(框架方法，用于子类覆盖，不要直接调用！）
- (void)viewDidLoad;
- (void)viewWillAppear;
- (void)viewDidAppear;
- (void)viewWillDisappear;
- (void)viewDidDisappear;
@end
