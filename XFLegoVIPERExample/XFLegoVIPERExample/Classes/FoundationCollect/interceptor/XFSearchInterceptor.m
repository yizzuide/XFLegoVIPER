//
//  XFSearchInterceptor.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2019/3/14.
//  Copyright © 2019 yizzuide. All rights reserved.
//

#import "XFSearchInterceptor.h"

@implementation XFSearchInterceptor

- (bool)interceptWithURL:(NSString *)url componentName:(NSString *)componentName
{
    NSLog(@"SearchInterceptor拦截到 URL：%@", url);
    NSLog(@"SearchInterceptor拦截到组件名：%@", componentName);
    return NO;
}
@end
