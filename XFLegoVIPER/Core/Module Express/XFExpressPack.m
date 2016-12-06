//
//  XFExpressPack.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/10/20.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFExpressPack.h"

@implementation XFExpressPack

- (void)setRenderData:(XFRenderData *)renderData
{
    _renderData = renderData;
    // 如果有数组
    if (renderData.list) {
        self.expressPieces = @[].mutableCopy;
        // 调用计算Frame
        [self measureFrameWithList:renderData.list appendType:XFExpressPieceAppendTypeBottom];
    }
}

// 测量数据Frame
- (void)measureFrameWithList:(NSArray<__kindof XFRenderItem *> *)renderDataList appendType:(XFExpressPieceAppendType)type
{
    [self onMeasureBefroe];
    NSUInteger count = renderDataList.count;
    NSUInteger insertIdex = 0;
    for (int i = 0; i < count; i++) {
        XFExpressPiece *expressPiece = [[XFExpressPiece alloc] init];
        expressPiece.renderItem = renderDataList[i];
        // 如果子类有实现计算布局测量方法
        id subUIFrame = [self onMeasureFrameWithItem:renderDataList[i] index:i];
        if (subUIFrame) {
            expressPiece.uiFrame = subUIFrame;
        }
        switch (type) {
            case XFExpressPieceAppendTypeBottom:
                [self.expressPieces addObject:expressPiece];
                break;
            case XFExpressPieceAppendTypeTop:
                [self.expressPieces insertObject:expressPiece atIndex:insertIdex++];
                break;
        }
    }
    [self onMeasureAfter];
}

- (void)onMeasureBefroe{}
// 当计算单个Item的时候
- (id)onMeasureFrameWithItem:(__kindof XFRenderItem *)renderItem index:(NSUInteger)index
{
    return nil;
}
- (void)onMeasureAfter{}

// 重新计算单行数据
- (void)reMeasureFrameForExpressPiece:(__kindof XFExpressPiece *)expressPiece
{
    expressPiece.uiFrame = [self onMeasureFrameWithItem:expressPiece.renderItem index:[self findIndexWithPiece:expressPiece]];
}

- (NSInteger)findIndexWithPiece:(__kindof XFExpressPiece *)expressPiece {
    NSArray *renderDataList = self.renderData.list;
    if (renderDataList) {
        return [renderDataList indexOfObject:expressPiece.renderItem];
    }
    return NSNotFound;
}

@end
