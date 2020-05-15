//
//  XFWeiboEventHandlerPort.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 2016/10/27.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFEventHandlerPort.h"

@class XFExpressPiece;
@protocol XFWeiboEventHandlerPort <XFEventHandlerPort>

- (void)cellActionForSelectedPiece:(XFExpressPiece *)expressPiece;
@end
