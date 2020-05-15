//
//  XFSearchDataManagerPort.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 2016/11/9.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFDataManagerPort.h"

@class RACSignal;
@protocol XFSearchDataManagerPort <XFDataManagerPort>

- (RACSignal *)pullPictureDataWithMainCategory:(NSString *)mainCategory secondCategory:(NSString *)secondCategory startIndex:(NSUInteger)startIndex;
@end
