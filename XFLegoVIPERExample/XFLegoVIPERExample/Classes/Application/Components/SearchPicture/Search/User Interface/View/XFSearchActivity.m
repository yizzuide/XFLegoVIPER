//
//  XFSearchActivity.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/26.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFSearchActivity.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "XFSearchEventHandlerPort.h"

@interface XFSearchActivity ()

@property (weak, nonatomic) IBOutlet UITextField *mainCategoryTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondCategoryTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *showMessageButton;
@property (weak, nonatomic) IBOutlet UIButton *showSettingButton;



@end

@implementation XFSearchActivity

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setSubViews];
    [self bindViewData];
}

- (void)setSubViews
{
    self.mainCategoryTextField.tintColor = [UIColor orangeColor];
    self.secondCategoryTextFiled.tintColor = [UIColor orangeColor];
}

- (void)bindViewData
{
    id<XFSearchEventHandlerPort> presenter = XFConvertPresenterToType(id<XFSearchEventHandlerPort>);
    RAC(self,title) = RACObserve(presenter, navigationTitle);
    RAC(presenter, mainCategory) = self.mainCategoryTextField.rac_textSignal;
    RAC(presenter, secondCategory) = self.secondCategoryTextFiled.rac_textSignal;
    // 绑定命令
    XF_C_(self.searchButton, presenter, executeSearch)
    XF_C_(self.showMessageButton, presenter, showMessageCommand)
    XF_C_(self.showSettingButton, presenter, showSettingCommand)
    

    // 绑定信号执行状态: 命令执行状态信号，初始时有一个非执行状态信号，执行命令后又有执行状态信号 -> 非执行状态信号
    RAC([UIApplication sharedApplication],networkActivityIndicatorVisible) = presenter.executeSearch.executing;
    
    // 订阅开始搜索信号
    [presenter.executeSearch.executionSignals subscribeNext:^(RACSignal *signal) {
        [self.mainCategoryTextField resignFirstResponder];
        [self.secondCategoryTextFiled resignFirstResponder];
    }];
    
    [presenter.connectionErrors subscribeNext:^(NSError *error) {
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"Connect Error!"
                                   message:@"network disconnected."
                                  delegate:nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [alert show];
    }];
}


@end
