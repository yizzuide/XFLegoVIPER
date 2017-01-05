//
//  XFControllerReflect.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/19.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFControllerReflect.h"
#import "XFRoutingLinkManager.h"
#import "XFLegoMarco.h"

@implementation XFControllerReflect

+ (BOOL)verifyController:(NSString *)controllerName
{
    NSString *clazzName = [NSString stringWithFormat:@"%@%@%@",[XFRoutingLinkManager modulePrefix],controllerName,@"ViewController"];
    if (NSClassFromString(clazzName)) {
        return YES;
    }
    return NO;
}

+ (NSString *)controllerNameForComponent:(__kindof id<XFComponentRoutable>)component {
    NSArray *simpleSuffix = @[@"ViewController"];
    NSString *clazzName = NSStringFromClass([component class]);
    
    NSUInteger index = XF_Index_First;
    NSRange suffixRange;
    do {
        if (index == simpleSuffix.count) {
            return clazzName;
        }
        suffixRange = [clazzName rangeOfString:simpleSuffix[index++]];
    } while (suffixRange.location <= XF_Index_First);
    
    NSInteger len = [XFRoutingLinkManager modulePrefix].length;
    NSRange moduleRange = NSMakeRange(len, suffixRange.location - len);
    NSString *moduleName = [clazzName substringWithRange:moduleRange];
    return moduleName;
}
@end
