//
//  XFBookPresenter.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/10.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFBookPresenter.h"

@implementation XFBookPresenter

- (void)viewDidAppear
{
    XF_SendEventForMoudle_(@"PageControl", @"showSubPage", self.userInterface);
}
@end
