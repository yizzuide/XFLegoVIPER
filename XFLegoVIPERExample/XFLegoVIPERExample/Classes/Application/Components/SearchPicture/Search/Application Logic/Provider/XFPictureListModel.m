//
//  XFPictureListModel.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 16/8/27.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFPictureListModel.h"
#import <MJExtension/MJExtension.h>
#import "XFPictureModel.h"

@implementation XFPictureListModel

+ (void)load
{
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"data":[XFPictureModel class]
                 };
    }];
}

@end
