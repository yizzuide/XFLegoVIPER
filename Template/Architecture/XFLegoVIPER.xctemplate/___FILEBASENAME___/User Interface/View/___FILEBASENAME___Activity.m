//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

#import "___FILEBASENAME___Activity.h"
#import "___FILEBASENAME___EventHandlerPort.h"

#define EventHandler  XFConvertPresenterToType(id<___FILEBASENAMEASIDENTIFIER___EventHandlerPort>)

@interface ___FILEBASENAMEASIDENTIFIER___Activity ()

@end

@implementation ___FILEBASENAMEASIDENTIFIER___Activity

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 配置当前视图
    [self config];
    // 初始化视图
    [self setUpViews];
    // 绑定视图数据
    [self bindViewData];
}

#pragma mark - 初始化
- (void)config {
    
}

- (void)setUpViews {
    
}

- (void)bindViewData {
    // 双向数据绑定
    //XF_$_(self.textField, text, EventHandler, text)
    // 绑定事件层按钮命令
    //XF_C_(self.btn, EventHandler, Command)
    
    // load or reset expressPack
    /*XF_Define_Weak
    [RACObserve(self.eventHandler, expressPack) subscribeNext:^(id x) {
        XF_Define_Strong
        // 如果有显示数据加载完成
        if (x) {
            [self.tableView reloadData];
        }
    }];*/
}


#pragma mark - Change UI Action


#pragma mark - UIControlDelegate


#pragma mark - Getter



@end
