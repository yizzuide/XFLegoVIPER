//
//  XFPictureResultsInteractor.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 16/8/27.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFPictureResultsInteractor.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "XFPictureListModel.h"
#import "XFPictureProvider.h"
#import "XFPictureResultsDataManagerPort.h"

@interface XFPictureResultsInteractor ()

@property (nonatomic, strong) XFPictureListModel *pictureListModel;
@end

@implementation XFPictureResultsInteractor

- (RACSignal *)deconstructPreLoadData:(id)preLoadData {
    self.pictureListModel = preLoadData;
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        XFPictureProvider *provider = [XFPictureProvider provider];
        [subscriber sendNext:[provider collectedPictureRenderDataFrom:preLoadData]];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

- (RACSignal *)loadNextPagePictures
{
    NSString *mainCategory = [[NSUserDefaults standardUserDefaults] objectForKey:@"mainCategory"];
    NSString *secondCategory = [[NSUserDefaults standardUserDefaults] objectForKey:@"secondCategory"];
    NSUInteger index = self.pictureListModel.data.count / 5 * 5;
    return [[XFConvertDataManagerToType(id<XFPictureResultsDataManagerPort>)
             pullPictureDataWithMainCategory:mainCategory
             secondCategory:secondCategory
                startIndex:index]
            map:^id(XFPictureListModel *pictureList) {
                [self.pictureListModel.data addObjectsFromArray:pictureList.data];
                XFPictureProvider *provider = [XFPictureProvider provider];
        return [provider collectedPictureRenderDataFrom:pictureList];
    }];
}
@end
