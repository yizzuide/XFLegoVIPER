//
//  XFControllerReflect.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/19.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFControllerReflect.h"
#import "XFLegoMarco.h"
#import "XFModuleReflect.h"

@implementation XFControllerReflect

+ (BOOL)verifyController:(NSString *)controllerName
{
    return [XFModuleReflect verifyModule:controllerName stuffixName:@"ViewController"];
}

+ (NSString *)controllerNameForComponent:(__kindof id<XFComponentRoutable>)component {
    NSString *stuffixName = @"ViewController";
    NSString *modulePrefix = [XFModuleReflect inspectModulePrefixWithModule:component stuffixName:stuffixName];
    NSString *clazzName = NSStringFromClass(component.class);
    if (modulePrefix) {
        NSString *lastPart = [clazzName componentsSeparatedByString:modulePrefix].lastObject;
        return [lastPart componentsSeparatedByString:stuffixName].firstObject;
    } else {
        return [clazzName componentsSeparatedByString:stuffixName].firstObject;
    }
}
@end
