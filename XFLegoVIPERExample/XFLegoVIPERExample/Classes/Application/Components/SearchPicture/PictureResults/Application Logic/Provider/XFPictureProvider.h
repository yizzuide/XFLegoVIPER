//
//  XFPictureRenderDataProvider.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 16/8/27.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFPictureListModel.h"
#import "XFPictureRenderData.h"

@interface XFPictureProvider : NSObject

+ (instancetype)provider;
- (XFPictureRenderData *)collectedPictureRenderDataFrom:(XFPictureListModel *)pictureListModel;
@end
