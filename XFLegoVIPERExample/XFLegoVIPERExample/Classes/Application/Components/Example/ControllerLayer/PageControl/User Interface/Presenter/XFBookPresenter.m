//
//  XFBookPresenter.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 2016/10/10.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFBookPresenter.h"

@implementation XFBookPresenter

- (void)viewDidAppear
{
    XF_SendEventForComponents_(@"showSubPage", self.userInterface,@"PageControl")
}
@end
