//
//  XFDetailsPresenter.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 16/9/21.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFDetailsPresenter.h"
#import "XFRoutingLinkManager.h"

@implementation XFDetailsPresenter

- (void)initRenderView
{
    NSLog(@"获得参数：%@",self.URLParams);
}


- (void)dealloc
{
    XF_Debug_M();
}
@end
