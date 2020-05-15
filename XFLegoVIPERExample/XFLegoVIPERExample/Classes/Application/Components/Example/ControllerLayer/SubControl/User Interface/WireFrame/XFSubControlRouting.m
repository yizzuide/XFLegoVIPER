//
//  XFSubControlRouting.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2016/10/3.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFSubControlRouting.h"
#import "XFSubControlPresenter.h"
#import "XFCollectRouting.h"
#import "XFWorksRouting.h"
#import "XFActivity.h"

@implementation XFSubControlRouting

//XF_InjectModuleWith_IB(@"x-XFSubControlActivity", [XFSubControlPresenter class], nil, nil)
//XF_AutoAssemblyModule_FastIB(@"x-XFSubControlActivity")

XF_AutoAssemblyModule_Fast


- (UIView *)fluctuate2CollectSubRoutes
{
    XFCollectRouting *collectRouting = [XFCollectRouting assembleRouting];
    [self addSubRouting:collectRouting asChildViewController:YES];
    XFWorksRouting *worksRouting = [XFWorksRouting assembleRouting];
    [self addSubRouting:worksRouting asChildViewController:YES];
    return [collectRouting.realUInterface view];
}

- (void)switch2CollectSubRoute
{
    XFActivity *collectActivity = [MainActivity childViewControllers][XF_Index_First];
    XFActivity *worksActivity = [MainActivity childViewControllers][XF_Index_Second];
    collectActivity.view.frame = worksActivity.view.bounds;
    [MainActivity transitionFromViewController:worksActivity toViewController:collectActivity duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
    } completion:^(BOOL finished) {
    }];
}

- (void)switch2WorksSubRoute
{
    XFActivity *collectActivity = [MainActivity childViewControllers][XF_Index_First];
    XFActivity *worksActivity = [MainActivity childViewControllers][XF_Index_Second];
    worksActivity.view.frame = collectActivity.view.bounds;
    [MainActivity transitionFromViewController:collectActivity toViewController:worksActivity duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dealloc
{
    XF_Debug_M();
}

@end
