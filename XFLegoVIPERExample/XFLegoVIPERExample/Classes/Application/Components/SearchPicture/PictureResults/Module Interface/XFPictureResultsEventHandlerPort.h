//
//  XFPictureResultsEventHandlerPort.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/9/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFEventHandlerPort.h"

@class RACCommand,RACSignal;
@protocol XFPictureResultsEventHandlerPort <XFEventHandlerPort>

@property (nonatomic, strong) RACCommand *cellSelectedCommad;

- (RACSignal *)didFooterRefresh;
@end
