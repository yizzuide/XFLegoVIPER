//
//  XFMoviePresenter.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2016/10/10.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFMoviePresenter.h"

@implementation XFMoviePresenter

- (void)viewDidAppear
{
    XF_SendEventForComponents_(@"showSubPage", self.userInterface,@"PageControl")
}
@end
