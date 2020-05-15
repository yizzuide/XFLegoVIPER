//
//  XFSubControl2EventHandlerPort.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 2016/10/4.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFSubControl2EventHandlerPort_h
#define XFSubControl2EventHandlerPort_h
#import "XFEventHandlerPort.h"

@class RACCommand;
@protocol XFSubControl2EventHandlerPort <XFEventHandlerPort>

@property (nonatomic, strong) RACCommand *collectCommand;
@property (nonatomic, strong) RACCommand *worksCommand;
- (void)requireLoadCollectViewForHostView:(UIView *)hostView;
@end

#endif /* XFSubControl2EventHandlerPort_h */
