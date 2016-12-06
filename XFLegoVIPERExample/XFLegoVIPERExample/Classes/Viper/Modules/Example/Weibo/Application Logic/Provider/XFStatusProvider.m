//
//  XFStatusProvider.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFStatusProvider.h"
#import "ReactiveCocoa.h"
#import "XFStautsRenderItem.h"

@implementation XFStatusProvider

+ (instancetype)provider {
    return [[self alloc] init];
}

- (XFRenderData *)collectedStatusRenderDataFrom:(NSArray<XFStatus *> *)statusArr
{
    XFRenderData *renderData = [[XFRenderData alloc] init];
    NSArray *list = [[statusArr.rac_sequence map:^id(XFStatus *status) {
        XFStautsRenderItem *renderItem = [[XFStautsRenderItem alloc] init];
        renderItem.nikeName = status.name;
        renderItem.portraitImage = status.icon;
        renderItem.vip = status.vip;
        renderItem.content = status.text;
        renderItem.photo = status.picture;
        return renderItem;
    }] array];
    renderData.list = [list copy];
    return renderData;
}
@end
