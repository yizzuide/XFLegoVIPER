//
//  XFSubControlEventHandlerPort.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFSubControlEventHandlerPort_h
#define XFSubControlEventHandlerPort_h

@class RACCommand;
@protocol XFSubControlEventHandlerPort <NSObject>

@property (nonatomic, strong) RACCommand *collectCommand;
@property (nonatomic, strong) RACCommand *worksCommand;

- (UIView *)requireCollectView;

@end

#endif /* XFSubControlEventHandlerPort_h */
