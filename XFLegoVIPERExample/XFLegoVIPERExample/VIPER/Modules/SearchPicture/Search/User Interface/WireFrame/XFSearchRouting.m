//
//  XFSearchRouting.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/26.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFSearchRouting.h"
#import "XFSearchActivity.h"
#import "XFSearchPresenter.h"
#import "XFSearchInteractor.h"
#import "XFPictureDataManager.h"
#import "XFPictureResultsRouting.h"

@implementation XFSearchRouting

+ (instancetype)routing
{
    return [[super routing] buildModulesAssemblyWithActivityClass:[XFSearchActivity class] navigatorClass:[UINavigationController class] presenterClass:[XFSearchPresenter class] interactorClass:[XFSearchInteractor class] dataManagerClass:[XFPictureDataManager class]];
}

- (void)transitionToShowResultsMoudle {
    XFPictureResultsRouting *routing = [XFPictureResultsRouting routing];
    [self pushRouting:routing intent:self.uiOperator.intentData];
}
@end
