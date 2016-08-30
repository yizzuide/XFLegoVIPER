//
//  CBLoginInfoModel.h
//  
//
//  Created by yizzuide on 15/11/24.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFLoginInfoModel : NSObject
/** 用户名*/
@property (nonatomic, copy) NSString *userName;
/** 授权类型*/
@property (nonatomic, copy) NSString *token_type;

@end
