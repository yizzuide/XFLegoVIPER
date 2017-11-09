//
//  LEVMContainer.h
//  TZEducation
//
//  Created by Yizzuide on 2017/9/29.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFComponentRoutable.h"

/**
 * MVVM组件连接器
 */
@interface LEMVVMConnector : NSObject
/*
 * 添加一个MVVM迷你版组件到容器, 返回组件入口
 */
+ (nullable id<XFComponentRoutable>)makeComponentFromUInterface:(UIViewController * _Nonnull)viewController;

/*
 * 添加一个自定义组件名的MVVM迷你版组件到容器, 返回组件入口
 */
+ (nullable id<XFComponentRoutable>)makeComponentFromUInterface:(UIViewController * _Nonnull)viewController forName:(nullable NSString *)componentName;

/*
 * 添加一个自定义组件名和意图数据的MVVM迷你版组件到容器, 返回组件入口
 */
+ (nullable id<XFComponentRoutable>)makeComponentFromUInterface:(UIViewController * _Nonnull)viewController forName:(nullable NSString *)componentName intentData:(nullable id)intentData;
@end
