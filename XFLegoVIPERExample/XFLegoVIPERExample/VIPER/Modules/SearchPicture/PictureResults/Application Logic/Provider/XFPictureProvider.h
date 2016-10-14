//
//  XFPictureRenderDataProvider.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFPictureExpressData.h"
#import "XFPictureListModel.h"

@interface XFPictureProvider : NSObject

+ (instancetype)provider;
- (XFPictureExpressData *)collectedPictureExpressDataFrom:(XFPictureListModel *)pictureListModel;
@end
