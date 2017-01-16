//
//  XFSearchRouting.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/26.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFSearchRouting.h"
#import "XFPictureResultsRouting.h"

@implementation XFSearchRouting

/* 如果没有UINavigationController这个嵌套，可以传nil，或使用不带navigatorClass参数的方法，
 除了ActivityClass必传外，其它都可以传空，这种情况适用于对MVC等其它架构的过渡*/
/*XF_InjectModuleWith_Nav([UINavigationController class],
                        [XFSearchActivity class],
                        [XFSearchPresenter class],
                        [XFSearchInteractor class],
                        [XFPictureDataManager class])*/
// 自动组装方式
//XF_AutoAssemblyModuleWithNav_ShareDM(@"UI", @"PictureResults") // 这里的组装导航器已移入URL参数
XF_AutoAssemblyModule_ShareDM(@"PictureResults") // 使用共享DataManager方式

- (void)transition2PictureResults {
    XF_PUSH_URLComponent_(@"xf://search/pictureResults", {
        // 自定义切换动画
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeOut"];
        //animation.type = kCATransitionPush;
        //animation.subtype = kCATransitionFromBottom;
        
//         animation.type = @"cube";//立方体效果
//         animation.type = @"suckEffect";//收缩效果
//         animation.type = @"oglFlip";//上下翻转效果
         animation.type = @"rippleEffect";//滴水效果
//         animation.type = @"pageCurl";//向上翻一页效果
//         animation.type = @"pageUnCurl";//向下翻一页效果
        
        [self.realNavigator.view.layer addAnimation:animation forKey:@"animation"];
    })
}

- (void)transition2Message
{
    // 使用保留行为参数字段"nav",可以指定要装配的导航控制器，值为类前缀且一定是全大写
    // UI为UINavigationController
//    XF_Present_URLComponent_Fast(@"xf://search/message?nav=UI");
    // 使用自定义导航控制器类型（XFNavigationController）
    XF_Present_URLComponent_Fast(@"xf://search/message?nav=XF");
}
@end
