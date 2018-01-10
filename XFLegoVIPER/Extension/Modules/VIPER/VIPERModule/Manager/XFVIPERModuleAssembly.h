//
//  XFVIPERModuleReflect.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XFRouting;
NS_ASSUME_NONNULL_BEGIN
@interface XFVIPERModuleAssembly : NSObject

/**
 *  初始化方法
 *
 *  @param fromRouting 路由
 *
 *  @return XFVIPERModuleReflect
 */
- (instancetype)initWithFromRouting:(XFRouting *)fromRouting;

/**
 *  通过Nav或Nib快速组建一个模块
 *
 *  @param ibSymbol              ibSymbol
 *  @param shareDataManagerName  数据管理名
 *
 *  @return Routing
 */
- (__kindof XFRouting *)autoAssemblyModuleWithIbSymbol:(nullable NSString *)ibSymbol shareDataManagerName:(nullable NSString *)shareDataManagerName;

/**
 *  自动组装当前模块（给swift用的接口）
 */
- (void)autoAssemblyModule;

/**
 *  基于其它模块的视图、事件、数据处理、数据管理层类型创建一个模块
 *
 *  @param moduleName 共享的模块名
 *
 *  @return Routing
 */
- (__kindof XFRouting *)autoAssemblyModuleFromShareModuleName:(NSString *)moduleName;

/**
 *  自动组装共享子模块（给swift用的接口）
 */
- (void)autoAssemblyShareModule;

/**
 *  构建关系层
 *
 *  @param activityClass    视图层
 *  @param perstentClass    交互层
 *  @param interactorClass  业务层
 *
 *  @return Routing
 */
- (__kindof XFRouting *)buildModulesAssemblyWithActivityClass:(Class)activityClass
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
- (__kindof XFRouting *)buildModulesAssemblyWithIB:(NSString *)ibSymbol
                           presenterClass:(Class)perstentClass
                          interactorClass:(Class)interactorClass
                         dataManagerClass:(Class)dataManagerClass;
@end
NS_ASSUME_NONNULL_END
