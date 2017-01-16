//
//  XFWeiboInteractor.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/27.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFWeiboInteractor.h"
#import "XFWeiboDataManager.h"
#import "ReactiveCocoa.h"
#import "XFStatus.h"
#import "XFStatusProvider.h"


#define DataManager XFConvertDataManagerToType(XFWeiboDataManager *)

@interface XFWeiboInteractor ()

@property (nonatomic, strong) NSArray<XFStatus *> *statusArr;
@end

@implementation XFWeiboInteractor

#pragma mark - Request
- (RACSignal *)fetchStatus
{
    self.statusArr = [XFStatus statuses];
    XFRenderData *renderData = [[XFStatusProvider provider] collectedStatusRenderDataFrom:self.statusArr];
    return [RACSignal return:renderData];
}

#pragma mark - BusinessReduce


#pragma mark - ConvertData


@end
