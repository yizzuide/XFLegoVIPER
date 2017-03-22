//
//  XFComponentHandlerMatcher.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/27.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "XFComponentHandlerMatcher.h"
#import "XFComponentHandlerPlug.h"
#import "XFLegoMarco.h"

@implementation XFComponentHandlerMatcher

// 匹配组件处理器
+ (Class<XFComponentHandlerPlug>)matchComponent:(id)component
{
    for (Class<XFComponentHandlerPlug> componentHandler  in [LEGOConfig allComponentHanderPlugs]) {
        if([componentHandler matchComponent:component]) {
            return componentHandler;
        }
    }
    return NULL;
}

+ (Class<XFComponentHandlerPlug>)matchUInterface:(id)uInterface
{
    for (Class<XFComponentHandlerPlug> componentHandler  in [LEGOConfig allComponentHanderPlugs]) {
        if([componentHandler matchUInterface:uInterface]) {
            return componentHandler;
        }
    }
    return NULL;
}
@end
