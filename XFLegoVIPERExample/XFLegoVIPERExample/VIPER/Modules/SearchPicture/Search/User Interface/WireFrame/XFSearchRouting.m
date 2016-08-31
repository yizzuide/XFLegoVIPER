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
    /**
     *  如果没有UINavigationController这个嵌套，可以传nil，或使用不带navigatorClass参数的方法
     *  除了ActivityClass必传外，其它都可以传空，这种情况适用于对MVC等其它架构的过渡
     */
    return [[super routing] buildModulesAssemblyWithActivityClass:[XFSearchActivity class]
                                                   navigatorClass:[UINavigationController class]
                                                   presenterClass:[XFSearchPresenter class]
                                                  interactorClass:[XFSearchInteractor class]
                                                 dataManagerClass:[XFPictureDataManager class]];
}

- (void)transitionToShowResultsMoudle {
    XFPictureResultsRouting *routing = [XFPictureResultsRouting routing];
    // 使用intentData传递意图数据
    [self pushRouting:routing intent:self.uiOperator.intentData];
}
@end
