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
 *  上一个关联的模块切换管理者
 */
@property (nonatomic, weak) XFRouting *previousRouting;
/**
 *  下一个关联的模块切换管理者
 */
@property (nonatomic, weak) XFRouting *nextRouting;

/**
 *  获得UI交互者
 */
@property (nonatomic, weak) id<XFUIOperatorPort> uiOperator;


/**
 *  组装当前探路者
 *
 *  @return 探路者
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
 *  获得包装视图的导航
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
 *  推入一个新视图
 *
 *  @param nextRouting  下一个路由
 *  @param intentData   意图数据
 */
- (void)pushRouting:(XFRouting *)nextRouting intent:(id)intentData;

/**
 *  modal一个新视图
 *
 *  @param nextRouting  下一个路由
 *  @param intentData   意图数据
 */
- (void)presentRouting:(XFRouting *)nextRouting intent:(id)intentData;

/**
 *  自定义推入视图切换
 *
 *  @param nextRouting    下一个Routing
 *  @param trasitionBlock 视图切换代码
 *  @param intentData     意图数据
 */
- (void)addRouting:(XFRouting *)nextRouting withTrasitionBlock:(void(^)())trasitionBlock intent:(id)intentData;


/**
 *  自定义移除视图切换
 *
 *  @param trasitionBlock 视图切换代码
 */
- (void)removeRoutingWithTrasitionBlock:(void(^)())trasitionBlock;

@end
