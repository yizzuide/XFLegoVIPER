//
//  NSObject+XFLegoSwizzle.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/26.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XFLegoSwizzle)

/**
 *  交换两个方法
 *
 *  @param originSel 原方法
 *  @param customSel 自定义方法
 */
+ (void)xfLego_swizzleMethod:(SEL)originSel withMethod:(SEL)customSel;
@end
