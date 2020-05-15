//
//  XFSearchInteractorPort.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 16/8/30.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//


@class RACSignal;
@protocol XFSearchInteractorPort <NSObject>

- (RACSignal *)fetchPictureDataWithMainCategory:(NSString *)mainCategory secondCategory:(NSString *)secondCategory;

@end
