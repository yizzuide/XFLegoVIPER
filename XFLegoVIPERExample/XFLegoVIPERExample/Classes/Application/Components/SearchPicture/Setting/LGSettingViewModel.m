//
//  XFSettingViewModel.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2017/2/5.
//  Copyright © 2017年 Yizzuide. All rights reserved.
//

#import "LGSettingViewModel.h"

@implementation LGSettingViewModel

- (void)viewDidLoad
{
    [self.eventBus setupTimerWithTimeInterval:0.5];
}

- (void)run
{
    NSLog(@"I'am runing");
}

- (void)startButtonAction
{
    [self.eventBus startTimer];
}
- (void)pauseButtonAction
{
    [self.eventBus pauseTimer];
}
- (void)restartButtonAction
{
    [self.eventBus resumeTimer];
}
- (void)stopButtonAction
{
    [self.eventBus stopTimer];
}

- (void)dealloc
{
    XF_Debug_M()
}
@end
