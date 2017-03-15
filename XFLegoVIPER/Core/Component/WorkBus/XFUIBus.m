//
//  XFUIBus.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFUIBus.h"
#import "XFControllerFactory.h"
#import "XFComponentRoutable.h"
#import "UIViewController+XFLego.h"
#import "XFComponentManager.h"
#import "NSObject+XFLegoInvokeMethod.h"
#import "XFURLRoutePlug.h"
#import "XFComponentHandlerMatcher.h"
#import "UIViewController+ComponentBridge.h"
#import "XFComponentReflect.h"

// 快速匹配组件处理器宏
#define MatchedComponentHandler(_component) Class<XFComponentHandlerPlug> matchedComponentHandler = [XFComponentReflect componentHandlerForComponent:(id)_component];

@interface XFUIBus ()

/**
 *  可运行组件
 */
@property (nonatomic, weak, readwrite) __kindof id<XFComponentRoutable> componentRoutable;

/**
 *  视图
 */
@property (nonatomic, strong) UIViewController *currentUInterface;
/**
 *   导航
 */
@property (nonatomic, strong) UINavigationController *currentNavigator;
/**
 *  当前组件匹配的组件处理器
 */
@property (nonatomic, assign) Class<XFComponentHandlerPlug> matchedComponentHandler;
@end

@implementation XFUIBus

- (instancetype)init
{
    return [self initWithComponentRoutable:nil];
}

- (instancetype)initWithComponentRoutable:(__kindof id<XFComponentRoutable>)componentRoutable
{
    self = [super init];
    if (self) {
        if (componentRoutable) self.componentRoutable = componentRoutable;
    }
    return self;
}

- (void)setComponentRoutable:(__kindof id<XFComponentRoutable>)componentRoutable
{
    _componentRoutable = componentRoutable;
    // 缓存组件处理器
    MatchedComponentHandler(componentRoutable)
    self.matchedComponentHandler = matchedComponentHandler;
}

#pragma mark - URL组件方式
- (void)openURL:(NSString *)url onWindow:(UIWindow *)mainWindow customCode:(CustomCodeBlock)customCodeBlock
{
    [[LEGOConfig routePlug] open:url transitionBlock:^(NSString *componentName, NSDictionary *params) {
        [self showComponent:componentName onWindow:mainWindow params:params customCode:customCodeBlock];
    }];
}

// 以URL组件式PUSH
- (void)openURLForPush:(NSString *)url customCode:(CustomCodeBlock)customCodeBlock
{
    [[LEGOConfig routePlug] open:url transitionBlock:^(NSString *componentName, NSDictionary *params) {
        [self pushComponent:componentName params:params intent:[self _intentData] customCode:customCodeBlock];
    }];
}

// 以URL组件式Present
- (void)openURLForPresent:(NSString *)url customCode:(CustomCodeBlock)customCodeBlock
{
    [[LEGOConfig routePlug] open:url transitionBlock:^(NSString *componentName, NSDictionary *params) {
        [self presentComponent:componentName params:params intent:[self _intentData] customCode:customCodeBlock];
    }];
}

// 自定义打开一个URL组件
- (void)openURL:(NSString *)url withTransitionBlock:(TransitionBlock)transitionBlock customCode:(CustomCodeBlock)customCodeBlock
{
    [[LEGOConfig routePlug] open:url transitionBlock:^(NSString *componentName, NSDictionary *params) {
        [self putComponent:componentName withTransitionBlock:transitionBlock params:params intent:[self _intentData] customCode:customCodeBlock];
    }];
}

