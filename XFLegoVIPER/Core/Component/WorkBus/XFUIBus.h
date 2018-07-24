//
//  XFUIBus.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFURLParse.h"

#define Activity __kindof UIViewController

/* ---------------- 显示根组件 ---------------- */
// 使用组件名显示根组件
#define XF_ShowRootComponent2Window_(ComponentName,ExecuteCode) \
[[[XFUIBus alloc] init] showComponent:ComponentName onWindow:self.window params:nil customCode:^(Activity *nextInterface) { \
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


/* --------------------------------- *组件的跳转* --------------------------------- */
/* --------------------------------- 组件名方式 --------------------------------- */
// 切换组件（不推荐直接使用）
#define XF_PUT_Component_(method,ComponentName,ExecuteCode) \
[self.uiBus method:ComponentName  params:nil intent:self.uiOperator.intentData customCode:^(Activity *nextInterface) { \
    ExecuteCode \
}];
// Push一个组件宏
#define XF_PUSH_Component_(ComponentName,ExecuteCode) \
XF_PUT_Component_(pushComponent,ComponentName,ExecuteCode)
#define XF_PUSH_Component_Fast(ComponentName) \
XF_PUSH_Component_(ComponentName,{})
// Present一个组件宏
#define XF_Present_Component_(ComponentName,ExecuteCode) \
XF_PUT_Component_(presentComponent,ComponentName,ExecuteCode)
#define XF_Present_Component_Fast(ComponentName) \
XF_Present_Component_(ComponentName,{})

/* --------------------------------- URL组件方式 --------------------------------- */
// 切换URL组件（不推荐直接使用）
#define XF_PUT_URLComponent_(method,urlString,ExecuteCode) \
[self.uiBus method:urlString customCode:^(Activity *nextInterface) { \
    ExecuteCode \
}];
// Push一个URL组件
#define XF_PUSH_URLComponent_(urlString,ExecuteCode) \
XF_PUT_URLComponent_(openURLForPush,urlString,ExecuteCode)
#define XF_PUSH_URLComponent_Fast(urlString) XF_PUSH_URLComponent_(urlString,{})
// Present一个URL组件
#define XF_Present_URLComponent_(urlString,ExecuteCode) \
XF_PUT_URLComponent_(openURLForPresent,urlString,ExecuteCode)
#define XF_Present_URLComponent_Fast(urlString) XF_Present_URLComponent_(urlString,{})


// 从快速@{}字典对象组装URL参数
#define XF_URL_(urlPath,params) \
([NSString stringWithFormat:@"%@?%@",urlPath,[XFURLParse stringFromDictionary:params]])


NS_ASSUME_NONNULL_BEGIN
typedef void(^TransitionCompletionBlock)();
typedef void(^TransitionBlock)(Activity *thisInterface,  Activity * _Nullable nextInterface,TransitionCompletionBlock completionBlock);
typedef void(^CustomCodeBlock) (Activity *nextInterface);

@protocol XFComponentRoutable,XFURLRoutePlug,XFComponentHandlerPlug;
@interface XFUIBus : NSObject

/**
 *  可运行组件
 */
@property (nonatomic, weak, readonly) __kindof id<XFComponentRoutable> componentRoutable;

/**
 *  初始化方法
 *
 *  @param componentRoutable 可运行组件
 *
 *  @return XFUIBus
 */
- (instancetype)initWithComponentRoutable:(__kindof id<XFComponentRoutable>)componentRoutable NS_DESIGNATED_INITIALIZER;

/**
 *  显示一个组件在窗口
 *
 *  @param url             URL
 *  @param mainWindow      窗口
 *  @param customCodeBlock 自定义配制代码Block
 */
- (void)openURL:(NSString *)url onWindow:(UIWindow *)mainWindow customCode:(nullable CustomCodeBlock)customCodeBlock;

/**
 *  以URL组件方式Push
 *
 *  @param url              URL
 *  @param customCodeBlock  自定义配制代码Block
 */
- (void)openURLForPush:(NSString *)url customCode:(nullable CustomCodeBlock)customCodeBlock;
/**
 *  以URL组件方式Present
 *
 *  @param url              URL
 *  @param customCodeBlock  自定义配制代码Block
 */
- (void)openURLForPresent:(NSString *)url customCode:(nullable CustomCodeBlock)customCodeBlock;
/**
 *  自定义打开一个URL组件
 *
 *  @param url             URL
 *  @param transitionBlock  视图切换代码
 *  @param customCodeBlock 自定义配制代码Block
 */
- (void)openURL:(NSString *)url withTransitionBlock:(TransitionBlock)transitionBlock customCode:(nullable CustomCodeBlock)customCodeBlock;

/**
 *  通过URL获取一个组件
 *
 *  @param url URL
 *
 *  @return 组件
 */
+ (id<XFComponentRoutable>)openURLForGetComponent:(NSString *)url;
/**
 *  通过URL获取一个组件视图
 *
 *  @param url URL
 *
 *  @return 视图
 */
+ (__kindof UIViewController *)openURLForGetUInterface:(NSString *)url;


/**
 *  显示一个组件在窗口
 *
 *  @param componentName        组件名
 *  @param mainWindow           窗口
 *  @param params               URL参数
 *  @param customCodeBlock      自定义配制代码Block
 */
- (void)showComponent:(NSString *)componentName onWindow:(UIWindow *)mainWindow params:(nullable NSDictionary *)params customCode:(nullable CustomCodeBlock)customCodeBlock;

/**
 *  推入一个模块
 *
 *  @param componentName        组件名
 *  @param params               URL参数
 *  @param intentData           意图数据（没有可以传nil）
 *  @param customCodeBlock      自定义配制代码Block
 */
- (void)pushComponent:(NSString *)componentName params:(nullable NSDictionary *)params intent:(nullable id)intentData customCode:(nullable CustomCodeBlock)customCodeBlock;

/**
 *  推出当前视图(注意：返回到上一个界面的意图数据在需要当前模块的Presenter里设置intentData属性）
 */
- (void)popComponent;

/**
 * 自定义pop组件到任意上级组件
 * @param componentName        上级组件名 注：如果只pop到上一级可传nil
 * @param animated             是否要动画
 */
- (void)popComponent:(nullable NSString *)componentName animated:(BOOL)animated;

/**
 *  Modal一个组件
 *
 *  @param componentName        组件名
 *  @param params               URL参数
 *  @param intentData           意图数据（没有可以传nil）
 *  @param customCodeBlock      自定义配制代码Block
 */
- (void)presentComponent:(NSString *)componentName params:(nullable NSDictionary *)params intent:(nullable id)intentData customCode:(nullable CustomCodeBlock)customCodeBlock;

/**
 *  dismiss当前视图(注意：返回到上一个界面的意图数据需要在当前模块的Presenter里设置intentData属性）
 */
- (void)dismissComponent;

/**
 *  自定义展示一个界面
 *
 *  @param componentName        下一个路由
 *  @param transitionBlock      视图切换代码
 *  @param params               URL参数
 *  @param intentData           意图数据（没有可以传nil）
 *  @param customCodeBlock      自定义配制代码Block
 */
- (void)putComponent:(NSString *)componentName withTransitionBlock:(TransitionBlock)transitionBlock params:(nullable NSDictionary *)params intent:(nullable id)intentData customCode:(nullable CustomCodeBlock)customCodeBlock;

/**
 *  自定义移除一个界面
 *
 *  @param transitionBlock 自定义切换代码
 */
- (void)removeComponentWithTransitionBlock:(TransitionBlock)transitionBlock;
/**
 *  用于框架扩展模块组件调用的隐式移除组件
 *
 *  @param transitionBlock 自定义切换代码
 */
- (void)xfLego_implicitRemoveComponentWithTransitionBlock:(TransitionBlock)transitionBlock;

/**
 *  设置导航
 *
 *  @param navigator 导航
 */
- (void)setNavigator:(UINavigationController *)navigator;
/**
 *  当前视图
 */
@property (NS_NONATOMIC_IOSONLY, strong, nullable) UIViewController *uInterface;
/**
 *  销毁当前组件UI总线对视图的强引用
 */
- (void)xfLego_destoryUInterfaceRef;
@end
NS_ASSUME_NONNULL_END
