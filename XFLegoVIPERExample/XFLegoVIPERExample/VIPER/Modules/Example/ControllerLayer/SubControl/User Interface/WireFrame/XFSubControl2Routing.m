//
//  XFSubControl2Routing.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/4.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFSubControl2Routing.h"
#import "XFCollectRouting.h"
#import "XFWorksRouting.h"
#import "XFSubControl2Presenter.h"

@interface XFSubControl2Routing ()

@property (nonatomic, weak) UIView *hostView;
@end

@implementation XFSubControl2Routing

XF_InjectMoudleWith_IB(@"x-XFSubControl2Activity", [XFSubControl2Presenter class], nil, nil)

- (__kindof id<XFUserInterfacePort>)_collectInterfaceFromLoadSubRoutes
{
    XFWorksRouting *worksRouting = [XFWorksRouting routing];
    [self addSubRouting:worksRouting asChildInterface:YES];
    XFCollectRouting *collectRouting = [XFCollectRouting routing];
    return [self addSubRouting:collectRouting asChildInterface:YES];
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
