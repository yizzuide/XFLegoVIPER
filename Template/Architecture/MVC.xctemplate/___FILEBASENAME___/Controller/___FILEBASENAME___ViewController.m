//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

#import "___FILEBASENAME___ViewController.h"

@interface ___FILEBASENAMEASIDENTIFIER___ViewController ()

@end

@implementation ___FILEBASENAMEASIDENTIFIER___ViewController

// 把控制器导出为组件
XF_EXPORT_COMPONENT

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 配置当前视图
    [self config];
    // 初始化视图
    [self setUpViews];
}

#pragma mark - 初始化
- (void)config {
    
}

- (void)setUpViews {
    
}


#pragma mark - LifeCycle
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


#pragma mark - Change UI Action


#pragma mark - UIControlDelegate


#pragma mark - Getter

@end
