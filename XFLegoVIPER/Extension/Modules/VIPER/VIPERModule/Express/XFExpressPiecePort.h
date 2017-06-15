//
//  XFExpressPiecePort.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/28.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFExpressPiece.h"

@protocol XFExpressPiecePort <NSObject>

@property (nonatomic, weak) XFExpressPiece *expressPiece;
@end
