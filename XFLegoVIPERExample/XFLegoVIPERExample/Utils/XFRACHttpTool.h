//
//  CBHttpTool.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 15/12/27.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@interface XFRACHttpTool : NSObject

+ (RACSignal *)postWithURL:(NSString *)url params:(NSDictionary *)params;
+ (RACSignal *)postWithHeaders:(NSDictionary *)headers url:(NSString *)url params:(NSDictionary *)params;
+ (RACSignal *)getWithURL:(NSString *)url params:(NSDictionary *)params;
+ (RACSignal *)getWithHeaders:(NSDictionary *)headers url:(NSString *)url params:(NSDictionary *)params;
@end
