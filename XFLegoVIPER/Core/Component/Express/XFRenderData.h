//
//  XFRenderData.h
//  XFLegoVIPERE
//
//  Created by Yizzuide on 2016/10/20.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFRenderItem.h"

/**
 *  页面显示数据，可选继承添加其它显示数据
 */
@interface XFRenderData : NSObject

/**
 *  数据列表
 */
@property (nonatomic, strong) NSMutableArray<__kindof XFRenderItem *> *list;
@end
