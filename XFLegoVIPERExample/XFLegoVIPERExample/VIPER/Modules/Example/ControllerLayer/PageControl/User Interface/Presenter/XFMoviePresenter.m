//
//  XFMoviePresenter.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/10.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFMoviePresenter.h"

@implementation XFMoviePresenter

- (void)viewDidAppear
{
    XF_SendEventForMoudle_(@"PageControl", @"showSubPage", self.userInterface);
}
@end
