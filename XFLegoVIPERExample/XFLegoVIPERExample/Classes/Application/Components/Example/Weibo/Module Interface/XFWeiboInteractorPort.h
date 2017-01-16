//
//  XFWeiboInteractorPort.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/27.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFInteractorPort.h"

@class RACSignal;
@protocol XFWeiboInteractorPort <XFInteractorPort>

- (RACSignal *)fetchStatus;
@end
