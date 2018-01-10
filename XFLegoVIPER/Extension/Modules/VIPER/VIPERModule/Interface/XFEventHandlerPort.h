//
//  XFEventHandlerPort.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFEventHandlerPort_h
#define XFEventHandlerPort_h
#import "XFComponentEventResponder.h"
#import "XFExpressPack.h"

@protocol XFEventHandlerPort <XFComponentEventResponder>

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


#endif /* XFEventHandlerPort_h */
