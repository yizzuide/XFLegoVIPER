//
//  XFPictureResultsPresenter.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 16/8/27.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFPictureResultsPresenter.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "XFPictureResultsInteractorPort.h"
#import "XFRoutingLinkManager.h"
#import "XFPictureResultWireframePort.h"
#import "XFPictureRenderData.h"
#import "XFPictureRenderItem.h"
#import "XFExpressPack.h"


#define Routing XFConvertRoutingToType(id<XFPictureResultWireframePort>)
#define Interactor XFConvertInteractorToType(id<XFPictureResultsInteractorPort>)

@implementation XFPictureResultsPresenter

- (void)viewDidLoad
{
    // 发送组件消息事件
    XF_SendEventForComponents_(@"loadData", @"SomeData",@"Search")
    
    // 在VIPER架构中对MVx架构模块发通知
//    XF_SendMVxNoti_(@"XFReloadDataNotification", nil)
}

- (void)initRenderView
{
    [[Interactor deconstructPreLoadData:self.componentData]
     subscribeNext:^(XFPictureRenderData *pictureRenderData) {
         // 设置视图表达对象
         XF_SetExpressPack_Fast(pictureRenderData)
     }];
}

- (void)registerMVxNotifactions
{
    // 模拟在MVx架构里发通知
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"StartSearchNotification" object:nil userInfo:@{@"key":@"value"}];
    });
    // 在VIPER架构中注册MVx架构里的原生通知并转为本框架支持的事件，使用`-receiveComponentEventName:intentData:`接收
    XF_RegisterMVxNotis_(@"StartSearchNotification")
}

- (void)initCommand
{
    XF_CEXE_Begin
    XF_CEXE_(self.cellSelectedCommad, {
        RACTupleUnpack(NSIndexPath *indexPath) = input;
        [self executeCellSelectedSignalWithIndex:indexPath.row];
    });
}

- (void)executeCellSelectedSignalWithIndex:(NSUInteger)index
{
    switch (index) {
        case 0:
            [Routing transitionToDetailsModule];
            break;
        case 1:
            [Routing transitionToSubControlModule];
            break;
        case 2:
            [Routing transitionToSubControl2Module];
            break;
        case 3:
            [Routing transitionToPageControlModule];
            break;
            case 4:
            [Routing transitionToWeiboModule];
            break;
        default:
            break;
    }
}

- (RACSignal *)didFooterRefresh
{
    return [[Interactor loadNextPagePictures] map:^id(XFPictureRenderData *pictureRenderData) {
        // 记录上一次的数据个数
        /*NSUInteger lastPicturesCount = self.expressPack.expressPieces.count;
//        添加渲染对象
        XF_AddExpressPack_Last(pictureRenderData)
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        NSUInteger count = pictureRenderData.list.count;
        for (int i = 0; i < count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastPicturesCount + i inSection:0];
            [indexPaths addObject:indexPath];
        }
        return indexPaths;*/
        
        // 一个快速返回IndexPath的宏
        return XF_CreateIndexPaths_Last_Fast(pictureRenderData);
    }];
}

- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    //NSLog(@"eventName: %@，intentData：%@",eventName,intentData);
    XF_EventIs_(@"StartSearchNotification", {
        NSLog(@"接收到MVx架构的通知: %@",eventName);
    })
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}
@end
