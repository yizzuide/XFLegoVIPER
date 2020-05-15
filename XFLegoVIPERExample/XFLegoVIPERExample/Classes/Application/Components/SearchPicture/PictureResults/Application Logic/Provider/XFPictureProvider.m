//
//  XFPictureRenderDataProvider.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPictureProvider.h"
#import "NSArray+HOM.h"
#import "XFPictureModel.h"
#import "XFPictureRenderItem.h"

@implementation XFPictureProvider

+ (instancetype)provider {
    return [[self alloc] init];
}

- (XFPictureRenderData *)collectedPictureRenderDataFrom:(XFPictureListModel *)pictureListModel
{
    XFPictureRenderData *renderData = [[XFPictureRenderData alloc] init];
    renderData.list = [pictureListModel.data arrayFromObjectsCollectedWithBlock:^id(XFPictureModel *pictureModel) {
        XFPictureRenderItem *item = [[XFPictureRenderItem alloc] init];
        item.title = pictureModel.fromPageTitle;
        item.thumbUrl = [NSURL URLWithString:pictureModel.thumbURL];
        item.coverUrl = [NSURL URLWithString:pictureModel.hoverURL];
        return item;
    }].mutableCopy;
    // 移除最后一个为空数据的情况
    [renderData.list removeLastObject];
    return renderData;
}
@end
