//
//  XFPictureResultsRouting.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPictureResultsRouting.h"
#import "XFPictureResultsActivity.h"
#import "XFPictureResultsPresenter.h"
#import "XFPictureResultsInteractor.h"
#import "XFDetailsRouting.h"
#import "XFSubControlRouting.h"
#import "XFSubControl2Routing.h"
#import "XFPageControlRouting.h"
#import "XFPictureDataManager.h"

@implementation XFPictureResultsRouting

XF_JnjectMoudleWith_Act(XF_Class_(XFPictureResultsActivity),
                        XF_Class_(XFPictureResultsPresenter),
                        XF_Class_(XFPictureResultsInteractor),
                        XF_Class_(XFPictureDataManager))

- (void)transitionToDetailsMoudle
{
    XF_PUSH_Routing_Fast(XFDetailsRouting)
}

- (void)transitionToSubControlMoudle
{
    XF_PUSH_Routing_Fast(XFSubControlRouting)
}

- (void)transitionToSubControl2Moudle
{
    XF_PUSH_Routing_Fast(XFSubControl2Routing)
}

- (void)transitionToPageControlMoudle
{
    XF_PUSH_Routing_Fast(XFPageControlRouting)
}



- (void)dealloc
{
    NSLog(@"%s",__func__);
}
@end
