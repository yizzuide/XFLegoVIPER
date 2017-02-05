//
//  XFComponentReflect.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/20.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFComponentReflect.h"
#import "XFComponentHandlerMatcher.h"
#import "XFComponentHandlerPlug.h"
#import "XFVIPERModuleHandler.h"
#import "XFControllerHandler.h"

#define MatchedComponentHandler Class<XFComponentHandlerPlug> matchedComponentHandler = [self componentHandlerForComponent:(id)component];

@implementation XFComponentReflect

+ (Class<XFComponentHandlerPlug>)componentHandlerForComponent:(id)component
{
    return [XFComponentHandlerMatcher matchComponent:component];
}

+ (BOOL)existComponent:(NSString *)componentName
{
    return [self componentHandlerForComponent:componentName];
}

+ (BOOL)isVIPERModuleComponent:(id)component {
    MatchedComponentHandler
    return matchedComponentHandler == [XFVIPERModuleHandler class];
}

+ (BOOL)isControllerComponent:(id)component {
    MatchedComponentHandler
    return matchedComponentHandler == [XFControllerHandler class];
}

+ (NSString *)componentNameForComponent:(id<XFComponentRoutable>)component {
    
    MatchedComponentHandler
    return [matchedComponentHandler componentNameFromComponent:component];
}

+ (UIViewController *)uInterfaceForComponent:(__kindof id<XFComponentRoutable>)component {
    MatchedComponentHandler
    return [matchedComponentHandler uInterfaceForComponent:component];
}

+ (id<XFComponentRoutable>)componentForUInterface:(UIViewController *)uInterface
{
     Class<XFComponentHandlerPlug> matchedComponentHandler = [XFComponentHandlerMatcher matchUInterface:uInterface];
    id<XFComponentRoutable> component = [matchedComponentHandler componentForUInterface:uInterface];
    return component;
}
@end
