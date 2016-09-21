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

@implementation XFPictureResultsPresenter

- (void)viewDidLoad
{
    // 发送单模块消息事件
    [self.routing sendEventName:@"loadData" intentData:@"SomeData" forMoudleName:@"Search"];
    // 发送多模块消息事件
    //[self.routing sendEventName:@"loadData" intentData:@"SomeData" forMoudlesName:@[@"Search"]];
    
    // 在MVx架构中使用下面方法对VIPER架构中模块发事件数据
    //[XFRoutingLinkManager sendEventName:@"loadData" intentData:@"SomeData" forMoudlesName:@[@"Search"]];
    
    // 在VIPER架构中对MVx架构模块发通知
    //[self.routing sendNotificationForMVxWithName:@"XFReloadDataNotification" intentData:nil];
    
    // 模拟在MVx架构发通知
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"StartSearchNotification" object:nil userInfo:@{@"key":@"value"}];
    });
    // 在VIPER架构中注册MVx架构里的原生通知并转为本框架支持的事件，使用`-receiveOtherMoudleEventName:intentData:`接收
    [self.routing registerForMVxNotificationsWithNameArray:@[@"StartSearchNotification"]];
    
    @weakify(self)
    self.cellSelectedCommad = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [self executeCellSelectedSignal];
    }];
}

- (RACSignal *)executeCellSelectedSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [XFConvertRoutingToType(id<XFPictureResultWireframePort>) transitionToDetailsMoudle];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}



- (void)viewWillBecomeFocusWithIntentData:(id)intentData
{
    //NSLog(@"%@",self.intentData);
    [[XFConvertInteractorToType(id<XFPictureResultsInteractorPort>) deconstructPreLoadData:intentData]
        subscribeNext:^(XFPictureExpressData *pictureExpressData) {
            //NSLog(@"%@",x);
            NSMutableArray *mPictureExpressData = [pictureExpressData.pictures mutableCopy];
            // 处理最后一个为空数据的情况
            [mPictureExpressData removeLastObject];
            self.expressData = mPictureExpressData;
        }];
}

- (void)receiveOtherMoudleEventName:(NSString *)eventName intentData:(id)intentData
{
    //NSLog(@"eventName: %@，intentData：%@",eventName,intentData);
    IsEventNameEquals(@"StartSearchNotification",
    {
        NSLog(@"receive Mvx notification: %@",@"StartSearchNotification");
        NSLog(@"接收到Mvx架构的通知: %@",@"StartSearchNotification");
    })
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}
@end
