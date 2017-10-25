//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

#import "___VARIABLE_productName:identifier___Presenter.h"
#import "___VARIABLE_productName:identifier___WireframePort.h"
#import "___VARIABLE_productName:identifier___UserInterfacePort.h"
#import "___VARIABLE_productName:identifier___InteractorPort.h"
//#import "ReactiveCocoa.h"


#define Interactor XFConvertInteractorToType(id<___VARIABLE_productName:identifier___InteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<___VARIABLE_productName:identifier___UserInterfacePort>)
#define Routing XFConvertRoutingToType(id<___VARIABLE_productName:identifier___WireFramePort>)

@interface ___VARIABLE_productName:identifier___Presenter ()

@end

@implementation ___VARIABLE_productName:identifier___Presenter

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
    // 填充绑定的ViewData
    //self.viewData = [Interactor fetchData];
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


// 接受到MVx构架通知或XFLegoVIPER模块的事件
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    // 匹配对应通知
    /*XF_EventIs_(XFUserDidLoginNotifaction, {
        // TODO
    })*/
}

#pragma mark - DoAction



#pragma mark - ValidData


@end
