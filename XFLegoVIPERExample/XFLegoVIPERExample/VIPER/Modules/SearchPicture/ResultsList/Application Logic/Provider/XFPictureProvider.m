//
//  XFPictureRenderDataProvider.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPictureProvider.h"
#import "NSArray+HOM.h"
#import "XFPictureItem.h"
#import "XFPictureModel.h"

@implementation XFPictureProvider

+ (instancetype)provider {
    return [[self alloc] init];
}

- (XFPictureExpressData *)collectedPictureExpressDataFrom:(XFPictureListModel *)pictureListModel
{
    XFPictureExpressData *expressData = [[XFPictureExpressData alloc] init];
    expressData.pictures = [pictureListModel.data arrayFromObjectsCollectedWithBlock:^id(XFPictureModel *pictureModel) {
        XFPictureItem *item = [[XFPictureItem alloc] init];
        item.title = pictureModel.fromPageTitle;
        item.thumbUrl = [NSURL URLWithString:pictureModel.thumbURL];
        item.coverUrl = [NSURL URLWithString:pictureModel.hoverURL];
        return item;
    }];
    return expressData;
}
@end
