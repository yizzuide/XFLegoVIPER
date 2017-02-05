//
//  LEMVVMModuleHandler.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/28.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "LEMVVMModuleHandler.h"
#import "NSObject+XFLegoInvokeMethod.h"
#import "UIViewController+ComponentBridge.h"
#import "LEMVVMModuleReflect.h"
#import "UIViewController+LEView.h"
#import "LEMVVMModuleFactory.h"
#import "XFLegoMarco.h"
#import "LEDataDriverProtocol.h"


@implementation LEMVVMModuleHandler

+ (BOOL)matchComponent:(id)component
{
    if ([component isKindOfClass:[NSString class]]) {
        return [LEMVVMModuleReflect verifyModuleName:component];
    }
    return [component respondsToSelector:@selector(view)] && ![component respondsToSelector:@selector(parentViewController)];
}

+ (BOOL)matchUInterface:(UIViewController *)uInterface
{
    return [uInterface dataDriver];
}

+ (id<XFComponentRoutable>)createComponentFromName:(NSString *)componentName
{
    LEViewModel<XFComponentRoutable> *viewModel = [LEMVVMModuleFactory createViewModelFromModuleName:componentName];
    NSString *uInterfaceClazzName = [NSString stringWithFormat:@"%@%@%@",XF_Class_Prefix,componentName,@"ViewController"];
    UIViewController<LEViewProtocol> *uInterface = [[NSClassFromString(uInterfaceClazzName) alloc] init];
    [uInterface setValue:viewModel forKeyPath:@"dataDriver"];
    [viewModel.uiBus setUInterface:uInterface];
    return viewModel;
}

+ (NSString *)componentNameFromComponent:(id<XFComponentRoutable>)component
{
    return [LEMVVMModuleReflect moduleNameForViewModel:(id)component];
}

+ (UIViewController *)uInterfaceForComponent:(__kindof id<XFComponentRoutable>)component
{
    return (id)[[component uiBus] uInterface] ?: [component view];
}

+ (id<XFComponentRoutable>)componentForUInterface:(UIViewController *)uInterface
{
    return [uInterface dataDriver];
}

+ (id<XFComponentRoutable>)component:(__kindof id<XFComponentRoutable>)component createNextComponentFromName:(NSString *)componentName
{
    return [self createComponentFromName:componentName];
}

+ (void)willRemoveComponent:(__kindof id<XFComponentRoutable>)component
{
}

+ (void)willReleaseComponent:(__kindof id<XFComponentRoutable>)component
{
}

@end
