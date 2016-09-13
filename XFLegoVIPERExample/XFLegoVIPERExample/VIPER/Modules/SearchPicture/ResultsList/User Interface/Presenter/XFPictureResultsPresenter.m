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
    
    // 模拟在MVx架构测试发通知
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"StartSearchNotification" object:nil userInfo:@{@"key":@"value"}];
    });
    // 在VIPER架构中注册MVx架构里的原生通知并转为本框架支持的事件，使用`-receiveOtherMoudleEventName:intentData:`接收
    [self.routing registerForMVxNotificationsWithNameArray:@[@"StartSearchNotification"]];
}

- (void)viewDidUnLoad
{
    [super viewDidUnLoad];
    NSLog(@"%@被POP",NSStringFromClass(self.class));
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
    NSLog(@"eventName: %@，intentData：%@",eventName,intentData);
}

// 自定义Back返回事件
- (void)xfLego_onBackItemTouch
{
    NSLog(@"%@将要被POP",NSStringFromClass(self.class));
    // 调用父类默认实现
    [super xfLego_onBackItemTouch];
}
@end
