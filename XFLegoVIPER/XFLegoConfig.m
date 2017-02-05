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
#import "XFVIPERModuleHandler.h"

@implementation XFLegoConfig
{
    // 全局debug配置
    BOOL _allowDebug;
    // 类前辍
    NSString *_classPrefix;
    // URL路由插件
    Class<XFURLRoutePlug> _routePlug;
    // 组件处理器插件集合
    NSMutableArray<Class<XFComponentHandlerPlug>> *_componentHanderPlugs;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _componentHanderPlugs = @[].mutableCopy;
    }
    return self;
}

// 使用共享实例
static XFLegoConfig *instance_;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[XFLegoConfig alloc] init];
    });
    return instance_;
}

+ (instancetype)defaultConfig {
    XFLegoConfig *legoConfig = [XFLegoConfig shareInstance];
    // 设置默认解析URL路由插件
    [legoConfig setRoutePlug:[XFURLRoute class]];
    // 添加组件处理器
    [legoConfig->_componentHanderPlugs addObject:[XFVIPERModuleHandler class]]; // VIPER模块组件处理器
    [legoConfig->_componentHanderPlugs addObject:[XFControllerHandler class]]; // 控制器组件处理器
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
    return self->_classPrefix;
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
    // 放在倒数第二个
    [self->_componentHanderPlugs insertObject:componentHanderPlug atIndex:_componentHanderPlugs.count - 1];
    return self;
}

- (NSArray<Class<XFComponentHandlerPlug>> *)allComponentHanderPlugs
{
    return self->_componentHanderPlugs;
}

@end
