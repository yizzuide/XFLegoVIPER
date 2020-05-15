//
//  XFPictureService.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/8/26.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@interface XFPictureService : NSObject

- (RACSignal *)pullPictureDataWithMainCategory:(NSString *)mainCategory secondCategory:(NSString *)secondCategory startIndex:(NSUInteger)startIndex;
@end
