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
#import <objc/runtime.h>

static char *kCompNameKey = "compName";
static char *kIntentDataKey = "intentData";
@implementation LEMVVMConnector

+ (id<XFComponentRoutable>)makeComponentFromUInterface:(UIViewController<LEMVVMIntent> *)viewController
{
    NSString *inspectComponentName = [XFComponentReflect componentNameForComponent:(id)viewController];
    NSString *classPrefix = [XFModuleReflect inspectModulePrefixWithModule:inspectComponentName stuffixName:@"ViewModel"];
    NSString *viewModelClassName = [NSString stringWithFormat:@"%@%@ViewModel", classPrefix, inspectComponentName];
    Class viewModelClass = NSClassFromString(viewModelClassName);
    id  _Nullable dataDirver = [viewController valueForKey:@"dataDriver"];
    if (viewModelClass && !dataDirver) {
        LEViewModel<XFComponentRoutable> *viewModel = [[viewModelClass alloc] init];
        id dynamicIntentData = objc_getAssociatedObject(viewController, kIntentDataKey);
        // 如果有自定义的意图数据
        if ([viewController respondsToSelector:@selector(intentData)] &&
            viewController.intentData) {
            viewModel.intentData = viewController.intentData;
        } else if (dynamicIntentData) {
            viewModel.intentData = dynamicIntentData;
        }
        // 绑定层关系
        [viewController setValue:viewModel forKeyPath:@"dataDriver"];
        [viewModel.uiBus setUInterface:viewController];
        
        NSString *dynamicCompName = objc_getAssociatedObject(viewController, kCompNameKey);
        // 是否有自定义的组件名
        if ([viewController respondsToSelector:@selector(compName)] &&
             viewController.compName.length) { // 通过协议实现
            [XFComponentManager addComponent:viewModel forName:viewController.compName];
        } else if (dynamicCompName && dynamicCompName.length) { // 通过Objc动态属性
            [XFComponentManager addComponent:viewModel forName:dynamicCompName];
        } else { // 使用自动检测的组件名添加
            [XFComponentManager addComponent:viewModel forName:inspectComponentName];
        }
        return viewModel;
    }
    return dataDirver;
}

+ (id<XFComponentRoutable>)makeComponentFromUInterface:(UIViewController<LEMVVMIntent> *)viewController forName:(NSString *)componentName
{
    return [self makeComponentFromUInterface:viewController forName:componentName intentData:nil];
}

+ (id<XFComponentRoutable>)makeComponentFromUInterface:(UIViewController<LEMVVMIntent> *)viewController forName:(NSString *)componentName intentData:(id)intentData
{
    if (!componentName && !intentData) {
        return [self makeComponentFromUInterface:viewController];
    }
    
    if (componentName && componentName.length) {
        // 给控制器动态添加一个属性
        objc_setAssociatedObject(viewController, kCompNameKey, componentName, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    if (intentData) {
        objc_setAssociatedObject(viewController, kIntentDataKey, intentData, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return [self makeComponentFromUInterface:viewController];
}
@end
