//
//  XFURLInterceptorChain.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2019/3/14.
//  Copyright © 2019 Yizzuide. All rights reserved.
//

#import "XFURLInterceptorChain.h"

@implementation XFURLInterceptorChain

/**
 *  拦截处理器链
 */
static XFURLInterceptor *firstHanlder_;
static XFURLInterceptor *nextHandler_;

+ (void)addHandler:(XFURLInterceptor *)handler
{
    // 设置链条头
    if (firstHanlder_ == nil && nextHandler_ == nil) {
        firstHanlder_ = handler;
        nextHandler_ = firstHanlder_;
        return;
    }
    // 串起链条
    [nextHandler_ setNextHandler:handler];
    // 更改当前链条位置
    nextHandler_ = handler;
}

+ (bool)executeChainWithURL:(NSString *)url componentName:(NSString *)componentName
{
    bool isIntercepted = NO;
    if (firstHanlder_ == nil) {
        return isIntercepted;
    }
    XFURLInterceptor *handler = firstHanlder_;
    do {
        isIntercepted = [handler interceptWithURL:url componentName:componentName];
        handler = handler.nextHandler;
        if (handler == nil) {
            break;
        }
    } while (!isIntercepted);
    return isIntercepted;
}
@end
