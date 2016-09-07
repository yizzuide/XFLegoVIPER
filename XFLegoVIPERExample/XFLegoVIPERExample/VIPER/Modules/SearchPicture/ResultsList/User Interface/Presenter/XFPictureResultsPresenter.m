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
    
    // 在MV*架构中使用下面方法对VIPER架构中模块发事件数据
    //[XFRoutingLinkManager sendEventName:@"loadData" intentData:@"SomeData" forMoudlesName:@[@"Search"]];
    
    // 在VIPER架构中对MV*架构模块发通知
    //[self.routing sendNotificationForMVxWithName:@"XFReloadDataNotification" intentData:nil];
}

- (void)viewDidUnLoad
{
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
@end