// 通过URL返回组件
+ (id<XFComponentRoutable>)openURLForGetComponent:(NSString *)url
{
    __block id<XFComponentRoutable> subComponent;
    [[LEGOConfig routePlug] open:url transitionBlock:^(NSString *componentName, NSDictionary *params) {
        MatchedComponentHandler(componentName)
        id<XFComponentRoutable> component = [matchedComponentHandler createComponentFromName:componentName];
        UIViewController *nextInterface = [matchedComponentHandler uInterfaceForComponent:component];
        [XFUIBus _transmitURLParams:params nextInterface:nextInterface nextComponent:component];
        subComponent = component;
    }];
    // 添加子组件到容器，为了不妨碍父组件的跟踪功能，使用延后处理
    LEGORunAfter0_015({
        [XFComponentManager addComponent:subComponent enableLog:NO];
    })
    return subComponent;
}

#pragma mark - 组件名切换方式
- (void)showComponent:(NSString *)componentName onWindow:(UIWindow *)mainWindow params:params customCode:(CustomCodeBlock)customCodeBlock
{
    MatchedComponentHandler(componentName)
    // 下一组件
    id<XFComponentRoutable> nextComponent = [matchedComponentHandler component:self.componentRoutable createNextComponentFromName:componentName];
    // 视图
    UIViewController *nextUInterface = [matchedComponentHandler uInterfaceForComponent:nextComponent];
    NSAssert(nextComponent, @"找不到当前组件名的处理组件！");
    // 传递URL参数
    [XFUIBus _transmitURLParams:params nextInterface:nextUInterface nextComponent:nextComponent];
    
    if (customCodeBlock) {
        customCodeBlock(nextUInterface);
    }
    // 显示根组件
    mainWindow.rootViewController = nextUInterface.navigationController ?: nextUInterface;
    [mainWindow makeKeyAndVisible];
    
    // 添加组件到容器
    [XFComponentManager addComponent:nextComponent enableLog:YES];
}

// Modal方式
- (void)presentComponent:(NSString *)componentName params:(NSDictionary *)params intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock
{
    [self putComponent:componentName withTransitionBlock:^(Activity *thisInterface, Activity *nextInterface, TransitionCompletionBlock completionBlock) {
        // 是否有导航控制器
        Activity *nextNewInterface = nextInterface.navigationController ?: nextInterface;
        // 如果当前控制器未被Present
        if (thisInterface.presentingViewController == nil &&
            !thisInterface.isBeingDismissed &&
            thisInterface.view.window) {
        } else { // 查找合适的控制器来Present
            // 根控制器
            UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
            if (rootVC != thisInterface.presentingViewController)
                thisInterface = rootVC;
            // 使用UITabBarController的选中控制器来Present
            else if ([rootVC isKindOfClass:[UITabBarController class]])
                thisInterface = ((UITabBarController *)rootVC).selectedViewController;
        }
        [thisInterface presentViewController:nextNewInterface animated:YES completion:nil];
        completionBlock();
    } params:(NSDictionary *)params intent:intentData customCode:customCodeBlock];
}

- (void)dismissComponent
{
    [self removeComponentWithTransitionBlock:^(Activity *thisInterface, Activity *nextInterface, TransitionCompletionBlock completionBlock) {
        [thisInterface dismissViewControllerAnimated:YES completion:completionBlock];
    }];
}

// PUSH方式
- (void)pushComponent:(NSString *)componentName params:(NSDictionary *)params intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock
{
    [self putComponent:componentName withTransitionBlock:^(Activity *thisInterface, Activity *nextInterface, TransitionCompletionBlock completionBlock) {
        [thisInterface.navigationController pushViewController:nextInterface animated:YES];
        completionBlock();
    } params:(NSDictionary *)params intent:intentData customCode:customCodeBlock];
}

- (void)popComponent
{
    [self removeComponentWithTransitionBlock:^(Activity *thisInterface, Activity *nextInterface, TransitionCompletionBlock completionBlock) {
        [CATransaction begin];
        [CATransaction setCompletionBlock:completionBlock];
        [thisInterface.navigationController popViewControllerAnimated:YES];
        [CATransaction commit];
    }];
}

