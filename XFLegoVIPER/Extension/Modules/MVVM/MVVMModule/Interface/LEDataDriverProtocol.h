//
//  LEDataDriverProtocol.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/29.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#ifndef LEDataDriverProtocol_h
#define LEDataDriverProtocol_h
#import "XFComponentEventResponder.h"
#import "XFExpressPack.h"

/**
 *  数据驱动接口
 */
@protocol LEDataDriverProtocol <XFComponentEventResponder>

/**
 *  快速填充简单数据
 */
@property (nonatomic, strong) id expressData;
/**
 *  填充列表复杂数据（RenderData渲染数据的包装类）
 *
 */
@property (nonatomic, strong) __kindof XFExpressPack *expressPack;
@end

#endif /* LEDataDriverProtocol_h */
