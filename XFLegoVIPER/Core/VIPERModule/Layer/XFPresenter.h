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
#import "XFExpressPack.h"
#import "XFRenderData.h"
#import "XFVIPERModuleReflect.h"


#define XFConvertInteractorToType(type) LEGORealPort(type, self.interactor)
#define XFConvertRoutingToType(type) LEGORealPort(type, self.routing)
#define XFConvertUserInterfaceToType(type) LEGORealPort(type, self.userInterface)


// 基于ReactiveCocoa的快速命令执行宏
#define XF_CEXE_Begin XF_Define_Weak
// 绑定命令与执行代码（默认返回空信号，可手动返回新的信号）
#define XF_CEXE_(commandRef, ExecuteCode) \
commandRef = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) { \
    XF_Define_Strong \
    [self self]; \
    ExecuteCode \
    return [RACSignal empty]; \
}];
// 基于enable信号，绑定命令与执行代码（默认返回空信号，可手动返回新的信号）
#define XF_CEXE_Enable_(commandRef, enableSignal, ExecuteCode)\
commandRef = [[RACCommand alloc] initWithEnabled:enableSignal signalBlock:^RACSignal *(id input) {\
    XF_Define_Strong \
    [self self]; \
    ExecuteCode \
    return [RACSignal empty]; \
}];


// 通过渲染数据创建表达对象
#define XF_SetExpressPack_(ExpressPackClass,renderData) \
[self expressPackCreateFromClass:[ExpressPackClass class] fillRenderData:renderData];
// 快速创建通过渲染数据表达对象（使用默认类XFExpressPack）
#define XF_SetExpressPack_Fast(renderData) \
XF_SetExpressPack_(XFExpressPack,renderData)

// 添加渲染数据到子列表最后
#define XF_AddExpressPack_Last(renderData) \
[self expressPackAddLastRenderData:renderData];
// 添加渲染数据到子列表首
#define XF_AddExpressPack_First(renderData) \
[self expressPackAddNewRenderData:renderData];

// 从加载最近的数据创建indexPaths
#define XF_CreateIndexPaths_Last(renderData,section,offset) \
[self expressPackTransform2IndexPathsFromLastRenderData:renderData inSection:section offsetCount:offset]
// 一个快速只适合单组数据的创建indexPaths
#define XF_CreateIndexPaths_Last_Fast(renderData) XF_CreateIndexPaths_Last(renderData,0,0)
// 从加载最新的数据创建indexPaths
#define XF_CreateIndexPaths_First(renderData,section,offset) \
[self expressPackTransform2IndexPathsFromFirstRenderData:renderData inSection:section offsetCount:offset]
#define XF_CreateIndexPaths_First_Fast(renderData) XF_CreateIndexPaths_First(renderData,0,0)

// 清空渲染数据
#define XF_ExpressPack_Clean() \
[self expressPackClean];

@interface XFPresenter : NSObject <XFEventHandlerPort,XFUIOperatorPort>
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
@property (nonatomic, copy) NSDictionary *URLParams;
/**
 *  通过其它URL组件传递过来的数据对象
 */
@property (nonatomic, copy) id componentData;
/**
 *  预设要传递给其它组件的意图数据
 */
@property (nonatomic, copy) id intentData;

/**
 *  快速填充简单数据
 */
@property (nonatomic, strong) id expressData;
/**
 *  填充列表复杂数据（RenderData渲染数据的包装类）
 *
 */
@property (nonatomic, strong) __kindof XFExpressPack *expressPack;

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


/**
 *  初始化填充数据包
 *
 *  @param expressPackClass 自定义的数据包类
 *  @param renderData       渲染数据
 */
- (void)expressPackCreateFromClass:(Class)expressPackClass fillRenderData:(XFRenderData *)renderData;
/**
 *  数据包追加渲染数据
 *
 *  @param renderData 渲染数据
 */
- (void)expressPackAddLastRenderData:(XFRenderData *)renderData;
/**
 *  数据包插入新渲染数据
 *
 *  @param renderData 渲染数据
 */
- (void)expressPackAddNewRenderData:(XFRenderData *)renderData;
/**
 *  清空数据包
 */
- (void)expressPackClean;
/**
 *  从上拉刷新的新渲染数据，返回相对于列表IndexPaths的路径
 *
 *  @param renderData 渲染数据
 *  @param section    添加组
 *  @param offset     偏移量
 *
 *  @return NSIndexPath数组
 */
- (NSArray<NSIndexPath *> *)expressPackTransform2IndexPathsFromLastRenderData:(XFRenderData *)renderData inSection:(NSInteger)section offsetCount:(NSInteger)offset;
/**
 *  从下拉刷新的新渲染数据，返回相对于列表IndexPaths的路径
 *
 *  @param renderData 渲染数据
 *  @param section    添加组
 *  @param offset     偏移量
 *
 *  @return NSIndexPath数组
 */
- (NSArray<NSIndexPath *> *)expressPackTransform2IndexPathsFromFirstRenderData:(XFRenderData *)renderData inSection:(NSInteger)section offsetCount:(NSInteger)offset;
@end
