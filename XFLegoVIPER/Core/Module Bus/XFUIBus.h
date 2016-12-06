//
//  XFFluctuator.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Activity __kindof UIViewController

// 使用组件名显示根组件
#define XF_ShowRootComponent2Window_(ComponentName,ExecuteCode) \
[[[XFUIBus alloc] init] showComponent:ComponentName onWindow:self.window customCode:^(Activity *nextInterface) { \
    ExecuteCode \
}];
// 快速显示一个根组件
#define XF_ShowRootComponent2Window_Fast(ComponentName) \
XF_ShowRootComponent2Window_(ComponentName,{})

// 使用URL方式显示根组件
#define XF_ShowURLComponent2Window_(url,ExecuteCode) \
[[[XFUIBus alloc] init] openURL:url onWindow:self.window customCode:^(Activity *nextInterface) { \
    ExecuteCode \
}];
// 快速显示一个根组件
#define XF_ShowURLComponent2Window_Fast(url) \
XF_ShowURLComponent2Window_(url,{})

@class XFRouting;
typedef void(^TransitionBlock)(Activity *thisInterface, Activity *nextInterface);
typedef void(^CustomCodeBlock) (Activity *nextInterface);


@interface XFUIBus : NSObject

/**
 *  当前路由
 */
@property (nonatomic, weak) XFRouting *fromRouting;

/**
 *  初始化方法
 *
 *  @param fromRouting 路由
 *
 *  @return XFFluctuator
 */
- (instancetype)initWithFromRouting:(XFRouting *)fromRouting;

/**
 *  显示一个组件在窗口
 *
 *  @param url             URL
 *  @param mainWindow      窗口
 *  @param customCodeBlock 自定义配制代码Block
 */
- (void)openURL:(NSString *)url onWindow:(UIWindow *)mainWindow customCode:(CustomCodeBlock)customCodeBlock;

/**
 *  以URL组件方式Push
 *
 *  @param url              URL
 *  @param customCodeBlock  自定义配制代码Block
 */
- (void)openURLForPush:(NSString *)url customCode:(CustomCodeBlock)customCodeBlock;
/**
 *  以URL组件方式Present
 *
 *  @param url              URL
 *  @param customCodeBlock  自定义配制代码Block
 */
- (void)openURLForPresent:(NSString *)url customCode:(CustomCodeBlock)customCodeBlock;
/**
 *  自定义打开一个URL组件
 *
 *  @param url             URL
 *  @param trasitionBlock  视图切换代码
 *  @param customCodeBlock 自定义配制代码Block
 */
- (void)openURL:(NSString *)url withTransitionBlock:(TransitionBlock)trasitionBlock customCode:(CustomCodeBlock)customCodeBlock;


/**
 *  显示一个组件在窗口
 *
 *  @param componentName        组件名
 *  @param mainWindow           窗口
 *  @param customCodeBlock      自定义配制代码Block
 */
- (void)showComponent:(NSString *)componentName onWindow:(UIWindow *)mainWindow customCode:(CustomCodeBlock)customCodeBlock;

/**
 *  推入一个模块
 *
 *  @param componentName        组件名
 *  @param intentData           意图数据（没有可以传nil）
 *  @param customCodeBlock      自定义配制代码Block
 */
- (void)pushComponent:(NSString *)componentName intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock;

/**
 *  推出当前视图(注意：返回到上一个界面的意图数据在需要当前模块的Presenter里设置intentData属性）
 */
- (void)pop;

/**
 *  Modal一个组件
 *
 *  @param componentName        组件名
 *  @param intentData           意图数据（没有可以传nil）
 *  @param customCodeBlock      自定义配制代码Block
 */
- (void)presentComponent:(NSString *)componentName intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock;

/**
 *  dismiss当前视图(注意：返回到上一个界面的意图数据需要在当前模块的Presenter里设置intentData属性）
 */
- (void)dismiss;

/**
 *  自定义展示一个界面
 *
 *  @param componentName        下一个路由
 *  @param trasitionBlock       视图切换代码
 *  @param intentData           意图数据（没有可以传nil）
 *  @param customCodeBlock      自定义配制代码Block
 */
- (void)putComponent:(NSString *)componentName withTransitionBlock:(TransitionBlock)trasitionBlock intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock;

/**
 *  自定义移除一个界面
 *
 *  @param trasitionBlock 视图切换代码
 */
- (void)removeWithTransitionBlock:(TransitionBlock)trasitionBlock;

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
