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
#import "XFRoutingLinkManager.h"
#import "XFRoutingReflect.h"
#import "XFComponentReflect.h"

@implementation XFURLRoute

/**
 *  URL列表
 */
static NSMutableDictionary<NSString *,NSString *> *URLRouteTable_;
/**
 *  URL处理者列表
 */
static NSMutableDictionary<NSString *,NSString *> *URLHandler_;

+ (void)initialize
{
    if (self == [XFURLRoute class]) {
        URLRouteTable_ = @{}.mutableCopy;
        URLHandler_ = @{}.mutableCopy;
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
    [URLRouteTable_ setObject:componentName forKey:url];
}

+ (void)remove:(NSString *)url
{
    [URLRouteTable_ removeObjectForKey:url];
}

+ (void)setHTTPHandlerComponent:(NSString *)componentName
{
    [URLHandler_ setObject:componentName forKey:@"http"];
}

+ (BOOL)open:(NSString *)url transitionBlock:(void(^)(NSString *componentName,NSDictionary *params))transitionBlock
{
    NSString *path = [XFURLParse pathForURL:url];
    NSString *componentName = [URLRouteTable_ objectForKey:path];
    NSDictionary *params;
    if ([url hasPrefix:@"http"]) {
        NSString *httpHandlerComponent = [URLHandler_ objectForKey:@"http"];
        if (!httpHandlerComponent) {
            NSAssert(NO, @"当前URL没有设置处理HTTP类型的组件！");
            return NO;
        }
        componentName = httpHandlerComponent;
        params = @{@"url":url};
    } else {
        params = [XFURLParse paramsForURL:url];
    }
    // 组件是否存在
    if (!componentName || [componentName isEqualToString:@""]) {
        NSAssert(NO, @"当前URL组件未注册！");
        return NO;
    }
    // 开始切换组件
    if (transitionBlock)
        transitionBlock(componentName,params);
    
    // 检测组件是否存在
    if ([XFComponentReflect isControllerComponent:componentName]) return YES;
    if (![XFComponentReflect isModuleComponent:componentName]) {
        NSAssert(NO, @"当前URL组件名加载错误，请检查组件名是否正确！");
        return NO;
    }
    
    // 异步检测URL路径的正确性
    if (verifyURLRoute_ && [XFRoutingLinkManager count]) {
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


static BOOL verifyURLRoute_;
+ (void)enableVerifyURLRoute
{
    verifyURLRoute_ = YES;
}
@end
