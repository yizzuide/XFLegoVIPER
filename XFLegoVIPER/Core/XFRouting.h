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


@interface XFRouting : NSObject <XFWireFramePort>

/**
 *  上一个关联的模块路由
 */
@property (nonatomic, weak) XFRouting *previousRouting;
/**
 *  下一个关联的模块路由
 */
@property (nonatomic, weak) XFRouting *nextRouting;

/**
 *  获得UI事件处理层（Presenter）
 */
@property (nonatomic, weak) id<XFUIOperatorPort> uiOperator;


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
 *  获得当前真实存在的视图
 *
 *  @return 视图
 */
- (id<XFUserInterfacePort>)realInterface;
/**
 *  获得包装当前视图的导航
 *
 *  @return 导航
 */
- (UINavigationController *)realNavigator;

/**
 *  在主窗口显示第一个视图
 *
 *  @param mainWindow             主窗口
 *  @param isNavigationControllor 是否是导航控制器
 */
- (void)showRootActivityOnWindow:(UIWindow *)mainWindow isNavigationControllor:(BOOL)isNavigationControllor;


/**
 *  推入一个新的路由界面
 *
 *  @param nextRouting  下一个路由
 *  @param intentData   意图数据
 */
- (void)pushRouting:(XFRouting *)nextRouting intent:(id)intentData;

/**
 *  Modal一个新的路由界面
 *
 *  @param nextRouting  下一个路由
 *  @param intentData   意图数据
 */
- (void)presentRouting:(XFRouting *)nextRouting intent:(id)intentData;

/**
 *  自定义推入路由界面切换
 *
 *  @param nextRouting    下一个路由
 *  @param trasitionBlock 视图切换代码
 *  @param intentData     意图数据
 */
- (void)addRouting:(XFRouting *)nextRouting withTrasitionBlock:(void(^)())trasitionBlock intent:(id)intentData;


/**
 *  自定义移除路由界面
 *
 *  @param trasitionBlock 视图切换代码
 */
- (void)removeRoutingWithTrasitionBlock:(void(^)())trasitionBlock;

@end
