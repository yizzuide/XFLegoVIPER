//
//  XFPictureService.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 16/8/26.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFPictureService.h"
#import "XFRACHttpTool.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MJExtension/MJExtension.h>
#import "XFPictureListModel.h"


@implementation XFPictureService

- (RACSignal *)pullPictureDataWithMainCategory:(NSString *)mainCategory secondCategory:(NSString *)secondCategory startIndex:(NSUInteger)startIndex
{
    // http://image.baidu.com/search/acjson?tn=resultjson_com&ipn=rj&word=beyond&step_word=beyond&pn=90&rn=30
    return [[XFRACHttpTool getWithURL:@"http://image.baidu.com/search/acjson"
                       params:@{
                                @"tn": @"resultjson_com",
                                @"ipn": @"rj",
                                @"word":mainCategory,
                                @"step_word":secondCategory,
                                @"pn": @(startIndex), // 第几条开始
                                @"rn": @5, // 返回多少条
                                }]
            map:^id(RACTuple *tuple) {
        return [XFPictureListModel mj_objectWithKeyValues:tuple.first];
    }];
}
@end
