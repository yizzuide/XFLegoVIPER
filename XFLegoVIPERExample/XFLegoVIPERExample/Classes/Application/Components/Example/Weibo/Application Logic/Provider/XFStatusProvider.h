//
//  XFStatusProvider.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 2016/10/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFRenderData.h"
#import "XFStatus.h"


@interface XFStatusProvider : NSObject

+ (instancetype)provider;
- (XFRenderData *)collectedStatusRenderDataFrom:(NSArray<XFStatus *> *)statusArr;
@end
