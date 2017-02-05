//
//  LEMVVMModuleFactory.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/30.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFComponentRoutable.h"
#import "LEViewModel.h"

@interface LEMVVMModuleFactory : NSObject

/**
 *  创建ViewModel
 *
 *  @param moduleName 模块名
 *
 */
+ (LEViewModel *)createViewModelFromModuleName:(NSString *)moduleName;
@end
