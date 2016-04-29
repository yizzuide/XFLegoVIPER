//
//  XFWireframe.h
//  VIPERGem
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFWireFrameProt.h"

@protocol XFUIOperatorProt;
@class XFActivity;

@interface XFRouting : NSObject <XFWireFrameProt>

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
@property (nonatomic, weak) id<XFUIOperatorProt> uiOperator;


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
 *
 *  @return Routing
 */
- (instancetype)buildModulesAssemblyWithActivityClass:(Class)activityClass
                                                  presenterClass:(Class)perstentClass
                                                 interactorClass:(Class)interactorClass;
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
                                      interactorClass:(Class)interactorClass;
/**
 *  获得当前真实存在的视图
 *
 *  @return 视图
 */
- (XFActivity *)realInterface;
/**
 *  获得包装视图的导航
 *
 *  @return 导航
 */
- (UINavigationController *)realNavigator;
/**
 *  在主窗口显示第一个视图
 *
 *  @param mainWindow 主窗口
 */
- (void)showRootActivityOnWindow:(UIWindow *)mainWindow;

/**
 *  自定义推入视图切换
 */
- (void)pushRoutingWithTrasitionBlock:(void(^)())trasitionBlock intent:(id)intentDat;

/**
 *  自定义移除视图切换
 */
- (void)popRoutingWithTrasitionBlock:(void(^)())trasitionBlock;

@end
