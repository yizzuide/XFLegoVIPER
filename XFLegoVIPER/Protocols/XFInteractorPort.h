//
//  XFInteractorPort.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFInteractorPort_h
#define XFInteractorPort_h

typedef void(^CallBackWithObject)(id obj);

@protocol XFInteractorPort <NSObject>

/**
 *  向服务抓起一条数据
 *
 *  @param callback 数据回调
 */
- (void)fetchRenderDataWithBlock:(CallBackWithObject)callback;
@end


#endif /* XFInteractorPort_h */