#pragma mark - 自定义组件切换
- (void)putComponent:(NSString *)componentName withTransitionBlock:(TransitionBlock)transitionBlock params:(NSDictionary *)params intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock {
    MatchedComponentHandler(componentName)
    // 下一组件
    id<XFComponentRoutable> nextComponent = [matchedComponentHandler component:self.componentRoutable createNextComponentFromName:componentName];
    // 视图
    UIViewController *nextUInterface = [matchedComponentHandler uInterfaceForComponent:nextComponent];
    NSAssert(nextComponent, @"找不到当前组件名的处理组件！");
    
    // 绑定组件关系
    [self _flowToNextComponent:nextComponent];
    
    // 传递URL参数
    [XFUIBus _transmitURLParams:params nextInterface:nextUInterface nextComponent:nextComponent];
    
    // 传递组件意图对象
    if (intentData && [nextComponent respondsToSelector:@selector(setComponentData:)]) {
        [nextComponent setComponentData:intentData];
    }
    
    // 移除当前组件焦点
    if ([self.componentRoutable respondsToSelector:@selector(componentWillResignFocus)]) {
        [self.componentRoutable componentWillResignFocus];
    }
    
    // 清空意图数据
    if ([self.componentRoutable respondsToSelector:@selector(intentData)]) {
        self.componentRoutable.intentData = nil;
    }
    //  调用自定义代码
    if (customCodeBlock) {
        customCodeBlock(nextUInterface);
    }
    if (!transitionBlock) return;
    Activity *thisInterface = [self.matchedComponentHandler uInterfaceForComponent:self.componentRoutable];
    dispatch_async(dispatch_get_main_queue(), ^{
        // 执行切换组件
        transitionBlock(thisInterface, nextUInterface, ^{
            // 下一个组件获得焦点
            if ([nextComponent respondsToSelector:@selector(componentWillBecomeFocus)]) {
                [nextComponent componentWillBecomeFocus];
            }
        });
    });
    // 添加组件
    [XFComponentManager addComponent:nextComponent enableLog:YES];
}

// 移除当前Routing
- (void)removeComponentWithTransitionBlock:(TransitionBlock)transitionBlock
{
    // 设置为手动代码移除方式
    UIViewController *uInterface = [self.matchedComponentHandler uInterfaceForComponent:self.componentRoutable];
    [uInterface invokeMethod:@"setPoppingProgrammatically:" param:[NSNumber numberWithBool:YES]];
    // 开始移除当前路由并切换
    [self xfLego_implicitRemoveComponentWithTransitionBlock:transitionBlock];
}

- (void)xfLego_implicitRemoveComponentWithTransitionBlock:(TransitionBlock)transitionBlock
{
    if (!self.componentRoutable) return;
    // 调用组件处理器的开始移除组件方法
    [self.matchedComponentHandler willRemoveComponent:self.componentRoutable];
    
    if ([self.componentRoutable respondsToSelector:@selector(componentWillResignFocus)]) {
        [self.componentRoutable componentWillResignFocus];
    }
    if (!transitionBlock) return;
    Activity *thisInterface = [self.matchedComponentHandler uInterfaceForComponent:self.componentRoutable];
    transitionBlock(thisInterface,nil,^{
        // 上一个组件获得焦点
        if ([self.componentRoutable.fromComponentRoutable respondsToSelector:@selector(componentWillBecomeFocus)]) {
            [self.componentRoutable.fromComponentRoutable componentWillBecomeFocus];
        }
        // 如果组件符合回传数据的条件
        if ([XFUIBus _canBackDataWithComponent:self.componentRoutable]) {
            [self.componentRoutable.fromComponentRoutable onNewIntent:self.componentRoutable.intentData];
        }
        // 调用组件处理器的释放组件方法
        [self.matchedComponentHandler willReleaseComponent:self.componentRoutable];
        // 解除组件关系链
        [self.componentRoutable.fromComponentRoutable setValue:nil forKey:@"nextComponentRoutable"];
        [self.componentRoutable setValue:nil forKey:@"fromComponentRoutable"];
        // 从组件容器里移除
        [XFComponentManager removeComponent:self.componentRoutable];
    });
}

