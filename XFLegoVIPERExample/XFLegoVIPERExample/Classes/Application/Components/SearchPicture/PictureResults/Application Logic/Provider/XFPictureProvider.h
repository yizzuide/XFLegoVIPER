//
//  XFPictureRenderDataProvider.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFPictureListModel.h"
#import "XFPictureRenderData.h"

@interface XFPictureProvider : NSObject

+ (instancetype)provider;
- (XFPictureRenderData *)collectedPictureRenderDataFrom:(XFPictureListModel *)pictureListModel;
@end
