//
//  XFSubControlPresenter.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 2016/10/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPresenter.h"
#import "XFSubControlEventHandlerPort.h"

@interface XFSubControlPresenter : XFPresenter <XFSubControlEventHandlerPort>

@property (nonatomic, strong) RACCommand *collectCommand;
@property (nonatomic, strong) RACCommand *worksCommand;
@end
