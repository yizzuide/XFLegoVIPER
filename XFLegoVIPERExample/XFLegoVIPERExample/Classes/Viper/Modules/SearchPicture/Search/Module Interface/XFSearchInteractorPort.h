//
//  XFSearchInteractorPort.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/30.
//  Copyright © 2016年 yizzuide. All rights reserved.
//


@class RACSignal;
@protocol XFSearchInteractorPort <NSObject>

- (RACSignal *)fetchPictureDataWithMainCategory:(NSString *)mainCategory secondCategory:(NSString *)secondCategory;

@end
