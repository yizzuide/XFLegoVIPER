//
//  LEVMNavigationController.m
//  TZEducation
//
//  Created by Yizzuide on 2017/9/26.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "LEMVVMNavigationController.h"
#import "LEMVVMConnector.h"
#import "LEMVVMIntent.h"

@interface LEMVVMNavigationController ()

@end

@implementation LEMVVMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController<LEMVVMIntent> *)viewController animated:(BOOL)animated
{
    NSString *className = NSStringFromClass([viewController class]);
    if ([className containsString:@"ViewController"]) {
        id<XFComponentRoutable> componentRoutable;
        // 是否有自定义的组件名
        if ([viewController respondsToSelector:@selector(compName)] &&
            viewController.compName.length) {
             componentRoutable = [LEMVVMConnector makeComponentFromUInterface:viewController forName:viewController.compName];
        } else {
            // 否则就用框架自动检测功能
            componentRoutable = [LEMVVMConnector makeComponentFromUInterface:viewController];
        }
        if ([viewController respondsToSelector:@selector(intentData)] &&
            viewController.intentData) {
            componentRoutable.intentData = viewController.intentData;
        }
    }
    [super pushViewController:viewController animated:animated];
}
@end
