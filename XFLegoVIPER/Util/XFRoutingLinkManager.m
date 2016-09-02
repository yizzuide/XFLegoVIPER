//
//  XFRoutingLinkManager.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/9/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFRoutingLinkManager.h"

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

+ (void)log {
	NSLog(@"current routing count: %zd",_mapTable.count);
}

@end
