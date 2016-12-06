//
//  XFURLParse.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/11/7.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFURLParse : NSObject
/**
 *  获得URL路径部分
 *
 *  @param urlString URL
 *
 *  @return URL路径
 */
+ (NSString *)pathForURL:(NSString *)urlString;
/**
 *  获得URL最后一个Component
 *
 *  @param urlString URL
 *
 *  @return sub Comp
 */
+ (NSString *)lastPathComponentForURL:(NSString *)urlString;
/**
 *  获得URL所有参数，并将其转为字典类型
 *
 *  @param urlString URL
 *
 *  @return 参数
 */
+ (NSDictionary *)paramsForURL:(NSString *)urlString;

/**
 *  获得所有子路径
 *
 *  @param urlString URL
 *
 *  @return 所有子路径
 */
+ (NSArray<NSString *> *)allComponentsForURL:(NSString *)urlString;
@end
