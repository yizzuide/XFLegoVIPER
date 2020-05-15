//
//  XFPictureResultsPresenter.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPresenter.h"
#import "XFPictureResultsEventHandlerPort.h"

@interface XFPictureResultsPresenter : XFPresenter <XFPictureResultsEventHandlerPort>

@property (nonatomic, strong) RACCommand *cellSelectedCommad;
@end
