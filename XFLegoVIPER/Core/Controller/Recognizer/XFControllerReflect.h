//
//  XFControllerReflect.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/19.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

// 获得当前控制器组件模块名
#undef XF_ModuleName
#define XF_ModuleName \
[XFControllerReflect controllerNameForComponent:self]

@protocol XFComponentRoutable;
@interface XFControllerReflect : NSObject

/**
 *  验证是否是控制器组件
 *
 *  @param controllerName 控制名
 *
 */
+ (BOOL)verifyController:(NSString *)controllerName;

/**
 *  获取控制器名
 *
 *  @param component 组件
 *
 */
+ (NSString *)controllerNameForComponent:(__kindof id<XFComponentRoutable>)component;
@end
