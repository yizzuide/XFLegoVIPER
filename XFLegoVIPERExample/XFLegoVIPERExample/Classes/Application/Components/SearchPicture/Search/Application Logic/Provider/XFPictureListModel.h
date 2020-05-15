//
//  XFPictureListModel.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XFPictureModel;
@interface XFPictureListModel : NSObject

@property (nonatomic, copy) NSString *queryEnc;
@property (nonatomic, copy) NSString *queryExt;
@property (nonatomic, assign) NSUInteger listNum;
@property (nonatomic, assign) NSUInteger displayNum;
@property (nonatomic, strong) NSMutableArray<XFPictureModel *> *data;
@end
