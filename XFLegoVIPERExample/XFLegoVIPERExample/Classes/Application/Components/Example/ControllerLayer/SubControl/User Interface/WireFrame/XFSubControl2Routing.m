//
//  XFSubControl2Routing.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2016/10/4.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFSubControl2Routing.h"
#import "XFCollectRouting.h"
#import "XFWorksRouting.h"
#import "XFSubControl2Presenter.h"
#import "XFActivity.h"

@interface XFSubControl2Routing ()

@property (nonatomic, weak) UIView *hostView;
@end

@implementation XFSubControl2Routing

//XF_InjectModuleWith_IB(@"x-XFSubControl2Activity", [XFSubControl2Presenter class], nil, nil)
//XF_AutoAssemblyModule_FastIB(@"x-XFSubControl2Activity")
XF_AutoAssemblyModule_Fast

- (__kindof id<XFUserInterfacePort>)_collectInterfaceFromLoadSubRoutes
{
    XFWorksRouting *worksRouting = [XFWorksRouting assembleRouting];
    [self addSubRouting:worksRouting asChildViewController:YES];
    XFCollectRouting *collectRouting = [XFCollectRouting assembleRouting];
    [self addSubRouting:collectRouting asChildViewController:YES];
    return collectRouting.realUInterface;
}

- (void)fluctuate2CollectSubRouteWithHostView:(UIView *)hostView
{
    self.hostView = hostView;
    XFActivity *collectActivity = [self _collectInterfaceFromLoadSubRoutes];
    [hostView addSubview: collectActivity.view];
    collectActivity.view.frame = hostView.bounds;
}

- (void)switch2CollectSubRoute
{
    [self.hostView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    XFActivity *collectActivity = [MainActivity childViewControllers][XF_Index_Second];
    [self.hostView addSubview: collectActivity.view];
    collectActivity.view.frame = self.hostView.bounds;
    CATransition *anim = [CATransition animation];
    anim.type = @"cube";
    anim.subtype = kCATransitionFromRight;
    anim.duration = 0.5;
    [self.hostView.layer addAnimation:anim forKey:nil];
}

- (void)swith2WorksSubRoute
{
    [self.hostView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    XFActivity *worksActivity = [MainActivity childViewControllers][XF_Index_First];
    [self.hostView addSubview: worksActivity.view];
    worksActivity.view.frame = self.hostView.bounds;
    CATransition *anim = [CATransition animation];
    anim.type = @"cube";
    anim.subtype = kCATransitionFromLeft;
    anim.duration = 0.5;
    [self.hostView.layer addAnimation:anim forKey:nil];
}

@end
