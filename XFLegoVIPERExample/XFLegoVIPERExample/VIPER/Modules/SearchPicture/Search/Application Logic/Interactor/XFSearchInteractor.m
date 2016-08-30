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
     return [XFConvertDataManagerToType(XFPictureDataManager *) grabPictureDataWithMainCategory:mainCategory secondCategory:secondCategory];
}
@end
