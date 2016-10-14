//
//  XFSubControlPresenter.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFSubControlPresenter.h"
#import "XFSubControlWrieframePort.h"
#import "ReactiveCocoa.h"

#define Routing XFConvertRoutingToType(id<XFSubControlWrieframePort>)

@implementation XFSubControlPresenter

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
        [Routing switch2WorksSubRoute];
    })
}

- (UIView *)requireCollectView
{
    return [Routing fluctuate2CollectSubRoutes];
}

- (void)dealloc
{
    XF_Debug_M();
}
@end
