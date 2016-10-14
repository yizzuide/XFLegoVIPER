//
//  XFSearchInteractor.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/26.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFSearchInteractor.h"
#import "XFPictureDataManager.h"

@implementation XFSearchInteractor

- (RACSignal *)fetchPictureDataWithMainCategory:(NSString *)mainCategory secondCategory:(NSString *)secondCategory
{
    // 存储搜索内容
    [[NSUserDefaults standardUserDefaults] setObject:mainCategory forKey:@"mainCategory"];
    [[NSUserDefaults standardUserDefaults] setObject:secondCategory forKey:@"secondCategory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
     return [XFConvertDataManagerToType(XFPictureDataManager *) pullPictureDataWithMainCategory:mainCategory secondCategory:secondCategory startIndex:0];
}
@end
