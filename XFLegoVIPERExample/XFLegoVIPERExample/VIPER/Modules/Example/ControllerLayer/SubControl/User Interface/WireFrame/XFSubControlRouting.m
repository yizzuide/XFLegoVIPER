//
//  XFSubControlRouting.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFSubControlRouting.h"
#import "XFSubControlPresenter.h"
#import "XFCollectRouting.h"
#import "XFWorksRouting.h"

@implementation XFSubControlRouting

XF_JnjectMoudleWith_IB(@"x-XFSubControlActivity", [XFSubControlPresenter class], nil, nil)

- (UIView *)fluctuate2CollectSubRoutes
{
    XFCollectRouting *collectRouting = [XFCollectRouting routing];
    id<XFUserInterfacePort> collectInterface = [self addSubRouting:collectRouting asChildInterface:YES];
    XFWorksRouting *worksRouting = [XFWorksRouting routing];
    [self addSubRouting:worksRouting asChildInterface:YES];
    return [LEGORealInterface(collectInterface) view];
}

- (void)switch2CollectSubRoute
{
    XFActivity *collectActivity = [MainActivity childViewControllers][XF_Index_First];
    XFActivity *worksActivity = [MainActivity childViewControllers][XF_Index_Second];
    collectActivity.view.frame = worksActivity.view.bounds;
    [LEGORealInterface(self.realInterface) transitionFromViewController:worksActivity toViewController:collectActivity duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
    } completion:^(BOOL finished) {
    }];
}

- (void)switch2WorksSubRoute
{
    XFActivity *collectActivity = [MainActivity childViewControllers][XF_Index_First];
    XFActivity *worksActivity = [MainActivity childViewControllers][XF_Index_Second];
    worksActivity.view.frame = collectActivity.view.bounds;
    [LEGORealInterface(self.realInterface) transitionFromViewController:collectActivity toViewController:worksActivity duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dealloc
{
    XF_Debug_M();
}

@end
