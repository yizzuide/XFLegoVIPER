//
//  XFRenderItem.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/20.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFRenderItem.h"

/**
 *  列表单个数据包，这个不需要自定义扩展
 */
@interface XFExpressPiece : NSObject

/**
 *  渲染数据
 */
@property (nonatomic, strong) __kindof XFRenderItem *renderItem;
/**
 *  视图Frame
 */
@property (nonatomic, strong) id uiFrame;
@end
