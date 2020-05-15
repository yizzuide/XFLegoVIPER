//
//  XFSubControl2Presenter.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2016/10/4.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFSubControl2Presenter.h"
#import "XFSubContol2WireframePort.h"
#import "ReactiveCocoa.h"

#define Routing XFConvertRoutingToType(id<XFSubContol2WireframePort>)

@implementation XFSubControl2Presenter

- (void)viewDidLoad
{
    [self initCommand];
}

- (void)initCommand
{
    XF_CEXE_Begin
    XF_CEXE_(self.collectCommand, {
        [Routing switch2CollectSubRoute];
    })
    XF_CEXE_(self.worksCommand, {
        [Routing swith2WorksSubRoute];
    })
}

- (void)requireLoadCollectViewForHostView:(UIView *)hostView
{
    [Routing fluctuate2CollectSubRouteWithHostView:hostView];
}
@end
