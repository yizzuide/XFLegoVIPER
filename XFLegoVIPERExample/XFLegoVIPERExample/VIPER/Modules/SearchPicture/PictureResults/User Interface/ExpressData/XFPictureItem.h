//
//  XFPictureItem.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFPictureItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSURL *thumbUrl;
@property (nonatomic, strong) NSURL *coverUrl;
@end
