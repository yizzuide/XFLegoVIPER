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
        [LEMVVMConnector makeComponentFromUInterface:viewController];
    }
    [super pushViewController:viewController animated:animated];
}
@end
