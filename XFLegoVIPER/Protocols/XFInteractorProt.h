//
//  XFInteractorProt.h
//  VIPERGem
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFInteractorProt_h
#define XFInteractorProt_h

typedef void(^CallBackWithObject)(id obj);

@protocol XFInteractorProt <NSObject>

/**
 *  向服务抓起一条数据
 *
 *  @param callback 数据回调
 */
- (void)fetchRenderDataWithBlock:(CallBackWithObject)callback;
@end


#endif /* XFInteractorProt_h */
