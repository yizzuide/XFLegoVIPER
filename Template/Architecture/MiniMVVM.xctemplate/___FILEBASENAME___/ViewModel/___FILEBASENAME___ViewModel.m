//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

#import "___VARIABLE_productName:identifier___ViewModel.h"
#import "___VARIABLE_productName:identifier___ViewController.h"

#define View LEGORealPort(___VARIABLE_productName:identifier___ViewController *, self.view)

@interface ___VARIABLE_productName:identifier___ViewModel ()

@end

@implementation ___VARIABLE_productName:identifier___ViewModel

#pragma mark - lifeCycle
// 绑定视图层后调用
- (void)viewDidLoad
{
    // 解构URL参数
    //    NSInteger userID = self.URLParams[@"id"];
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
