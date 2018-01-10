//
//  LEViewModel.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/29.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFControllerRunnable.h"
#import "LEViewProtocol.h"
#import "LEDataDriverProtocol.h"
#import "XFLegoMarco.h"
#import "XFComponentBindEvent.h"
#import "XFComponentEventResponder.h"
#import "LEMVVMModuleReflect.h"
#import "XFExpressDirver.h"

@interface LEViewModel : XFExpressDirver <XFComponentBindEvent, LEDataDriverProtocol, XFControllerRunnable>

/**
 *  视图层
 */
@property (nonatomic, weak, readonly) id<LEViewProtocol> view;

/**
 *  快递数据
 */
@property (nonatomic, strong) id expressData;

/**
 *  UI总线
 */
@property (nonatomic, strong, readonly) __kindof XFUIBus *uiBus;
/**
 *  事件总线
 */
@property (nonatomic, strong, readonly) __kindof XFEventBus *eventBus;

/**
 *  上一个组件（来源组件）
 */
@property (nonatomic, weak, readonly) __kindof id<XFComponentRoutable> fromComponentRoutable;

/**
 *  下一个组件
 */
@property (nonatomic, weak, readonly) __kindof id<XFComponentRoutable> nextComponentRoutable;


/**
 *  上一个URL组件传递过来的URL参数
 */
@property (nonatomic, copy) NSDictionary *URLParams;

/**
 *  上一个URL组件传递过来的自定义数据对象
 */
@property (nonatomic, copy) id componentData;

/**
 *  预设要传递给其它组件的意图数据
 */
@property (nonatomic, copy) id intentData;

@end
