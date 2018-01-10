//
//  XFExpressDirver.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2018/1/10.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#import "XFExpressDirver.h"

@implementation XFExpressDirver

- (void)expressPackCreateFromClass:(Class)expressPackClass fillRenderData:(XFRenderData *)renderData
{
    XFExpressPack *expressPack = [[expressPackClass alloc] init];
    expressPack.renderData = renderData;
    self.expressPack = expressPack;
}
- (void)expressPackAddLastRenderData:(XFRenderData *)renderData
{
    // 追加新数据
    [self.expressPack.renderData.list addObjectsFromArray:renderData.list];
    // 开始计算Frame
    [self.expressPack measureFrameWithList:renderData.list appendType:XFExpressPieceAppendTypeBottom];
}
- (void)expressPackAddNewRenderData:(XFRenderData *)renderData
{
    // 插入数据到数组最前面
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, renderData.list.count)];
    [self.expressPack.renderData.list insertObjects:renderData.list atIndexes:indexSet];
    // 开始计算Frame
    [self.expressPack measureFrameWithList:renderData.list appendType:XFExpressPieceAppendTypeTop];
}
// 清空数据
- (void)expressPackClean
{
    [self.expressPack.renderData.list removeAllObjects];
    [self.expressPack.expressPieces removeAllObjects];
}
- (NSArray<NSIndexPath *> *)expressPackTransform2IndexPathsFromLastRenderData:(XFRenderData *)renderData inSection:(NSInteger)section offsetCount:(NSInteger)offset
{
    // 记录上一次的数据个数
    NSUInteger lastCount = self.expressPack.expressPieces.count - offset;
    
    // 添加新数据
    XF_AddExpressPack_Last(renderData)
    
    // 创建列表视图布局刷新的IndexPath
    NSMutableArray *indexPaths = [NSMutableArray array];
    NSUInteger count = renderData.list.count;
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastCount + i inSection:section];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

- (NSArray<NSIndexPath *> *)expressPackTransform2IndexPathsFromFirstRenderData:(XFRenderData *)renderData inSection:(NSInteger)section offsetCount:(NSInteger)offset
{
    XF_AddExpressPack_First(renderData)
    NSMutableArray *indexPaths = [NSMutableArray array];
    NSUInteger count = renderData.list.count;
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i + offset inSection:section];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

@end
