//
//  XFStatus.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2016/10/27.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFStatus.h"

@implementation XFStatus

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (NSArray *)statuses
{
    NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"statuses.plist" ofType:nil]];
    NSMutableArray *mArr = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(NSDictionary *item, NSUInteger idx, BOOL *stop) {
        [mArr addObject:[[self alloc] initWithDict:item]];
    }];
    return mArr;
}
@end
