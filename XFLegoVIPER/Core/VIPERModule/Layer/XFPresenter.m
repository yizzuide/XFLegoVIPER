//
//  XFPresenter.m
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFPresenter.h"
#import "NSObject+XFLegoInvokeMethod.h"

@implementation XFPresenter

// 导出为组件
XF_EXPORT_COMPONENT

#pragma mark - 生命周期
- (void)viewDidLoad{}
- (void)initCommand{}
- (void)initRenderView{}
- (void)viewWillAppear{}
- (void)viewDidAppear{}
- (void)viewWillDisappear{}
- (void)viewDidDisappear{}

- (void)componentWillBecomeFocus{}
- (void)componentWillResignFocus{}

- (void)onNewIntent:(id)intentData{}

#pragma mark - 组件通信
- (void)registerMVxNotifactions{}
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData{}


#pragma mark - UI事件
- (void)xfLego_onBackItemTouch
{
    [self.routing popComponent];
}
- (void)xfLego_onDismissItemTouch
{
    [self.routing dismissComponent];
}


#pragma mark - 渲染数据包方法
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
    NSUInteger lastPostsCount = self.expressPack.expressPieces.count - offset;
    
    // 添加新数据
    XF_AddExpressPack_Last(renderData)
    
    // 创建列表视图布局刷新的IndexPath
    NSMutableArray *indexPaths = [NSMutableArray array];
    NSUInteger count = renderData.list.count;
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastPostsCount + i inSection:section];
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


#pragma mark - 私有方法
// 绑定一个视图
- (void)xfLego_bindView:(id)view
{
    [self setValue:view forKey:@"userInterface"];
    [self.routing invokeMethod:@"xfLego_destoryUInterfaceRef"];
    [self viewDidLoad];
    [self initCommand];
    [self registerMVxNotifactions];
    [self initRenderView];
}

- (void)xfLego_viewWillPopOrDismiss
{
    [self.routing invokeMethod:@"xfLego_removeRouting"];
}

@end
