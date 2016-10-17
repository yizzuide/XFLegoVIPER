//
//  XFWireframe.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFWireFramePort.h"
#import "XFUIOperatorPort.h"
#import "XFActivity.h"

// 快速获取当前模块视图
#define MainActivity LEGORealInterface(self.realInterface)

// 获取一个类的类
#define XF_Class_(Class) [Class class]

// 快速注入模块成分-导航方式
#define XF_InjectMoudleWith_Nav(_NavigatorClass_,_ActivityClass_,_PresenterClass_,_InteractorClass_,_DataManagerClass_) \
+ (instancetype)routing \
{ \
    return [[super routing] buildModulesAssemblyWithActivityClass:_ActivityClass_ \
                                                   navigatorClass:_NavigatorClass_ \
                                                   presenterClass:_PresenterClass_ \
                                                  interactorClass:_InteractorClass_ \
                                                 dataManagerClass:_DataManagerClass_]; \
}
// 快速注入模块成分-子界面方式
#define XF_InjectMoudleWith_Act(_ActivityClass_,_PresenterClass_,_InteractorClass_,_DataManagerClass_) \
XF_InjectMoudleWith_Nav(nil,_ActivityClass_,_PresenterClass_,_InteractorClass_,_DataManagerClass_)
// 快速注入模块成分-ib方式
#define XF_InjectMoudleWith_IB(ibSymbol,_PresenterClass_,_InteractorClass_,_DataManagerClass_) \
+ (instancetype)routing \
{ \
    return [[super routing] buildModulesAssemblyWithIB:ibSymbol presenterClass:_PresenterClass_ interactorClass:_InteractorClass_ dataManagerClass:_DataManagerClass_]; \
}

// 显示根模块
#define XF_ShowRootRouting2Window_(RoutingClass,customCode) \
RoutingClass *routing = [RoutingClass routing]; \
customCode \
[routing showRootActivityOnWindow:self.window];
// 快速显示一个根模块
#define XF_ShowRootRouting2Window_Fast(RoutingClass) \
XF_ShowRootRouting2Window_(RoutingClass,{})

// Push一个模块宏
#define XF_PUSH_Routing_(RoutingClass,customCode) \
RoutingClass *routing = [RoutingClass routing]; \
customCode \
[self pushRouting:routing intent:self.uiOperator.intentData];
// 快速Push一个模块
#define XF_PUSH_Routing_Fast(RoutingClass) \
XF_PUSH_Routing_(RoutingClass,{})

// Present一个模块宏
#define XF_Present_Routing_(RoutingClass,customCode) \
RoutingClass *routing = [RoutingClass routing]; \
customCode \
[self presentRouting:routing intent:self.uiOperator.intentData];
// 快速Present一个模块
#define XF_Present_Routing_Fast(RoutingClass) \
XF_Present_Routing_(RoutingClass,{})

// PUSH一个MVx构架控制器
#define XF_PUSH_VCForMVx_(UIViewControllerClass,customCode) \
UIViewControllerClass *viewController = [[UIViewControllerClass alloc] init]; \
customCode \
[self pushMVxViewController:viewController];
// 快速PUSH一个MVx构架控制器
#define XF_PUSH_VCForMVx_Fast(UIViewControllerClass) \
XF_PUSH_VCForMVx_(UIViewControllerClass,{})

// Present一个MVx构架控制器
#define XF_Present_VCForMVx_(UIViewControllerClass,customCode) \
UIViewControllerClass *viewController = [[UIViewControllerClass alloc] init]; \
customCode \
[self presentMVxViewController:viewController];
// 快速Present一个MVx构架控制器
#define XF_Present_VCForMVx_Fast(UIViewControllerClass) \
XF_Present_VCForMVx_(UIViewControllerClass,{})


typedef void(^TrasitionBlock)(XFActivity *thisInterface, XFActivity *nextInterface);

@interface XFRouting : NSObject <XFWireFramePort>

/**
 *  组装当前路由
 *
 *  @return 路由
 */
+ (instancetype)routing;

/**
 *  构建关系层
 *
 *  @param activityClass    视图层
 *  @param perstentClass    交互层
 *  @param interactorClass  业务层
 *  @param interactorClass  数据层
 *
 *  @return Routing
 */
