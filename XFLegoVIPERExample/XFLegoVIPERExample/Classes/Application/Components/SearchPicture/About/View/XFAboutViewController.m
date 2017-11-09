//
//  XFAboutViewController.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2017/11/9.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "XFAboutViewController.h"
#import "UIViewController+LEView.h"
#import "XFAboutViewModel.h"

#define ViewModel  LEGORealPort(XFAboutViewModel *, self.dataDriver)

@interface XFAboutViewController ()

@end

@implementation XFAboutViewController

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
    self.title = @"关于";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:217/255.0 green:108/255.0 blue:0/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setUpViews {
    
}

- (void)bindViewData {
    // 双向数据绑定
    //XF_$_(self.textField, text, DataDriver, text)
    // 绑定事件层按钮命令
    //XF_C_(self.btn, DataDriver, Command)
    
    // load or reset expressPack
    /*XF_Define_Weak
     [RACObserve(self.dataDriver, expressData) subscribeNext:^(id x) {
     XF_Define_Strong
     // 如果有显示数据加载完成
     if (x) {
     [self.tableView reloadData];
     }
     }];*/
}


#pragma mark - Change UI State


#pragma mark - UIControlDelegate


#pragma mark - Getter

@end
