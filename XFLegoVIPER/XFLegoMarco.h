//
//  XFLegoMarco.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/27.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFLegoMarco_h
#define XFLegoMarco_h

// 转到视图类型类型
#define LEGORealInterface(interface) (__kindof UIViewController *)(interface)
// 转到新的子接口类型或子对象
#define LEGORealPort(nowPort,oldPort) ((nowPort)(oldPort))

// 即时运行等待时间
#define LEGONextStep 0.0151

// 等待0.015s再运行代码
#define LEGORunAfter0_015(ExecuteCode) \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(LEGONextStep * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{ \
    ExecuteCode \
});

// 索引
#define XF_Index_First  0
#define XF_Index_Second 1
#define XF_Index_Third  2
#define XF_Index_Fourth 3
#define XF_Index_Fifth  5
#define XF_Index_Sixth  6

// 打印当前方法
#define XF_Debug_M(); NSLog(@"%s",__func__);

// 定义软引用
#define XF_Define_Weak \
__weak __typeof__ (self) self_weak_ = self;
#define XF_Define_Strong \
__strong __typeof__(self) self = self_weak_;

// 模块反射类
#import "XFRoutingReflect.h"

#define SUPPRESS_UNDECLARED_SELECTOR_LEAK_WARNING(code)                        \
_Pragma("clang diagnostic push")                                        \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"")     \
code;                                                                   \
_Pragma("clang diagnostic pop")                                         \

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff \
_Pragma("clang diagnostic pop") \
} while (0);

#endif /* XFLegoMarco_h */
