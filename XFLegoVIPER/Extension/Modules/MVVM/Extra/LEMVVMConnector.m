//
//  LEVMContainer.m
//  TZEducation
//
//  Created by Yizzuide on 2017/9/29.
//  Copyright © 2017年 CBY. All rights reserved.
//

#import "LEMVVMConnector.h"
#import "XFLegoVIPER.h"
#import "UIViewController+LEView.h"
#import "LEViewModel.h"

@implementation LEMVVMConnector

+ (id<XFComponentRoutable>)makeComponentFromUInterface:(UIViewController *)viewController
{
    NSString *componentName = [XFComponentReflect componentNameForComponent:(id)viewController];
    NSString *viewModelClassName = [NSString stringWithFormat:@"%@%@ViewModel", XFLegoConfig.shareInstance.classPrefix, componentName];
    Class viewModelClass = NSClassFromString(viewModelClassName);
    if (viewModelClass && ![viewController valueForKey:@"dataDriver"]) {
        LEViewModel<XFComponentRoutable> *viewModel = [[viewModelClass alloc] init];
        [viewController setValue:viewModel forKeyPath:@"dataDriver"];
        [viewModel.uiBus setUInterface:viewController];
        [XFComponentManager addComponent:viewModel enableLog:NO];
        return viewModel;
    }
    return nil;
}

+ (id<XFComponentRoutable>)makeComponentFromUInterface:(UIViewController *)viewController forName:(NSString *)componentName
{
    NSString *inspectComponentName = [XFComponentReflect componentNameForComponent:(id)viewController];
    NSString *viewModelClassName = [NSString stringWithFormat:@"%@%@ViewModel", XFLegoConfig.shareInstance.classPrefix, inspectComponentName];
    Class viewModelClass = NSClassFromString(viewModelClassName);
    if (viewModelClass && ![viewController valueForKey:@"dataDriver"]) {
        LEViewModel<XFComponentRoutable> *viewModel = [[viewModelClass alloc] init];
        [viewController setValue:viewModel forKeyPath:@"dataDriver"];
        [viewModel.uiBus setUInterface:viewController];
        [XFComponentManager addComponent:viewModel forName:componentName];
        return viewModel;
    }
    return nil;
}
@end
