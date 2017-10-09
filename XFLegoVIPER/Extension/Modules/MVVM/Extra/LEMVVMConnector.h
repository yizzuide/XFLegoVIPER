//
//  LEVMContainer.h
//  TZEducation
//
//  Created by Yizzuide on 2017/9/29.
//  Copyright © 2017年 CBY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFComponentRoutable.h"

/**
 * MVVM组件连接器
 */
@interface LEMVVMConnector : NSObject
/*
 * 添加一个MVVM简化版组件到容器, 返回组件入口
 */
+ (nullable id<XFComponentRoutable>)makeComponentFromUInterface:(UIViewController * _Nonnull)viewController;
@end
