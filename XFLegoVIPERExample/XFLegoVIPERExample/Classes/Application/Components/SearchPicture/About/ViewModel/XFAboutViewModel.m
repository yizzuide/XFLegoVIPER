//
//  XFAboutViewModel.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2017/11/9.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "XFAboutViewModel.h"
#import "XFAboutViewController.h"
#import "XFComponentManager.h"

#define View LEGORealPort(XFAboutViewController *, self.view)

// 解决模拟器无法打印，修改仅针对开发模式生效
#ifndef __OPTIMIZE__
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#endif

@interface XFAboutViewModel ()

@end

@implementation XFAboutViewModel

#pragma mark - lifeCycle
// 绑定视图层后调用
- (void)viewDidLoad
{
    // 解构URL参数
    //    NSInteger userID = self.URLParams[@"id"];
    id comp = [XFComponentManager findComponentForName:@"about"];
    NSLog(@"find comp: %@", comp);
    
    NSLog(@"intentData: %@", self.intentData);
}

// 初始化视图数据
- (void)initRenderView
{
    
}

// 初始化命令
- (void)initCommand
{
    /*XF_CEXE_Begin
     // 当命令触发时执行代码
     XF_CEXE_(self.command, {
     // TODO
     })*/
}

// 接收到组件返回数据
- (void)onNewIntent:(id)intentData
{
    
}

// 注册MVx通知
- (void)registerMVxNotifactions
{
    // 注册MVx构架通知
    //    XF_RegisterMVxNotis_(XFUserDidLoginNotifaction)
}


// 接受到MVx构架通知或组件的事件
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    // 匹配对应通知
    /*XF_EventIs_(XFUserDidLoginNotifaction, {
     // TODO
     })*/
}

#pragma mark - DoAction



#pragma mark - ValidData



#pragma mark - FetchData


#pragma mark - Formatter data
@end
