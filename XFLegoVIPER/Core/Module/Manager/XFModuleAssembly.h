//
//  XFModuleAssembly.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XFRouting;
@interface XFModuleAssembly : NSObject

/**
 *  初始化方法
 *
 *  @param fromRouting 路由
 *
 *  @return XFModuleAssembly
 */
- (instancetype)initWithFromRouting:(XFRouting *)fromRouting NS_DESIGNATED_INITIALIZER;

/**
 *  通过Nav或Nib快速组建一个模块
 *
 *  @param navName               导航
 *  @param ibSymbol              ibSymbol
 *  @param shareDataManagerName  数据管理名
 *
 *  @return Routing
 */
- (__kindof XFRouting *)autoAssemblyModuleWithNav:(NSString *)navName ibSymbol:(NSString *)ibSymbol shareDataManagerName:(NSString *)shareDataManagerName;
/**
 *  通过自定义项目前辍的Nav名快速组建一个模块
 *
 *  @return Routing
 */
- (__kindof XFRouting *)autoAssemblyModuleWithPrefixNav;

/**
 *  基于其它模块的视图、事件、数据处理、数据管理层类型创建一个模块
 *
 *  @param moduleName 共享的模块名
 *
 *  @return Routing
 */
- (__kindof XFRouting *)autoAssemblyModuleFromShareModuleName:(NSString *)moduleName;

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
- (__kindof XFRouting *)buildModulesAssemblyWithActivityClass:(Class)activityClass
                                       navigatorClass:(Class)navigatorClass
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
