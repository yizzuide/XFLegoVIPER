//
//  XFPictureResultsPresenter.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPictureResultsPresenter.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "XFPictureExpressData.h"
#import "XFPictureResultsInteractorPort.h"
#import "XFRoutingLinkManager.h"
#import "XFPictureResultWireframePort.h"
#import "XFPictureItem.h"

#define Routing XFConvertRoutingToType(id<XFPictureResultWireframePort>)
#define Interactor XFConvertInteractorToType(id<XFPictureResultsInteractorPort>)

@class XFPictureItem;
@implementation XFPictureResultsPresenter

- (void)viewDidLoad
{
    // 发送单模块消息事件
    XF_SendEventForMoudle_(@"Search", @"loadData", @"SomeData")
    // 发送多模块消息事件
//    XF_SendEventForMoudles_(@[@"Search"], @"loadData", @"SomeData")
    
    // 在MVx架构中使用下面方法对VIPER架构中模块发事件数据（须导入XFRoutingLinkManager.h头文件）
//    XF_SendEventFormMVxForVIPERMoudles_(@[@"Search"], @"loadData", @"SomeData");
    
    // 在VIPER架构中对MVx架构模块发通知
//    XF_SendMVxNoti_(@"XFReloadDataNotification", nil)
}

- (void)registerMVxNotifactions
{
    // 模拟在MVx架构里发通知
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"StartSearchNotification" object:nil userInfo:@{@"key":@"value"}];
    });
    // 在VIPER架构中注册MVx架构里的原生通知并转为本框架支持的事件，使用`-receiveOtherMoudleEventName:intentData:`接收
    XF_RegisterMVxNotis_(@[@"StartSearchNotification"])
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
            [Routing transitionToDetailsMoudle];
            break;
        case 1:
            [Routing transitionToSubControlMoudle];
            break;
        case 2:
            [Routing transitionToSubControl2Moudle];
            break;
        case 3:
            [Routing transitionToPageControlMoudle];
            break;
        default:
            break;
    }
}

- (void)initRenderView
{
    [[Interactor deconstructPreLoadData:self.intentData]
     subscribeNext:^(XFPictureExpressData *pictureExpressData) {
         //NSLog(@"%@",x);
         NSMutableArray *mPictureExpressData = [pictureExpressData.pictures mutableCopy];
         // 处理最后一个为空数据的情况
         [mPictureExpressData removeLastObject];
         self.expressData = mPictureExpressData;
     }];
}

- (RACSignal *)didFooterRefresh
{
    return [[Interactor loadNextPagePictures] map:^id(XFPictureExpressData *picitrueEData) {
        NSMutableArray *prePictureItems = self.expressData;
        NSUInteger prePictureCount = prePictureItems.count;
        [prePictureItems addObjectsFromArray:picitrueEData.pictures];
        [prePictureItems removeLastObject];
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        NSUInteger count = picitrueEData.pictures.count;
        for (int i = 0; i < count - 1; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:prePictureCount + i inSection:0];
            [indexPaths addObject:indexPath];
        }
        return indexPaths;
    }];
}


- (void)viewWillBecomeFocusWithIntentData:(id)intentData
{
    NSLog(@"%@",self.intentData);
    self.intentData = intentData;
}

- (void)receiveOtherMoudleEventName:(NSString *)eventName intentData:(id)intentData
{
    //NSLog(@"eventName: %@，intentData：%@",eventName,intentData);
    XF_EventIs_(@"StartSearchNotification", {
        NSLog(@"接收到Mvx架构的通知: %@",eventName);
    })
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}
@end
