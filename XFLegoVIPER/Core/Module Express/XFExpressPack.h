//
//  XFExpressPack.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/10/20.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFExpressPiece.h"
#import "XFRenderData.h"

/**
 *  插入列表类型
 */
typedef NS_ENUM(NSInteger, XFExpressPieceAppendType) {
    /**
     *  插在列表最后
     */
    XFExpressPieceAppendTypeBottom,
    /**
     *  插在列表首
     */
    XFExpressPieceAppendTypeTop
};

/**
 *  视图表达对象，只有要对列表计算Frame时需要继承并实现测量方法
 */
@interface XFExpressPack : NSObject

/**
 *  视图填充数据（内部有可选原渲染列表数据）
 */
@property (nonatomic, strong) __kindof XFRenderData *renderData;

/**
 *  列表子视图表达对象（包含子视图渲染数据和计算完成的Frame）
 */
@property (nonatomic, strong) NSMutableArray<__kindof XFExpressPiece *> *expressPieces;


/**
 *  测量新加载的列表子视图Frame
 *
 *  @param renderDataList 列表数据
 *  @param type           子项插入方式
 */
- (void)measureFrameWithList:(NSArray<__kindof XFRenderItem *> *)renderDataList appendType:(XFExpressPieceAppendType)type;

/**
 *  测量之前
 */
- (void)onMeasureBefroe;
/**
 *  测量当前Item数据的Frame（勾子方法）
 *
 *  @param renderItem     子项
 *  @param index          数组中索引
 *
 *  @return Frame对象<NSObject>
 */
- (id)onMeasureFrameWithItem:(__kindof XFRenderItem *)renderItem index:(NSUInteger)index;
/**
 *  测量之后
 */
- (void)onMeasureAfter;
/**
 *  重新计算单行数据Frame
 *
 *  @param expressPiece 子视图包装类
 */
- (void)reMeasureFrameForExpressPiece:(__kindof XFExpressPiece *)expressPiece;
/**
 *  返回被选择的视图显示数据索引
 *
 *  @param expressPiece 子视图包装类
 *
 *  @return 数组中的索引
 */
- (NSInteger)findIndexWithPiece:(__kindof XFExpressPiece *)expressPiece;
@end
