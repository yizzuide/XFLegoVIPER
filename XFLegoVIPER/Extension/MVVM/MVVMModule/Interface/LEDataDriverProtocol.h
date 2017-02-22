//
//  LEDataDriverProtocol.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/29.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#ifndef LEDataDriverProtocol_h
#define LEDataDriverProtocol_h

/**
 *  数据驱动接口
 */
@protocol LEDataDriverProtocol <NSObject>

/**
 *  快递数据
 */
@property (nonatomic, copy) id expressData;
@end

#endif /* LEDataDriverProtocol_h */
