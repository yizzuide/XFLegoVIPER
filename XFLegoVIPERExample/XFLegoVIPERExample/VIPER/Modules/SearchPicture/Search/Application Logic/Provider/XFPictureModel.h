//
//  XFPictureModel.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFPictureModel : NSObject

@property (nonatomic, copy) NSString *thumbURL;
@property (nonatomic, copy) NSString *middleURL;
@property (nonatomic, copy) NSString *hoverURL;

@property (nonatomic, copy) NSString *fromURL;
@property (nonatomic, copy) NSString *fromURLHost;

@property (nonatomic, assign) NSUInteger width;
@property (nonatomic, assign) NSUInteger height;

@property (nonatomic, copy) NSString *bdImgnewsDate;
@property (nonatomic, copy) NSString *fromPageTitle;
@property (nonatomic, copy) NSString *fromPageTitleEnc;
@end
