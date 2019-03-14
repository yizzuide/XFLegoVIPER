//
//  XFAuthInterceptor.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2019/3/14.
//  Copyright © 2019 yizzuide. All rights reserved.
//

#import "XFAuthInterceptor.h"

@implementation XFAuthInterceptor

- (bool)interceptWithURL:(NSString *)url componentName:(NSString *)componentName
{
    NSLog(@"AuthInterceptor拦截到 URL：%@", url);
    NSLog(@"AuthInterceptor拦截到组件名：%@", componentName);
    // 测试拦截掉搜索结果页面，实际情况可以跟据业务需要处理，比如支付页面先判断有无 token，否则跳转到登录
    if ([url containsString:@"pictureResults"]) {
        NSLog(@"AuthInterceptor拦截了 URL：%@", url);
        return YES;
    }
    return NO;
}
@end
