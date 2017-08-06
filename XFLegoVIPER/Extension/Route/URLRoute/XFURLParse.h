//
//  XFURLParse.h
//  XFLegoVIPER
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
/**
 *  从一个字典返回URL参数字符串
 *
 *  @param dict 字典
 *
 *  @return URL参数字符串
 */
+ (NSString *)stringFromDictionary:(NSDictionary *)dict;
/**
 *  通过主路径和参数组装一个url
 *
 *  @param urlPath 主路径
 *  @param params  参数
 *
 *  @return url
 */
+ (NSString *)urlFromPath:(NSString *)urlPath params:(NSDictionary *)params;
@end
