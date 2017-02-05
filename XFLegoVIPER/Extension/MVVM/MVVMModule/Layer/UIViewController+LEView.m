//
//  UIViewController+LEView.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2017/1/29.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "UIViewController+LEView.h"
#import <objc/runtime.h>
#import "NSObject+XFLegoSwizzle.h"
#import "NSObject+XFLegoInvokeMethod.h"


@implementation UIViewController (LEView)

- (void)setDataDriver:(__kindof id<LEDataDriverProtocol>)dataDriver
{
    objc_setAssociatedObject(self, @selector(dataDriver), dataDriver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (__kindof id<LEDataDriverProtocol>)dataDriver
{
    return objc_getAssociatedObject(self, _cmd);
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self xfLego_swizzleMethod:@selector(viewDidLoad) withMethod:@selector(le_viewDidLoad)];
        [self xfLego_swizzleMethod:@selector(viewWillDisappear:) withMethod:@selector(le_viewWillDisappear:)];
    });
}

- (void)le_viewDidLoad
{
    [self le_viewDidLoad];
    // 绑定视图层
    [self.dataDriver setValue:self forKey:@"view"];
    [self.dataDriver invokeMethod:@"le_viewDidLoad"];
}

- (void)le_viewWillDisappear:(BOOL)animated
{
    [self le_viewWillDisappear:animated];
    if (!self.dataDriver) return;
    // 如果当前视图被pop或dismiss
    if (self.isMovingFromParentViewController ||
        self.isBeingDismissed ||
        self.navigationController.isMovingToParentViewController ||
        self.navigationController.isBeingDismissed) {
        // 如果不是通过框架方法
        if ([[self valueForKeyPath:@"poppingProgrammatically"] boolValue]) return;
        [self.dataDriver invokeMethod:@"le_viewWillDisappear"];
    }
}




@end
