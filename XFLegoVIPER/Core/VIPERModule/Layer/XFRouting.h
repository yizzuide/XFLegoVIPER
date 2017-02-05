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
#import "XFLegoMarco.h"
#import "XFUIBus.h"
#import "XFVIPERModuleAssembly.h"
#import "XFVIPERModuleReflect.h"

// 快速获取当前模块视图
#define MainActivity LEGORealUInterface(self.realUInterface)

// 获取一个类的Class
#define XF_Class_(Class) [Class class]

/* --------------------------------- *模块组装* --------------------------------- */
/* ------------------------------ 自定义手动组装方式 ------------------------------ */
// 快速注入模块成分-导航方式
#define XF_InjectModuleWith_Nav(_NavigatorClass_,_ActivityClass_,_PresenterClass_,_InteractorClass_,_DataManagerClass_) \
+ (void)load \
{ \
    [XFVIPERModuleReflect inspectModulePrefixFromClass:self]; \
} \
+ (instancetype)assembleRouting \
{ \
    return [[super routing].assembly buildModulesAssemblyWithActivityClass:_ActivityClass_ \
                                                   navigatorClass:_NavigatorClass_ \
                                                   presenterClass:_PresenterClass_ \
                                                  interactorClass:_InteractorClass_ \
                                                 dataManagerClass:_DataManagerClass_]; \
}

// 快速注入模块成分-子界面方式（全自定义组装常用方式）
#define XF_InjectModuleWith_Act(_ActivityClass_,_PresenterClass_,_InteractorClass_,_DataManagerClass_) \
XF_InjectModuleWith_Nav(nil,_ActivityClass_,_PresenterClass_,_InteractorClass_,_DataManagerClass_)

// 快速注入模块成分-ib方式
#define XF_InjectModuleWith_IB(ibSymbol,_PresenterClass_,_InteractorClass_,_DataManagerClass_) \
+ (void)load \
{ \
    [XFVIPERModuleReflect inspectModulePrefixFromClass:self]; \
} \
+ (instancetype)assembleRouting \
{ \
    return [[super routing].assembly buildModulesAssemblyWithIB:ibSymbol presenterClass:_PresenterClass_ interactorClass:_InteractorClass_ dataManagerClass:_DataManagerClass_]; \
}


/* --------------------------------- 全自动组装方式 --------------------------------- */
// 自动组装模块成分基本方法（不适于直接使用）
#define XF_AutoAssemblyModule(IBSymbol,ShareDataManagerName) \
+ (void)load \
{ \
    [XFVIPERModuleReflect inspectModulePrefixFromClass:self]; \
} \
+ (instancetype)assembleRouting \
{ \
    return [[super routing].assembly autoAssemblyModuleWithNav:nil ibSymbol:IBSymbol shareDataManagerName:ShareDataManagerName]; \
}

// 有共享其它模块DataManager的
#define XF_AutoAssemblyModule_ShareDM(ShareDataManagerName) XF_AutoAssemblyModule(nil,ShareDataManagerName)
// 无共享其它模块DataManager（全自动组装方式中最常用）
#define XF_AutoAssemblyModule_Fast XF_AutoAssemblyModule_ShareDM(nil)

// 自动组装一个IBSymbol的模块成分
#define XF_AutoAssemblyModuleFromIB_ShareDM(IBSymbol,ShareDataManagerName) XF_AutoAssemblyModule(IBSymbol,ShareDataManagerName)
#define XF_AutoAssemblyModuleFromIB(IBSymbol) XF_AutoAssemblyModuleFromIB_ShareDM(IBSymbol,nil)


// 自动组装共享模块
#define XF_AutoAssemblyModuleFromShareModuleName(shareModuleName) \
+ (void)load \
{ \
    [XFVIPERModuleReflect inspectModulePrefixFromClass:self]; \
} \
+ (instancetype)assembleRouting \
{ \
    return [[super routing].assembly autoAssemblyModuleFromShareModuleName:shareModuleName]; \
}
// 自动组装基于本模块成分类型的模块，并共享模块各层给子模块，直接在父路由组装（全自动组装方式中常用）
#define XF_AutoAssemblyModuleForShareShell_Fast XF_AutoAssemblyModuleFromShareModuleName(XF_ModuleNameForSuperRoutingClass)

@interface XFRouting : NSObject <XFWireFramePort>

/**
 *  模块组装器
 */
@property (nonatomic, strong, readonly) XFVIPERModuleAssembly *assembly;
/**
 *  UI总线
 */
@property (nonatomic, strong, readonly) XFUIBus *uiBus;

/**
 *  事件处理层（Presenter）
 */
@property (nonatomic, weak, readonly) __kindof id<XFUIOperatorPort> uiOperator;

/**
 *  上一个关联的模块路由
 */
@property (nonatomic, strong, readonly) __kindof XFRouting *previousRouting;
/**
 *  下一个关联的模块路由
 */
@property (nonatomic, strong, readonly) __kindof XFRouting *nextRouting;

/**
 *  父路由
 */
@property (nonatomic, weak, readonly) __kindof XFRouting *parentRouting;

/**
 *  当前是否是子路由
 */
@property (nonatomic, assign, getter=isSubRoute) BOOL subRoute;

/**
 *  所有子路由
 */
@property (nonatomic, strong, readonly) NSMutableArray<__kindof XFRouting *> *subRoutings;

/**
 *  返回初始路由对象（默认包含路由的组装器、UI总线、Event总线）
 *
 *  @return 路由
 */
+ (instancetype)routing;

/**
 *  从路由组装当前模块各层（这是一个抽象方法，子类必需覆盖实现组装方式）
 *
 *  @return 组装完成的路由
 */
+ (instancetype)assembleRouting;

/**
 *  添加子路由
 *
 *  @param subRouting 子路由
 *  @param asChild    是否自动添加子控制器
 *
 */
- (void)addSubRouting:(XFRouting *)subRouting asChildViewController:(BOOL)asChild;

/**
 *  获得当前真实存在的视图
 *
 *  @return 视图
 */
- (__kindof UIViewController<XFUserInterfacePort> *)realUInterface;

@end
