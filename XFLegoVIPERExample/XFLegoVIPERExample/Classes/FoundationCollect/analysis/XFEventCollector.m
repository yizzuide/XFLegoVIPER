//
//  XFEventCollector.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2018/1/8.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#import "XFEventCollector.h"
#import "XFComponentManager.h"

@implementation XFEventCollector

- (instancetype)init
{
    self = [super init];
    if (self) {
        [XFComponentManager addEventReceiver:self componentName:@"EventCollector"];
    }
    return self;
}

- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    NSLog(@"%@-----%@",eventName,intentData);
}
@end
