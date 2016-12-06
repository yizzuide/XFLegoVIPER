//
//  XFComponentRoutable.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/25.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

/**
 *  一个针对MVx的组件可运行接口
 */
@protocol XFComponentRoutable <NSObject>

/**
 *  url组件传递参数
 */
@property (nonatomic, copy) NSDictionary *URLParams;

/**
 *  url组件传递对象
 */
@property (nonatomic, copy) id componentData;

@end
