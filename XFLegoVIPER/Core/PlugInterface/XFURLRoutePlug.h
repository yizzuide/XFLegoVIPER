//
//  XFURLRoutePlug.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/23.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#ifndef XFURLRoutePlug_h
#define XFURLRoutePlug_h


/**
 *  URL路由插件化接口
 */
@protocol XFURLRoutePlug <NSObject>

/**
 *  自定义URL规则，实现这个规则的方法，解析出组件名，参数等
 *
 *  @param url             url
 *  @param transitionBlock 分解组件Block
 *
 *  @return 打开是否成功
 */
+ (BOOL)open:(NSString *)url transitionBlock:(void(^)(NSString *componentName,NSDictionary *params))transitionBlock;
@end

#endif /* XFURLRoutePlug_h */
