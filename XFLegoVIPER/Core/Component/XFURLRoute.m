//
//  XFURLRoute.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/7.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFURLRoute.h"
#import "XFURLParse.h"
#import "XFLegoMarco.h"
#import "XFControllerFactory.h"
#import "XFRoutingLinkManager.h"
#import "XFRoutingReflect.h"

@implementation XFURLRoute

static NSMutableDictionary<NSString *,NSString *> *URLRouteTable_;

+ (void)initialize
{
    if (self == [XFURLRoute class]) {
        URLRouteTable_ = @{}.mutableCopy;
    }
}

+ (void)initURLGroup:(id)urlGroup {
    if ([urlGroup isKindOfClass:[NSDictionary class]]) {
        [URLRouteTable_ setDictionary:urlGroup];
    } else if([urlGroup isKindOfClass:[NSArray class]]) {
        for (NSString *url in urlGroup) {
            [self register:url];
        }
    } else {
        NSAssert(NO, @"参数必需是NSDictionary类型或NSArray类型！");
    }
}

// xf://user/register?usrid=123
+ (void)register:(NSString *)url
{
    NSString *lcComponentName = [XFURLParse lastPathComponentForURL:url];
    if (lcComponentName.length > 2) {
        NSString *componentName = [NSString stringWithFormat:@"%@%@",[lcComponentName substringToIndex:XF_Index_Second].uppercaseString,[lcComponentName substringFromIndex:XF_Index_Second]];
        [self register:url forComponent:componentName];
    } else {
        [self register:url forComponent:lcComponentName.uppercaseString];
    }
}

+ (void)register:(NSString *)url forComponent:(NSString *)componentName
{
    // 验证是否是控制器组件
    if ([XFControllerFactory isViewControllerComponent:componentName]){
        [URLRouteTable_ setObject:componentName forKey:url];
    }else{
        NSAssert([XFRoutingReflect verifyModule:componentName], @"模块验证失败！找不到此模块！");
        [URLRouteTable_ setObject:componentName forKey:url];
    }
}

+ (void)remove:(NSString *)url
{
    [URLRouteTable_ removeObjectForKey:url];
}

+ (BOOL)open:(NSString *)url transitionBlock:(void(^)(NSString *componentName,NSDictionary *params))transitionBlock
{
    NSString *path = [XFURLParse pathForURL:url];
    NSString *componentName = [URLRouteTable_ objectForKey:path];
    NSAssert(componentName || ![componentName isEqualToString:@""], @"当前URL组件未注册！");
    NSDictionary *params;
    if ([url hasPrefix:@"http"])
        params = @{@"url":url};
    else
        params = [XFURLParse paramsForURL:url];
    if (transitionBlock)
        transitionBlock(componentName,params);
    
    // 检测组件是否存在
    if ([XFControllerFactory isViewControllerComponent:componentName]) return YES;
    if (![XFRoutingReflect verifyModule:componentName]) {
        NSAssert(NO, @"当前URL组件名加载错误，请检查组件名是否正确！");
        return NO;
    }
    
    // 异步检测URL路径的正确性
    if ([XFRoutingLinkManager count]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray *allComps = [XFURLParse allComponentsForURL:url];
            NSMutableArray *modules = @[].mutableCopy;
            for (NSString *comp in allComps) {
                NSString *moduleName = [NSString stringWithFormat:@"%@%@",[comp substringToIndex:XF_Index_Second].uppercaseString,[comp substringFromIndex:XF_Index_Second]];
                [modules addObject:moduleName];
            }
            BOOL isURLComponentLinkOk = [XFRoutingReflect verifyModuleLinkForList:modules];
            NSAssert(isURLComponentLinkOk, @"URL子路径关系链错误！");
        });
    }
    return YES;
}
@end
