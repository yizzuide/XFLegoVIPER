//
//  XFEventHandlerProt.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFEventHandlerProt_h
#define XFEventHandlerProt_h

@protocol XFEventHandlerProt <NSObject>

/**
 * 视图填充数据（用于视图层使用MVVM响应获取数据）
 *
 */
@property (nonatomic, strong) id expressData;

/**
 *  错误消息
 */
@property (nonatomic, copy) NSString *errorMessage;

@end


#endif /* XFEventHandlerProt_h */
