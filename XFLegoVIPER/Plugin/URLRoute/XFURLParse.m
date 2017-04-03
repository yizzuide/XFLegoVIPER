//
//  XFURLParse.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/7.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFURLParse.h"

@implementation XFURLParse

+ (NSString *)pathForURL:(NSString *)urlString {
    NSArray<NSString *> *urlComponents = [urlString componentsSeparatedByString:@"?"];
    if (urlComponents && urlComponents.count) {
        return urlComponents[0];
    }
    return urlString;
}

+ (NSString *)lastPathComponentForURL:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *lastComp = url.lastPathComponent;
    if ([lastComp isEqualToString:@""]) {
        lastComp = url.host;
    }
    return lastComp;
}

+ (NSDictionary *)paramsForURL:(NSString *)urlString {
    NSMutableDictionary *queryDict = [NSMutableDictionary dictionary];
    NSRange questionMark = [urlString rangeOfString:@"?"];
    if (questionMark.length == 0) {
        return nil;
    }
    NSString *paramString = [urlString substringFromIndex:questionMark.location + 1];
    NSArray *keyValuePairs = [paramString componentsSeparatedByString:@"&"];
    for (NSString *keyValuePair in keyValuePairs) {
        NSArray *element = [keyValuePair componentsSeparatedByString:@"="];
        if (element.count != 2) continue;
        NSString *key = element[0], *value = element[1];
        if (key.length == 0) continue;
        if ([value hasPrefix:@"http%3A%2F%2F"] ||
            [value hasPrefix:@"https%3A%2F%2F"]) {
            value = [self decodeFromPercentEscapeString:value];
        }
        queryDict[key] = value;
    }
    return [NSDictionary dictionaryWithDictionary:queryDict];
}

+ (NSArray<NSString *> *)allComponentsForURL:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSAssert(url.host || ![url.host isEqualToString:@""], @"主路径不存在！");
    NSMutableArray<NSString *> *components = @[].mutableCopy;
    [components addObject:url.host];
    NSArray *pathComps = url.pathComponents;
    for (NSString *comp in pathComps) {
        if ([comp isEqualToString:@"/"]) {
            continue;
        }
        [components addObject:comp];
    }
    return components;
}

+ (NSString *)stringFromDictionary:(NSDictionary *)dict {
    NSMutableString *mStr = @"".mutableCopy;
    for (NSString *key in  dict.allKeys){
        // 判断值是否为Http协议的URL
        NSString *value = dict[key];
        if ([value hasPrefix:@"http://"] ||
            [value hasPrefix:@"https://"]) {
            value = [self encodeToPercentEscapeString:value];
            NSString *orignURL = [self decodeFromPercentEscapeString:value];
            NSLog(@"%@",orignURL);
        }
        [mStr appendFormat:@"%@=%@&",key, value];
    }
    NSString *result = [mStr substringToIndex:mStr.length - 1];
    return result;
}

+ (NSString *)encodeToPercentEscapeString:(NSString *)input
{
    NSString *outputStr =
    (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                 NULL, /* allocator */
                                                                 (__bridge CFStringRef)input,
                                                                 NULL, /* charactersToLeaveUnescaped */
                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                 kCFStringEncodingUTF8);
    return outputStr;
    
}

+ (NSString *)decodeFromPercentEscapeString:(NSString *)input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@""
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0,[outputStr length])];
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end
