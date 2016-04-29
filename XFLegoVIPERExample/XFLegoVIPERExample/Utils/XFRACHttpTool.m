//
//  CBHttpTool.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 15/12/27.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFRACHttpTool.h"
#import "ReactiveCocoa.h"
#import "AFNetworking.h"
#import "RACAFNetworking.h"

@implementation XFRACHttpTool

+ (RACSignal *)postWithURL:(NSString *)url params:(NSDictionary *)params
{
    return [self postWithHeaders:nil url:url params:params];
}

+ (RACSignal *)postWithHeaders:(NSDictionary *)headers url:(NSString *)url params:(NSDictionary *)params {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (headers) {
        NSArray *keys = headers.allKeys;
        NSUInteger count = keys.count;
        for (int i = 0; i < count; i++) {
            NSString *key = keys[i];
            NSString *value = [headers valueForKey:key];
            [[manager requestSerializer] setValue:value forHTTPHeaderField:key];
        }
    }
    
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    return [manager rac_POST:url parameters:params];
    
}

+ (RACSignal *)getWithURL:(NSString *)url params:(NSDictionary *)params
{
    return [self getWithHeaders:nil url:url params:params];
}

+ (RACSignal *)getWithHeaders:(NSDictionary *)headers url:(NSString *)url params:(NSDictionary *)params {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (headers) {
        NSArray *keys = headers.allKeys;
        NSUInteger count = keys.count;
        for (int i = 0; i < count; i++) {
            NSString *key = keys[i];
            NSString *value = [headers valueForKey:key];
            [[manager requestSerializer] setValue:value forHTTPHeaderField:key];
        }
    }
    
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    return [manager rac_GET:url parameters:params];
    
}
@end
