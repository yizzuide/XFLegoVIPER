//
//  XFLegoConfig.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/23.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "XFLegoConfig.h"
#import "XFUIBus.h"
#import "XFURLRoute.h"
#import "XFControllerHandler.h"
#import "XFComponentManager.h"
#import "XFPipe.h"

#define XFVIPERModuleHandlerClassName @"XFVIPERModuleHandler"
#define XFApplicationEmitterClassName @"XFApplicationEmitter"

@implementation XFLegoConfig
{
    // 全局debug配置
    BOOL _allowDebug;
    // 类前辍
    NSString *_classPrefix;
    
    NSArray *_classPrefixList;
    // URL路由插件
    Class<XFURLRoutePlug> _routePlug;
    // 组件处理器插件集合
    NSMutableArray<Class<XFComponentHandlerPlug>> *_componentHanderPlugs;
    NSMutableArray<Class<XFEmitterPlug>> *_emitterPlugs;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _componentHanderPlugs = @[].mutableCopy;
        _componentHanderPlugs = @[].mutableCopy;
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [super allocWithZone:zone];
    });
    return __instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return __instance;
}

// 使用共享实例
static XFLegoConfig *__instance;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[XFLegoConfig alloc] init];
    });
    return __instance;
}

+ (instancetype)defaultConfig {
    XFLegoConfig *legoConfig = [XFLegoConfig shareInstance];
    // 设置默认解析URL路由插件
    [legoConfig setRoutePlug:[XFURLRoute class]];
    // 添加组件处理器
    Class viperHandlerClass = NSClassFromString(XFVIPERModuleHandlerClassName);
    if (viperHandlerClass) {
        [legoConfig->_componentHanderPlugs addObject:viperHandlerClass];// VIPER模块组件处理器
    }
    [legoConfig->_componentHanderPlugs addObject:[XFControllerHandler class]]; // 控制器组件处理器
    
    // 添加默认事件发射器（由于没有导入头文件，所以不需要可以移除这个扩展：/Extension/Emitter）
    Class emitterClass = NSClassFromString(XFApplicationEmitterClassName);
    if (emitterClass) {
        [legoConfig addEmitterPlug:emitterClass];
    }
    
    return legoConfig;
}

- (instancetype)enableLog {
    self->_allowDebug = YES;
    return self;
}

- (BOOL)canDebugLog
{
    return self->_allowDebug;
}

- (instancetype)setClassPrefix:(NSString *)prefix
{
    self->_classPrefix = prefix;
    return self;
}

- (NSString *)classPrefix
{
    // OC模块组件请设置前辍
    if (self->_classPrefix) {
        return self->_classPrefix;
    }
    return nil;
}

- (instancetype)setClassPrefixList:(NSArray *)prefixList
{
    self->_classPrefixList = prefixList;
    // 如果统一的类前辍变量没有设置，并且前辍列表里只有一个前辍，对旧变量进行填充
    if (!self->_classPrefix && prefixList && prefixList.count == 1) {
        self->_classPrefix = prefixList.firstObject;
    }
    return self;
}

- (NSArray *)classPrefixList
{
    return self->_classPrefixList;
}

- (NSString *)swiftNamespace
{
    NSString *appName = [NSBundle mainBundle].infoDictionary[@"CFBundleName"];
    NSString *namespace = [NSString stringWithFormat:@"%@.",appName];
    return namespace;
}

#pragma mark - 插件
- (instancetype)setRoutePlug:(Class<XFURLRoutePlug>)routePlugClass {
    self->_routePlug = routePlugClass;
    return self;
}

- (Class<XFURLRoutePlug>)routePlug
{
    return self->_routePlug;
}

- (instancetype)addComponentHanderPlug:(Class<XFComponentHandlerPlug>)componentHanderPlug
{
    // 放在倒数第二个，针对MVC组件通过控制器就能识别的问题
    [self->_componentHanderPlugs insertObject:componentHanderPlug atIndex:_componentHanderPlugs.count - 1];
    return self;
}

- (NSArray<Class<XFComponentHandlerPlug>> *)allComponentHanderPlugs
{
    return self->_componentHanderPlugs;
}

- (instancetype)addEmitterPlug:(Class<XFEmitterPlug>)emitterPlug
{
    [self->_emitterPlugs addObject:emitterPlug];
    id<XFEmitterPlug> emitter = [[(Class)emitterPlug alloc] init];
    [[XFPipe shareInstance] addEmitter:emitter];
    return self;
}

@end
