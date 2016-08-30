//
//  UIView+XFLego.h
//  XFLegoVIPE
//
//  Created by 付星 on 16/8/26.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFEventHandlerPort.h"
#import "XFLegoMarco.h"

#define XFConvertPresenterToType(type) LEGORealPort(type, self.eventHandler)

/**
 *  这个分类，只会处理从xib中加载出来时自行绑定事件处理者，如果纯代码请继承`XFViewRender`类
 *  如果无法再继承，就导入这个分类再自行在初始化方法里调用`xfLogo_bindEventHandler`方法
 */
@interface UIView (XFLego)

/**
 *  事件处理者
 */
@property (nonatomic, weak) id<XFEventHandlerPort> eventHandler;
/**
 *  手动绑定处理者（注意：只有在当前视图无法继承第二个类并且不是从xib中加载出来的)
 */
- (void)xfLogo_bindEventHandler;
@end
