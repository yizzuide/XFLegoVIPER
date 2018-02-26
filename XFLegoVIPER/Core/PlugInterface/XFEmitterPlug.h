//
//  XFEmitterPlug.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2018/1/18.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#ifndef XFEmitterPlug_h
#define XFEmitterPlug_h
#import "NSObject+XFPipe.h"

// 定义枚举类型
#define XF_Def_EnumType(type,subTypeArray) \
typedef NS_ENUM(NSUInteger, type) { \
subTypeArray \
};
// 定义字符串数组
#define XF_Def_TypeStringArray(typeStrings) \
[NSArray arrayWithObjects:typeStrings, nil]

// 枚举转字符串
#define XF_Func_TypeEnumToString(subEnumType,typeStringArray) \
[typeStringArray objectAtIndex:subEnumType]
// 字符串转枚举
#define XF_Func_StringToTypeEnum(typeString,typeStringArray) \
[typeStringArray indexOfObject:typeString]

/**
 *  事件发射源插件化接口
 */
@protocol XFEmitterPlug <NSObject>
@required
/**
 * 事件发射器准备事件源等工作
 */
- (void)prepare;
@end


#endif /* XFEmitterPlug_h */
