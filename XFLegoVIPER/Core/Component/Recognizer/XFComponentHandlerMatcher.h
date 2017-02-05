//
//  XFComponentHandlerMatcher.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/27.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XFUIBus;
@protocol XFComponentHandlerPlug;
@interface XFComponentHandlerMatcher : NSObject

/**
*  根据组件名或组件对象找到组件处理器
*
*  @param component 组件名或组件对象
* 
*/
+ (Class<XFComponentHandlerPlug>)matchComponent:(id)component;

/**
 *  根据组件界面元素找到组件处理器
 *
 *  @param uInterface 界面层
 *
 */
+ (Class<XFComponentHandlerPlug>)matchUInterface:(id)uInterface;
@end
