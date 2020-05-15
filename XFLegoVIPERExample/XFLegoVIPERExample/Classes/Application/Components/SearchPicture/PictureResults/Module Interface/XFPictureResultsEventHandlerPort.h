//
//  XFPictureResultsEventHandlerPort.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 16/9/21.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFEventHandlerPort.h"

@class RACCommand,RACSignal;
@protocol XFPictureResultsEventHandlerPort <XFEventHandlerPort>

@property (nonatomic, strong) RACCommand *cellSelectedCommad;

- (RACSignal *)didFooterRefresh;
@end
