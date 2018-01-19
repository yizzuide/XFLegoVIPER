//
//  NSObject+XFPipe.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2018/1/18.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#import "NSObject+XFPipe.h"
#import <objc/runtime.h>
#import "XFPipe.h"

@implementation NSObject (XFPipe)

- (void)setPipe:(id<XFPipePort>)pipe
{
    objc_setAssociatedObject(self, @selector(pipe), pipe, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<XFPipePort>)pipe
{
    id<XFPipePort> pipe = objc_getAssociatedObject(self, _cmd);
    if (pipe) {
        return pipe;
    }
    pipe = [XFPipe shareInstance];
    [self setPipe:pipe];
    return pipe;
}
@end
