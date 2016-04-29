//
//  XFUserService.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface XFUserService : NSObject
/**
 *  登录请求
 *
 *  @param name 用户名
 *  @param pwd  密码
 *
 *  @return 数据信号
 */
- (RACSignal *)loginWithUserName:(NSString *)name password:(NSString *)pwd;
@end
