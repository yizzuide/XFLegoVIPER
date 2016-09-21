//
//  XFPictureResultsEventHandlerPort.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/9/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFPictureResultsEventHandlerPort_h
#define XFPictureResultsEventHandlerPort_h
#import "XFEventHandlerPort.h"

@class RACCommand;
@protocol XFPictureResultsEventHandlerPort <XFEventHandlerPort>

@property (nonatomic, strong) RACCommand *cellSelectedCommad;
@end

#endif /* XFPictureResultsEventHandlerPort_h */
