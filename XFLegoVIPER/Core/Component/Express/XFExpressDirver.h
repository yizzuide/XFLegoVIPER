//
//  XFExpressDirver.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2018/1/10.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFExpressPack.h"
#import "XFRenderData.h"

// 通过渲染数据创建表达对象
#define XF_SetExpressPack_(ExpressPackClass,renderData) \
[self expressPackCreateFromClass:[ExpressPackClass class] fillRenderData:renderData];
// 快速创建通过渲染数据表达对象（使用默认类XFExpressPack）
#define XF_SetExpressPack_Fast(renderData) \
XF_SetExpressPack_(XFExpressPack,renderData)

// 添加渲染数据到子列表最后
#define XF_AddExpressPack_Last(renderData) \
[self expressPackAddLastRenderData:renderData];
// 添加渲染数据到子列表首
#define XF_AddExpressPack_First(renderData) \
[self expressPackAddNewRenderData:renderData];

// 从加载最近的数据创建indexPaths
#define XF_CreateIndexPaths_Last(renderData,section,offset) \
[self expressPackTransform2IndexPathsFromLastRenderData:renderData inSection:section offsetCount:offset]
// 一个快速只适合单组数据的创建indexPaths
#define XF_CreateIndexPaths_Last_Fast(renderData) XF_CreateIndexPaths_Last(renderData,0,0)
// 从加载最新的数据创建indexPaths
#define XF_CreateIndexPaths_First(renderData,section,offset) \
[self expressPackTransform2IndexPathsFromFirstRenderData:renderData inSection:section offsetCount:offset]
// 一个快速只适合单组数据的创建indexPaths
#define XF_CreateIndexPaths_First_Fast(renderData) XF_CreateIndexPaths_First(renderData,0,0)

// 清空渲染数据
#define XF_ExpressPack_Clean() \
[self expressPackClean];

NS_ASSUME_NONNULL_BEGIN
@interface XFExpressDirver : NSObject

/**
 *  快速填充简单数据
 */
@property (nonatomic, strong, nullable) id expressData;
/**
 *  填充列表复杂数据（RenderData渲染数据的包装类）
 *
 */
@property (nonatomic, strong, nullable) __kindof XFExpressPack *expressPack;

/**
 *  初始化填充数据包
 *
 *  @param expressPackClass 自定义的数据包类
 *  @param renderData       渲染数据
 */
- (void)expressPackCreateFromClass:(Class)expressPackClass fillRenderData:(XFRenderData *)renderData;
/**
 *  数据包追加渲染数据
 *
 *  @param renderData 渲染数据
 */
- (void)expressPackAddLastRenderData:(XFRenderData *)renderData;
/**
 *  数据包插入新渲染数据
 *
 *  @param renderData 渲染数据
 */
- (void)expressPackAddNewRenderData:(XFRenderData *)renderData;
/**
 *  清空数据包
 */
- (void)expressPackClean;
/**
 *  从上拉刷新的新渲染数据，返回相对于列表IndexPaths的路径
 *
 *  @param renderData 渲染数据
 *  @param section    添加组
 *  @param offset     偏移量
 *
 *  @return NSIndexPath数组
 */
- (NSArray<NSIndexPath *> *)expressPackTransform2IndexPathsFromLastRenderData:(XFRenderData *)renderData inSection:(NSInteger)section offsetCount:(NSInteger)offset;
/**
 *  从下拉刷新的新渲染数据，返回相对于列表IndexPaths的路径
 *
 *  @param renderData 渲染数据
 *  @param section    添加组
 *  @param offset     偏移量
 *
 *  @return NSIndexPath数组
 */
- (NSArray<NSIndexPath *> *)expressPackTransform2IndexPathsFromFirstRenderData:(XFRenderData *)renderData inSection:(NSInteger)section offsetCount:(NSInteger)offset;

@end
NS_ASSUME_NONNULL_END