- (instancetype)buildModulesAssemblyWithActivityClass:(Class)activityClass
                                       presenterClass:(Class)perstentClass
                                      interactorClass:(Class)interactorClass
                                     dataManagerClass:(Class)dataManagerClass;

/**
 *  构建关系层(视图从xib或storyboard中加载)
 *
 *  @param ibSymbol         使用字符串符号加载视图（xib:x-xibName[-activityClass],Storyboard:s-storyboardName-controllerIdentifier）
 *  @param perstentClass    交互层
 *  @param interactorClass  业务层
 *  @param dataManagerClass 数据层
 *
 *  @return Routing
 */
- (instancetype)buildModulesAssemblyWithIB:(NSString *)ibSymbol
                                       presenterClass:(Class)perstentClass
                                      interactorClass:(Class)interactorClass
                                     dataManagerClass:(Class)dataManagerClass;
/**
 *  构建关系层
 *
 *  @param activityClass    视图层
 *  @param navigatorClass   导航层
 *  @param perstentClass    交互层
 *  @param interactorClass  业务层
 *
 *  @return Routing
 */
- (instancetype)buildModulesAssemblyWithActivityClass:(Class)activityClass
                                       navigatorClass:(Class)navigatorClass
                                       presenterClass:(Class)perstentClass
                                      interactorClass:(Class)interactorClass
                                     dataManagerClass:(Class)dataManagerClass;

/**
 *  获得UI事件处理层（Presenter）
 */
@property (nonatomic, weak, readonly) id<XFUIOperatorPort> uiOperator;


/**
 *  上一个关联的模块路由
 */
@property (nonatomic, weak, readonly) XFRouting *previousRouting;
/**
 *  下一个关联的模块路由
 */
@property (nonatomic, weak, readonly) XFRouting *nextRouting;

/**
 *  父路由
 */
@property (nonatomic, weak, readonly) XFRouting *parentRouting;

/**
 *  当前是否是子路由
 */
@property (nonatomic, assign, getter=isSubRoute) BOOL subRoute;

/**
 *  子路由
 */
@property (nonatomic, strong, readonly) NSMutableArray<XFRouting *> *subRoutes;

/**
 *  添加子路由
 *
 *  @param subRouting       子路由
 *  @param asChildInterface 作为子视图并管理生命周期
 *
 *  @return 视图
 */
- (__kindof id<XFUserInterfacePort>)addSubRouting:(XFRouting *)subRouting asChildInterface:(BOOL)asChildInterface;

/**
 *  获得当前真实存在的视图
 *
 *  @return 视图
 */
- (__kindof id<XFUserInterfacePort>)realInterface;
/**
 *  获得包装当前视图的导航
 *
 *  @return 导航
 */
- (__kindof UINavigationController *)realNavigator;

/**
 *  在主窗口显示第一个视图
 *
 *  @param mainWindow             主窗口
 */
- (void)showRootActivityOnWindow:(UIWindow *)mainWindow;


/**
 *  推入一个新的路由
 *
 *  @param nextRouting  下一个路由
 *  @param intentData   意图数据（没有可以传nil）
 */
- (void)pushRouting:(XFRouting *)nextRouting intent:(id)intentData;

/**
 *  Modal一个新的路由
 *
 *  @param nextRouting  下一个路由
 *  @param intentData   意图数据（没有可以传nil）
 */
- (void)presentRouting:(XFRouting *)nextRouting intent:(id)intentData;

/**
 *  自定义推入路由界面切换
 *
 *  @param nextRouting    下一个路由
 *  @param trasitionBlock 视图切换代码
 *  @param intentData     意图数据（没有可以传nil）
 */
- (void)putRouting:(XFRouting *)nextRouting withTrasitionBlock:(TrasitionBlock)trasitionBlock intent:(id)intentData;

/**
 *  push一个MVx架构里的控制器（注意：它不会被VIPER路由器管理，所以不能对之发VIPER事件通信）
 *
 */
- (void)pushMVxViewController:(UIViewController *)viewController;

/**
 *  present一个MVx架构里的控制器（注意：它不会被VIPER路由器管理，所以不能对之发VIPER事件通信）
 *
 */
- (void)presentMVxViewController:(UIViewController *)viewController;

@end
