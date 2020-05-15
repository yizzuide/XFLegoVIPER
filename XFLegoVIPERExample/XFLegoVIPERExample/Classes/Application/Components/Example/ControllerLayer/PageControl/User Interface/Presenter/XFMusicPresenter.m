//
//  XFMusicPresenter.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2016/10/10.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFMusicPresenter.h"

@implementation XFMusicPresenter

- (void)viewDidAppear
{
    XF_SendEventForComponents_(@"showSubPage", self.userInterface,@"PageControl")
}
@end
