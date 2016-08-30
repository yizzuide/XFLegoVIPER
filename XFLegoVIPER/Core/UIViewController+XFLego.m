//
//  UIViewController+XFLego.m
//  XFLegoVIPER
//
//  Created by yizzuide on 16/2/24.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "UIViewController+XFLego.h"
#import <objc/runtime.h>
#import "NSObject+XFLegoInvokeMethod.h"

@implementation UIViewController (XFLego)

static void * xfActivity_eventHandler_porpertyKey = (void *)@"xfActivity_eventHandler_porpertyKey";

- (void)setEventHandler:(id<XFEventHandlerPort>)eventHandler
{
    objc_setAssociatedObject(self, &xfActivity_eventHandler_porpertyKey, eventHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id<XFEventHandlerPort>)eventHandler
{
    return objc_getAssociatedObject(self, &xfActivity_eventHandler_porpertyKey);
}

// 处理pop返回事件
void didBackButtonPressed(id self, SEL _cmd)
{
    [[self eventHandler] requirePopModule];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)viewDidLoad
{
    // 如果当前控制器是在当前架构
    if (self.eventHandler) {
        // 绑定当前视图引用到事件处理
        [self invokeMethod:@"bindView:" param:self forObject:self.eventHandler];
        
        // 绑定成功调用初始化完成方法
        [self invokeMethod:@"viewDidLoad" param:nil forObject:self.eventHandler];
        
        // 添加拦截导航栏点击Item的pop返回事件方法，`backButtonPressed`用于自定义处理返回
        SUPPRESS_UNDECLARED_SELECTOR_LEAK_WARNING(
                // "v@:@",解释v-返回值void类型,@-self指针id类型,:-SEL指针SEL类型,,@-函数第一个参数为id类型
            class_addMethod([self class], @selector(backButtonPressed), (IMP)didBackButtonPressed, "v@:")
        )
    }
}
#pragma clang diagnostic pop

@end