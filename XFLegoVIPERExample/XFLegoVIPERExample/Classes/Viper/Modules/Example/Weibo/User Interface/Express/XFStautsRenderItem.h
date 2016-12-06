//
//  XFStautsRenderItem.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFRenderItem.h"

@interface XFStautsRenderItem : XFRenderItem

@property (nonatomic, copy) NSString *portraitImage;
@property (nonatomic, copy) NSString *nikeName;
@property (nonatomic, assign, getter=isVIP) BOOL vip;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *photo;

@end
