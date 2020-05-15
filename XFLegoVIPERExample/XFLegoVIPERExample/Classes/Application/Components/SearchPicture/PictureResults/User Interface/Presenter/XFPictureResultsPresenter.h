//
//  XFPictureResultsPresenter.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 16/8/27.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFPresenter.h"
#import "XFPictureResultsEventHandlerPort.h"

@interface XFPictureResultsPresenter : XFPresenter <XFPictureResultsEventHandlerPort>

@property (nonatomic, strong) RACCommand *cellSelectedCommad;
@end
