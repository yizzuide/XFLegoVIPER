//
//  XFSubControlActivity.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFSubControlActivity.h"
#import "XFSubControlEventHandlerPort.h"
#import "ReactiveCocoa.h"

#define EventHandler XFConvertPresenterToType(id<XFSubControlEventHandlerPort>)

@interface XFSubControlActivity ()

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *worksBtn;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation XFSubControlActivity

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *collectView = [EventHandler requireCollectView];
    
    [self.containerView addSubview:collectView];
    collectView.frame  = self.containerView.bounds;
    self.collectBtn.enabled = NO;
}

- (IBAction)worksBtnAction {
    self.collectBtn.enabled = YES;
    [[EventHandler worksCommand] execute:nil];
    self.worksBtn.enabled = NO;
}
- (IBAction)collectBtnAction {
    self.worksBtn.enabled = YES;
    [[EventHandler collectCommand] execute:nil];
    self.collectBtn.enabled = NO;
}

@end
