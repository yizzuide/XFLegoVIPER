//
//  XFSubControl2Activity.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 2016/10/4.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFSubControl2Activity.h"
#import "XFSubControl2EventHandlerPort.h"
#import "ReactiveCocoa.h"

#define EventHandler XFConvertPresenterToType(id<XFSubControl2EventHandlerPort>)

@interface XFSubControl2Activity ()

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *worksBtn;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@end

@implementation XFSubControl2Activity

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [EventHandler requireLoadCollectViewForHostView:self.containerView];
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
