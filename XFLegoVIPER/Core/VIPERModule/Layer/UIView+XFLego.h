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
#import "XFExpressPiece.h"
#import "XFRenderItem.h"

#define XFConvertPresenterToType(type) LEGORealPort(type, self.eventHandler)

@interface UIView (XFLego)

/**
 *  事件处理器
 */
@property (nonatomic, weak, readonly) __kindof id<XFEventHandlerPort> eventHandler;

/**
 *  当Activity将被Pop或Dismiss
 */
- (void)xfLego_viewWillPopOrDismiss;

@end
