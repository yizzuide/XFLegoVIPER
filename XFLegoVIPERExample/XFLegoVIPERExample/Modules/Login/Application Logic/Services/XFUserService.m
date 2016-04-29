//
//  XFUserService.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFUserService.h"
#import "XFRACHttpTool.h"
#import "XFLoginInfoModel.h"
#import "ReactiveCocoa.h"
#import "MJExtension.h"

@implementation XFUserService

- (RACSignal *)loginWithUserName:(NSString *)name password:(NSString *)pwd
{
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [params setObject:name forKey:@"username"];
    [params setObject:pwd forKey:@"password"];
    [params setObject:@"password" forKey:@"grant_type"];
    return [[XFRACHttpTool postWithURL:@"http://api-dev.button4creative.com/oauth/token"
                                params:params] map:^id(RACTuple *tuple) {
        return [XFLoginInfoModel mj_objectWithKeyValues:tuple.first];
    }];
}
@end
