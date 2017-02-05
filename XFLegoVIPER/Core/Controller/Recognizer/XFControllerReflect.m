//
//  XFControllerReflect.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/19.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFControllerReflect.h"
#import "XFLegoMarco.h"

@implementation XFControllerReflect

+ (BOOL)verifyController:(NSString *)controllerName
{
    NSString *clazzName = [NSString stringWithFormat:@"%@%@%@",XF_Class_Prefix,controllerName,@"ViewController"];
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
    
    NSInteger len = XF_Class_Prefix.length;
    NSRange controllerNameRange = NSMakeRange(len, suffixRange.location - len);
    NSString *controllerName = [clazzName substringWithRange:controllerNameRange];
    return controllerName;
}
@end
