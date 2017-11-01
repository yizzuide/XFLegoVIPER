//
//  LEVMContainer.m
//  TZEducation
//
//  Created by Yizzuide on 2017/9/29.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "LEMVVMConnector.h"
#import "XFLegoVIPER.h"
#import "UIViewController+LEView.h"
#import "LEViewModel.h"
#import "XFModuleReflect.h"
#import "LEMVVMIntent.h"

@implementation LEMVVMConnector

+ (id<XFComponentRoutable>)makeComponentFromUInterface:(UIViewController<LEMVVMIntent> *)viewController
{
    NSString *componentName = [XFComponentReflect componentNameForComponent:(id)viewController];
    NSString *classPrefix = [XFModuleReflect inspectModulePrefixWithModule:componentName stuffixName:@"ViewModel"];
    NSString *viewModelClassName = [NSString stringWithFormat:@"%@%@ViewModel", classPrefix, componentName];
    Class viewModelClass = NSClassFromString(viewModelClassName);
    if (viewModelClass && ![viewController valueForKey:@"dataDriver"]) {
        LEViewModel<XFComponentRoutable> *viewModel = [[viewModelClass alloc] init];
        if ([viewController respondsToSelector:@selector(intentData)] &&
            viewController.intentData) {
            viewModel.intentData = viewController.intentData;
        }
        [viewController setValue:viewModel forKeyPath:@"dataDriver"];
        [viewModel.uiBus setUInterface:viewController];
        [XFComponentManager addComponent:viewModel enableLog:NO];
        return viewModel;
    }
    return nil;
}

+ (id<XFComponentRoutable>)makeComponentFromUInterface:(UIViewController<LEMVVMIntent> *)viewController forName:(NSString *)componentName
{
    NSString *inspectComponentName = [XFComponentReflect componentNameForComponent:(id)viewController];
    NSString *classPrefix = [XFModuleReflect inspectModulePrefixWithModule:inspectComponentName stuffixName:@"ViewModel"];
    NSString *viewModelClassName = [NSString stringWithFormat:@"%@%@ViewModel", classPrefix, inspectComponentName];
    Class viewModelClass = NSClassFromString(viewModelClassName);
    if (viewModelClass && ![viewController valueForKey:@"dataDriver"]) {
        LEViewModel<XFComponentRoutable> *viewModel = [[viewModelClass alloc] init];
        if ([viewController respondsToSelector:@selector(intentData)] &&
            viewController.intentData) {
            viewModel.intentData = viewController.intentData;
        }
        [viewController setValue:viewModel forKeyPath:@"dataDriver"];
        [viewModel.uiBus setUInterface:viewController];
        [XFComponentManager addComponent:viewModel forName:componentName];
        return viewModel;
    }
    return nil;
}
@end
