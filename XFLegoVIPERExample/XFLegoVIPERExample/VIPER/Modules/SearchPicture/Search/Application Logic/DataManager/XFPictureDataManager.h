//
//  XFPictureDataManager.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/26.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFDataManager.h"

@class RACSignal;
@interface XFPictureDataManager : XFDataManager

- (RACSignal *)grabPictureDataWithMainCategory:(NSString *)mainCategory secondCategory:(NSString *)secondCategory;
@end
