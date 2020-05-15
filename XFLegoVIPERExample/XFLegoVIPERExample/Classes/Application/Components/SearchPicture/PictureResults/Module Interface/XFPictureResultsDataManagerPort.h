//
//  XFPictureResultsDataManagerProt.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2016/11/9.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFDataManagerPort.h"

@class RACSignal;
@protocol XFPictureResultsDataManagerPort <XFDataManagerPort>

- (RACSignal *)pullPictureDataWithMainCategory:(NSString *)mainCategory secondCategory:(NSString *)secondCategory startIndex:(NSUInteger)startIndex;
@end
