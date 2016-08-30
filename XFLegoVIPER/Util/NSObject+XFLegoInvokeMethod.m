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


- (void)invokeMethod:(NSString *)selector param:(id)param forObject:(id)object {
    SEL bindMethod = NSSelectorFromString(selector);
    
    if (param) {
        SuppressPerformSelectorLeakWarning(
           [object performSelector:bindMethod withObject:param]
           )
    }else{
        SuppressPerformSelectorLeakWarning(
           [object performSelector:bindMethod]
           )
    }
    
}
@end
