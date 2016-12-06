//
//  XFURLRoute.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/11/7.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFAppURLRegister.h"
#import "XFURLRoute.h"


@implementation XFAppURLRegister

+ (void)registerURLs {
//    [XFURLManager register:@"xf://search/pictureResults/details"];
    [XFURLRoute initURLGroup:@[
                                  /**
                                   *  这里的注册URL可以规范组件/模块的名字和层级
                                   */
                                  @"xf://search",
                                  @"xf://search/pictureResults",
                                  @"xf://search/pictureResults/details",
                                  @"xf://search/pictureResults/subControl",
                                  @"xf://search/pictureResults/subControl2",
                                  @"xf://search/pictureResults/pageControl",
                                  @"xf://search/pictureResults/weibo",
                                  ]];
}
@end
