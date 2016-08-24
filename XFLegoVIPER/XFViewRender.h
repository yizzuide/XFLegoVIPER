//
//  XFViewRender.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFLegoMarco.h"

#define XFConvertPresenterToType(type) LEGORealProt(type, self.eventHandler)

@interface XFViewRender : UIView

@end

@protocol XFEventHandlerProt;

@interface UIView (XFLego)

@property (nonatomic, strong) id<XFEventHandlerProt> eventHandler;
@end
