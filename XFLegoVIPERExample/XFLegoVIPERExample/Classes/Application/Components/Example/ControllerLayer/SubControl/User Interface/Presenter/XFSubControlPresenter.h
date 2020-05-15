//
//  XFSubControlPresenter.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2016/10/3.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFPresenter.h"
#import "XFSubControlEventHandlerPort.h"

@interface XFSubControlPresenter : XFPresenter <XFSubControlEventHandlerPort>

@property (nonatomic, strong) RACCommand *collectCommand;
@property (nonatomic, strong) RACCommand *worksCommand;
@end
