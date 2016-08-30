//
//  XFLegoMarco.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/27.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFLegoMarco_h
#define XFLegoMarco_h

// 转到XFActivity类型
#define LEGORealInterface(interface) (XFActivity *)(interface)
// 转到新的子接口类型或子对象
#define LEGORealPort(nowPort,oldPort) ((nowPort)(oldPort))

#define SUPPRESS_UNDECLARED_SELECTOR_LEAK_WARNING(code)                        \
_Pragma("clang diagnostic push")                                        \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"")     \
code;                                                                   \
_Pragma("clang diagnostic pop")                                         \

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0);

#endif /* XFLegoMarco_h */
