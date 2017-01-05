//
//  NSObject+XFLegoSwizzle.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/26.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "NSObject+XFLegoSwizzle.h"
#import <objc/runtime.h>

@implementation NSObject (XFLegoSwizzle)

+ (void)xfLego_swizzleMethod:(SEL)originSel withMethod:(SEL)customSel {
    Method originMethod = class_getInstanceMethod([self class], originSel);
    Method customMethod = class_getInstanceMethod([self class], customSel);
    BOOL isAdd = class_addMethod(self, originSel, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
    if (isAdd) {
        // 如果成功，说明类中不存在这个方法的实现
        class_replaceMethod(self, customSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        //否则，交换两个方法的实现
        method_exchangeImplementations(originMethod, customMethod);
    }
}
@end
