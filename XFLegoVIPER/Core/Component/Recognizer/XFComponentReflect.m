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

#define MatchedComponentHandler Class<XFComponentHandlerPlug> matchedComponentHandler = [self componentHandlerForComponent:(id)component];

@implementation XFComponentReflect

+ (Class<XFComponentHandlerPlug>)componentHandlerForComponent:(id)component
{
    return [XFComponentHandlerMatcher matchComponent:component];
}

+ (BOOL)existComponent:(NSString *)componentName
{
    Class<XFComponentHandlerPlug> componentHandler = [self componentHandlerForComponent:componentName];
    BOOL isFind = (componentHandler != NULL);
    return isFind;
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
    if (!matchedComponentHandler) {
        return nil;
    }
    id<XFComponentRoutable> component = [matchedComponentHandler componentForUInterface:uInterface];
    return component;
}
@end