// 处理URL参数
+ (void)_transmitURLParams:(NSDictionary *)params nextInterface:(UIViewController *)nextInterface nextComponent:(__kindof id<XFComponentRoutable>)nextComponent
{
    if (!params.count) return;
    
    NSArray<NSString *> *behaviorParams = @[@"nav",@"navC",@"navTitle"];
    
    // 检测是否有行为参数
    BOOL hasBehaviorParam = NO;
    for (NSString *key in behaviorParams) {
        if(params[key]){
            hasBehaviorParam = YES;
            break;
        }
    }
    if (hasBehaviorParam) {
        // 装配导航控制器
        NSString *navName = params[behaviorParams[XF_Index_First]]; // 使用前缀
        NSString *navFullClassName = params[behaviorParams[XF_Index_Second]]; // 全类名
        UINavigationController *nav;
        if (navName.length) {
            nav = [XFControllerFactory createNavigationControllerFromPrefixName:navName withRootController:nextInterface];
        }else if(navFullClassName.length) {
            nav = [XFControllerFactory createNavigationControllerFromClassName:navFullClassName withRootController:nextInterface];
        }
        
        // 设置导航引用
        if (nav) {
            if ([XFComponentReflect isVIPERModuleComponent:nextComponent]) { // 如果是VIPER模块组件
                [[[nextComponent valueForKey:@"routing"] uiBus] setNavigator:nav];
            } else { // 其它组件
                [[nextComponent uiBus] setNavigator:nav];
            }
        }
        
        // 导航标题
        NSString *navTitle = params[behaviorParams[XF_Index_Third]];
        if (navTitle) {
            nextInterface.navigationItem.title = navTitle;
        }
        
        
        // 移除行为参数
        NSMutableDictionary *mParams = [params mutableCopy];
        for (NSString *behaviorParam in behaviorParams) {
            if ([mParams objectForKey:behaviorParam]) {
                [mParams removeObjectForKey:behaviorParam];
            }
        }
        params = mParams;
    }
    
    // 判断是否要传递URL参数
    if (params.count && [nextComponent respondsToSelector:@selector(setURLParams:)]) {
        [nextComponent setURLParams:params];
    }
}

// 能否返回组件意图数据
+ (BOOL)_canBackDataWithComponent:(id<XFComponentRoutable>)componentRoutable
{
    return [componentRoutable respondsToSelector:@selector(intentData)] &&
    componentRoutable.intentData &&
    componentRoutable.fromComponentRoutable &&
    [componentRoutable.fromComponentRoutable respondsToSelector:@selector(onNewIntent:)];
}

// 获取组件意图数据
- (id)_intentData
{
    id intentData;
    if ([self.componentRoutable respondsToSelector:@selector(intentData)]) {
        intentData = self.componentRoutable.intentData;
    }
    return intentData;
}

// 绑定组件关系
- (void)_flowToNextComponent:(__kindof id<XFComponentRoutable>)nextComponent
{
    // 关联下一个组件
     [self.componentRoutable setValue:nextComponent forKey:@"nextComponentRoutable"];
    // 关联上一个组件
    [nextComponent setValue:self.componentRoutable forKey:@"fromComponentRoutable"];
}

- (void)setUInterface:(UIViewController *)uInterface {
    self.currentUInterface = uInterface;
}

- (void)setNavigator:(UINavigationController *)navigator
{
    self.currentNavigator = navigator;
}

- (UIViewController *)uInterface
{
    return self.currentUInterface;
}

// 移除对视图的引用
- (void)xfLego_destoryUInterfaceRef
{
    self.currentUInterface = nil;
    self.currentNavigator = nil;
}
@end
