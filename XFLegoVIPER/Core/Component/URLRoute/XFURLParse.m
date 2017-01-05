//
//  XFURLParse.m
//  XFLegoVIPERExample
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
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableDictionary *queryDict = [NSMutableDictionary dictionary];
    NSArray *keyValuePairs = [url.query componentsSeparatedByString:@"&"];
    for (NSString *keyValuePair in keyValuePairs) {
        NSArray *element = [keyValuePair componentsSeparatedByString:@"="];
        if (element.count != 2) continue;
        NSString *key = element[0], *value = element[1];
        if (key.length == 0) continue;
        queryDict[key] = value;
    }
    return [NSDictionary dictionaryWithDictionary:queryDict];
}

+ (NSArray<NSString *> *)allComponentsForURL:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSAssert(url.host || ![url.host isEqualToString:@""], @"主路径不存在！");
    NSMutableArray<NSString *> *compoents = @[].mutableCopy;
    [compoents addObject:url.host];
    NSArray *pathComps = url.pathComponents;
    for (NSString *comp in pathComps) {
        if ([comp isEqualToString:@"/"]) {
            continue;
        }
        [compoents addObject:comp];
    }
    return compoents;
}
@end
