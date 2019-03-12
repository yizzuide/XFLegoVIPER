//
//  XFUInterfaceFactory.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/10/5.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

// 根据组件名获取一个子组件的视图
#define XF_SubUInterface_(componentName) [XFUInterfaceFactory createSubUInterfaceFromComponentName:componentName parentUInterface:self]
// 通过URL创建子组件视图（虚拟组件方式与XF_SubUInterface_相同）
#define XF_SubUInterface_URL(urlComponent) [XFUInterfaceFactory createSubUInterfaceFromURLComponent:urlComponent parentUInterface:self]

@interface XFUInterfaceFactory : NSObject

/**
 *  通过组件名创建子组件视图
 *  @param componetName     组件名
 *  @param parentUInterface 父视图
 *
 *  @return VIPER视图
 */
+ (__kindof UIViewController *)createSubUInterfaceFromComponentName:(NSString *)componetName parentUInterface:(__kindof UIViewController *)parentUInterface;

/**
 *   通过URL创建子组件视图
 *
 *  @param url              URL
 *  @param parentUInterface 父视图 (模块组件必传，控制器组件可选)
 *
 *  @return 子视图
 */
+ (__kindof UIViewController *)createSubUInterfaceFromURLComponent:(NSString *)url parentUInterface:(__kindof UIViewController *)parentUInterface;

@end
