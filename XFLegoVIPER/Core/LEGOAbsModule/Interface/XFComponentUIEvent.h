//
//  XFComponentUIEvent.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/3/15.
//  Copyright © 2017年 Yizzuide. All rights reserved.
//

#ifndef XFComponentUIEvent_h
#define XFComponentUIEvent_h

// 基于ReactiveCocoa的快速命令执行宏
#define XF_CEXE_Begin XF_Define_Weak
// 绑定命令与执行代码（默认返回空信号，可手动返回新的信号）
#define XF_CEXE_(commandRef, ExecuteCode) \
commandRef = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) { \
    XF_Define_Strong \
    [self self]; \
    ExecuteCode \
    return [RACSignal empty]; \
}];
// 基于enable信号，绑定命令与执行代码（默认返回空信号，可手动返回新的信号）
#define XF_CEXE_Enable_(commandRef, enableSignal, ExecuteCode)\
commandRef = [[RACCommand alloc] initWithEnabled:enableSignal signalBlock:^RACSignal *(id input) {\
    XF_Define_Strong \
    [self self]; \
    ExecuteCode \
    return [RACSignal empty]; \
}];

/**
 *  这个协议用于模块事件层实现，针对视图要做的统一事件处理
 */
@protocol XFComponentUIEvent <NSObject>

@optional
/**
 *  使视图层退下键盘
 */
- (void)dismissKeyboard;

@end


#endif /* XFComponentUIEvent_h */
