//
//  NSString+Tools.m
//
//
//  Created by Yizzuide on 16-8-21.
//  Copyright (c) 2016年 Yizzuide. All rights reserved.
//

#import "NSString+Tools.h"

@implementation NSString (Tools)

- (CGRect)textRectWithSize:(CGSize)size attributes:(NSDictionary *)attributes
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}

@end
