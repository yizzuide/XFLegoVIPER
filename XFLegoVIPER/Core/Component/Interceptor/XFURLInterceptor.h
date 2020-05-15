//
//  XFURLInterceptor.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2019/3/14.
//  Copyright © 2019 Yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  URL组件拦截器
 */
@interface XFURLInterceptor : NSObject

/**
 * 下一个拦截处理器
 */
@property(nonatomic, strong) XFURLInterceptor *nextHandler;

/**
 *  拦截处理
 *  @param url             url
 *  @param componentName   组件名
 *
 *  @return 是否拦截，YES为拦截，默认为NO
 */
- (bool)interceptWithURL:(NSString *)url componentName:(NSString *)componentName;
@end

NS_ASSUME_NONNULL_END
