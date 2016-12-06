//
//  XFPictureResultsDataManagerProt.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/11/9.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFDataManagerPort.h"

@class RACSignal;
@protocol XFPictureResultsDataManagerPort <XFDataManagerPort>

- (RACSignal *)pullPictureDataWithMainCategory:(NSString *)mainCategory secondCategory:(NSString *)secondCategory startIndex:(NSUInteger)startIndex;
@end
