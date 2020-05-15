//
//  XFStatus.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 2016/10/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFStatus : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL vip; // KVC会自动转
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *picture;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (NSArray *)statuses;
@end
