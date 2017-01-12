//
//  XFPictureResultsRouting.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPictureResultsRouting.h"


@implementation XFPictureResultsRouting

/*XF_InjectModuleWith_Act(XF_Class_(XFPictureResultsActivity),
                        XF_Class_(XFPictureResultsPresenter),
                        XF_Class_(XFPictureResultsInteractor),
                        XF_Class_(XFPictureDataManager))*/

XF_AutoAssemblyModule_Fast

- (void)transitionToDetailsModule
{
    XF_PUSH_URLComponent_Fast(@"xf://search/pictureResults/details?usrid=123")
}

- (void)transitionToSubControlModule
{
    XF_PUSH_URLComponent_Fast(@"xf://search/pictureResults/subControl")
}

- (void)transitionToSubControl2Module
{
    XF_PUSH_URLComponent_Fast(@"xf://search/pictureResults/subControl2")
}

- (void)transitionToPageControlModule
{
    XF_PUSH_URLComponent_Fast(@"xf://search/pictureResults/pageControl")
}

- (void)transitionToWeiboModule
{
    XF_PUSH_URLComponent_Fast(@"xf://search/pictureResults/weibo")
}

@end
