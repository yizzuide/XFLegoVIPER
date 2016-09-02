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

@implementation XFPictureResultsPresenter

- (void)viewDidLoad
{
    // 模拟模块间消息通信
    [XFConvertRoutingToType(id<XFWireFramePort>) sendEventName:@"loadData" intentData:@"SomeData" forMoudleName:@"Search"];
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
