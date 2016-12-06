//
//  NSObject+XFLegoInvokeMethod.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/28.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "NSObject+XFLegoInvokeMethod.h"
#import "XFLegoMarco.h"

@implementation NSObject (XFLegoInvokeMethod)

- (void)invokeMethod:(NSString *)selector
{
    SuppressPerformSelectorLeakWarning(
        [self performSelector:NSSelectorFromString(selector)];
            )
}
- (void)invokeMethod:(NSString *)selector param:(id)param
{
    SuppressPerformSelectorLeakWarning(
        [self performSelector:NSSelectorFromString(selector) withObject:param];
            )
}
- (void)invokeMethod:(NSString *)selector param1:(id)param1 param2:(id)param2
{
    SuppressPerformSelectorLeakWarning(
        [self performSelector:NSSelectorFromString(selector) withObject:param1 withObject:param2];
            )
}
@end
