//
//  XFSettingViewController.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2017/2/5.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "LGSettingViewController.h"
#import "LGSettingViewModel.h"

#define ViewModel  LEGORealPort(LGSettingViewModel *, self.dataDriver)
@interface LGSettingViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;


@end

@implementation LGSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"我的设置";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:217/255.0 green:108/255.0 blue:0/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    [self.startButton addTarget:ViewModel action:@selector(startButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.pauseButton addTarget:ViewModel action:@selector(pauseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.restartButton addTarget:ViewModel action:@selector(restartButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.stopButton addTarget:ViewModel action:@selector(stopButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)dealloc
{
    XF_Debug_M()
}

@end
