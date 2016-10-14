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
#import "XFPictureDataManager.h"

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

- (RACSignal *)loadNextPagePictures
{
    NSString *mainCategory = [[NSUserDefaults standardUserDefaults] objectForKey:@"mainCategory"];
    NSString *secondCategory = [[NSUserDefaults standardUserDefaults] objectForKey:@"secondCategory"];
    NSUInteger index = self.pictureListModel.data.count % 5 + 1;
    NSLog(@"正在加载第%zd页！",index);
    return [[XFConvertDataManagerToType(XFPictureDataManager *)
             pullPictureDataWithMainCategory:mainCategory
             secondCategory:secondCategory
                startIndex:index]
            map:^id(XFPictureListModel *pictureList) {
                [self.pictureListModel.data addObjectsFromArray:pictureList.data];
                XFPictureProvider *provider = [XFPictureProvider provider];
        return [provider collectedPictureExpressDataFrom:pictureList];
    }];
}
@end
