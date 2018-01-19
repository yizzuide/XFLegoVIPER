//
//  XFApplicationEmitter.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2018/1/18.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#import "XFApplicationEmitter.h"

@implementation XFApplicationEmitter

- (void)prepare
{
    NSArray *names = @[
                       UIApplicationDidEnterBackgroundNotification,
                       UIApplicationWillEnterForegroundNotification,
                       UIApplicationDidFinishLaunchingNotification,
                       UIApplicationDidBecomeActiveNotification,
                       UIApplicationWillResignActiveNotification,
                       UIApplicationDidReceiveMemoryWarningNotification,
                       UIApplicationWillTerminateNotification,
                       UIApplicationSignificantTimeChangeNotification,
                       UIApplicationWillChangeStatusBarOrientationNotification,
                       UIApplicationDidChangeStatusBarOrientationNotification,
                       UIApplicationWillChangeStatusBarFrameNotification,
                       UIApplicationDidChangeStatusBarFrameNotification,
                       UIApplicationBackgroundRefreshStatusDidChangeNotification,
                       UIApplicationProtectedDataWillBecomeUnavailable,
                       UIApplicationProtectedDataDidBecomeAvailable,
                       ];
    for (NSNotificationName name in names) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveAppNotification:) name:name object:nil];
    }
}

- (void)receiveAppNotification:(NSNotification *)noti
{
    // 通过管道向乐高框架发送
    [self.pipe emitEventName:noti.name intentData:noti.userInfo];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
