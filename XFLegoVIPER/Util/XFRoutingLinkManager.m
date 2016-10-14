//
//  XFRoutingLinkManager.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/9/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFRoutingLinkManager.h"
#import "XFLegoMarco.h"
#import "NSObject+XFLegoInvokeMethod.h"

@implementation XFRoutingLinkManager

static NSMapTable *_mapTable;
static NSMutableArray *_keyArr;

+ (void)initialize
{
    if (self == [XFRoutingLinkManager class]) {
        _mapTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
       _keyArr = [NSMutableArray array];
    }
}

#pragma mark - 模块管理
+ (void)addRouting:(XFRouting *)routing {
    NSString *key = _prefix ? [self _moudleNameForRouting:routing] : NSStringFromClass([routing class]);
    [_mapTable setObject:routing forKey:key];
    [_keyArr addObject:key];
}

+ (void)removeRouting:(XFRouting *)routing {
    NSString *key = _prefix ? [self _moudleNameForRouting:routing] : NSStringFromClass([routing class]);
    [_mapTable removeObjectForKey:key];
    [_keyArr removeObject:key];
}

#pragma mark - 模块通信
+ (void)sendEventName:(NSString *)eventName intentData:(id)intentData forMoudlesName:(NSArray<NSString *> *)moudlesName
{
    for (NSString *moudleName in moudlesName) {
        // 找到对应模块路由
        XFRouting *routing = [self findRoutingForMoudleName:moudleName];
        // 通知路由发送事件
        SuppressPerformSelectorLeakWarning (
            [routing performSelector:NSSelectorFromString(@"_sendEventName:intentData:") withObject:eventName withObject:intentData];
        )
    }
}

#pragma mark - 模块查找
+ (XFRouting *)findRoutingForMoudleName:(NSString *)moudleName {
    NSEnumerator *keys = _mapTable.keyEnumerator;
    for (NSString *key in keys) {
        BOOL condition = _prefix ? [key isEqualToString:moudleName] : [key containsString:moudleName];
        if (condition) {
            return [_mapTable objectForKey:key];
        }
    }
    return nil;
}

+ (XFRouting *)produceSubRoutingFromClass:(Class)routingClass parentUInterface:(__kindof id<XFUserInterfacePort>)parentUInterface
{
    XFActivity *parentActivity = parentUInterface;
    XFRouting *parentRouting;
    SuppressPerformSelectorLeakWarning(
        parentRouting = [parentActivity.eventHandler performSelector:@selector(routing)];
        )
    XFRouting *routing = [routingClass routing];
    // 第三方父控制器内部会有自己添加子控制器的方法
    [parentRouting addSubRouting:routing asChildInterface:NO];
    return routing;
}

+ (NSString *)_moudleNameForRouting:(XFRouting *)routing
{
    NSArray *simpleSuffix = @[@"Routing",@"Route",@"Router"];
    NSString *clazzName = NSStringFromClass([routing class]);
    
    NSUInteger index = XF_Index_First;
    NSRange suffixRange = NSMakeRange(XF_Index_First, XF_Index_First);
    do {
        if (index == simpleSuffix.count) {
            return clazzName;
        }
        suffixRange = [clazzName rangeOfString:simpleSuffix[index++]];
    } while (suffixRange.location <= XF_Index_First);
    
    NSRange moudleRange = NSMakeRange(_prefix.length, suffixRange.location - _prefix.length);
    NSString *moudleName = [clazzName substringWithRange:moudleRange];
    return moudleName;
}

#pragma mark - 模块前辍
static NSString *_prefix;
+ (void)setMoudlePrefix:(NSString *)prefix
{
    _prefix = prefix;
}

+ (NSString *)moudlePrefix
{
    return _prefix;
}

#pragma mark - Debug
static BOOL _enableLog = NO;
+ (void)enableLog {
    _enableLog = YES;
}

+ (void)log {
    if (_enableLog) {
        NSLog(@"current routing count: %zd",_mapTable.count);
        NSLog(@"Routing link:");
        XFRouting *routing = [_mapTable objectForKey:_keyArr[XF_Index_First]];
        
        NSMutableString *mStr = [NSMutableString string];
        [mStr appendString:[NSString stringWithFormat:@"(\n\t%@",NSStringFromClass([routing class])]];
        
        XFRouting *nextRouting = routing;
        do {
            NSArray<XFRouting *> *subRoutes = nextRouting.subRoutes;
            if (subRoutes.count) {
                [mStr appendString:@"\n\t("];
                for (XFRouting *subRoute in subRoutes) {
                    [mStr appendString:[NSString stringWithFormat:@"\n\t\t-> %@",NSStringFromClass([subRoute class])]];
                }
                [mStr appendString:@"\n\t)"];
            }
            
            nextRouting = nextRouting.nextRouting;
            
            if (nextRouting != nil) {
                [mStr appendString:[NSString stringWithFormat:@"\n\t-> %@",NSStringFromClass([nextRouting class])]];
                continue;
            }
            [mStr appendString:@"\n)"];
        } while (nextRouting != nil);
        NSLog(@"%@",mStr);
    }
	
}

@end
