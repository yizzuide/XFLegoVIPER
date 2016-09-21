//
//  XFRoutingLinkManager.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/9/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFRoutingLinkManager.h"
#import "XFLegoMarco.h"

@implementation XFRoutingLinkManager

static NSMapTable *_mapTable;

+ (void)initialize
{
    if (self == [XFRoutingLinkManager class]) {
        _mapTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
    }
}

+ (void)addRouting:(id)routing {
    [_mapTable setObject:routing forKey:NSStringFromClass([routing class])];
}

+ (void)removeRouting:(id)routing {
    [_mapTable removeObjectForKey:NSStringFromClass([routing class])];
}

+ (id)findRoutingForMoudleName:(NSString *)moudleName {
    NSEnumerator *keys = _mapTable.keyEnumerator;
    for (NSString *key in keys) {
        if ([key containsString:moudleName]) {
            return [_mapTable objectForKey:key];
        }
    }
    return nil;
}

+ (void)sendEventName:(NSString *)eventName intentData:(id)intentData forMoudlesName:(NSArray<NSString *> *)moudlesName
{
    for (NSString *moudleName in moudlesName) {
        // 找到对应模块路由
        id routing = [self findRoutingForMoudleName:moudleName];
        // 通知路由发送事件
        SuppressPerformSelectorLeakWarning (
            [routing performSelector:NSSelectorFromString(@"_sendEventName:intentData:") withObject:eventName withObject:intentData];
        )
    }
}

static BOOL _enableLog = NO;
+ (void)enableLog {
    _enableLog = YES;
}

+ (void)log {
    if (_enableLog) {
        NSLog(@"current routing count: %zd",_mapTable.count);
        
        NSLog(@"Routing link:");
        id routing = [_mapTable objectEnumerator].allObjects[0];
        
        NSMutableString *mStr = [NSMutableString string];
        [mStr appendString:[NSString stringWithFormat:@"(\n\t%@",NSStringFromClass([routing class])]];
        
        id nextRouting = routing;
        do {
            SuppressPerformSelectorLeakWarning (
                nextRouting = [nextRouting performSelector:NSSelectorFromString(@"nextRouting")];
            )
            if (nextRouting != nil) {
                [mStr appendString:[NSString stringWithFormat:@"\n\t->%@",NSStringFromClass([nextRouting class])]];
                continue;
            }
            [mStr appendString:@"\n)"];
        } while (nextRouting != nil);
        NSLog(@"%@",mStr);
    }
	
}



@end
