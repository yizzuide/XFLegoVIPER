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

@interface XFPresenter : NSObject <XFEventHandlerPort,XFUIOperatorPort>
/**
 *  显示界面
 */
@property (nonatomic, weak) id<XFUserInterfacePort> userInterface;
/**
 *  界面跳转和模块切换管理
 */
@property (nonatomic, strong) id<XFWireFramePort> routing;
/**
 *  业务管理者
 */
@property (nonatomic, strong) id<XFInteractorPort> interactor;

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
 *  绑定视图完成(架构方法，用于子类覆盖，不要直接调用！）
 */
- (void)viewDidLoad;

/**
 *  视图解绑(架构方法，用于子类覆盖，不要直接调用！）
 */
- (void)viewDidUnLoad;

/**
 *  发起从后台抓起数据后渲染视图
 *
 */
- (void)render;

/**
 *  格式化数据的数据
 *
 *  @param data 原数据
 */
- (id)filterWithData:(id)data;
@end
