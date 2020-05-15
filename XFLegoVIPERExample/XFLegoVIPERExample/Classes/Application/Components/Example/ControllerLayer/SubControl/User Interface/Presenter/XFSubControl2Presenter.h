//
//  XFSubControl2Presenter.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2016/10/4.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFPresenter.h"
#import "XFSubControl2EventHandlerPort.h"

@interface XFSubControl2Presenter : XFPresenter <XFSubControl2EventHandlerPort>

@property (nonatomic, strong) RACCommand *collectCommand;
@property (nonatomic, strong) RACCommand *worksCommand;
@end
