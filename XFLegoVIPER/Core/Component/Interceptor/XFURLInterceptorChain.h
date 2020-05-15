//
//  XFURLInterceptorChain.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2019/3/14.
//  Copyright © 2019 Yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFURLInterceptor.h"

NS_ASSUME_NONNULL_BEGIN

@interface XFURLInterceptorChain : NSObject

/**
 *  添加拦截处理器
 *
 *  @param handler         拦截处理器
 */
+ (void)addHandler:(XFURLInterceptor *)handler;

/**
 *  执行 URL 组件拦截处理器链
 *
 *  @param url             url
 *  @param componentName   解析出的组件名
 *
 *  @return 是否被拦截，YES为拦截成功
 */
+ (bool)executeChainWithURL:(NSString *)url componentName:(NSString *)componentName;
@end

NS_ASSUME_NONNULL_END
