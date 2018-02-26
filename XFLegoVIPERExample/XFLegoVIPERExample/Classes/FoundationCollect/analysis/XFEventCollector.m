//
//  XFEventCollector.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2018/1/8.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#import "XFEventCollector.h"

@implementation XFEventCollector

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 框架会自动注入这个pipe对象，无需自己创建
        [self.pipe subscribeEventOnReceiver:self withRegisterCompName:@"EventCollector" needReceiveEmitterEvent:NO];
    }
    return self;
}

- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    NSLog(@"%@-----%@",eventName,intentData);
    // 取消订阅
//    [self.pipe unSubscribeEventWithCompName:@"EventCollector" needReceiveEmitterEvent:NO];
}
@end
