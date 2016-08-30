//
//  XFPictureResultsInteractor.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPictureResultsInteractor.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "XFPictureListModel.h"
#import "XFPictureProvider.h"

@interface XFPictureResultsInteractor ()

@property (nonatomic, strong) XFPictureListModel *pictureListModel;
@end

@implementation XFPictureResultsInteractor

- (RACSignal *)deconstructPreLoadData:(id)preLoadData {
    self.pictureListModel = preLoadData;
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        XFPictureProvider *provider = [XFPictureProvider provider];
        [subscriber sendNext:[provider collectedPictureExpressDataFrom:preLoadData]];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}
@end
