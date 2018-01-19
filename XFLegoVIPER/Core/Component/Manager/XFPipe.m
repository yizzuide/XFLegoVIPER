//
//  XFPipe.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2018/1/18.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#import "XFPipe.h"
#import "XFComponentManager.h"
#import "XFEmitterPlug.h"

@interface XFPipe()

@property (nonatomic, strong) NSMutableArray<id<XFEmitterPlug>> *emitters;
@end

@implementation XFPipe
{
    dispatch_queue_t queue;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.emitters = @[].mutableCopy;
        queue = dispatch_queue_create("com.lego.concurrent", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [super allocWithZone:zone];
    });
    return instance_;
}

- (id)copyWithZone:(NSZone *)zone
{
    return instance_;
}

static XFPipe *instance_;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[XFPipe alloc] init];
    });
    return instance_;
}

- (void)addEmitter:(id<XFEmitterPlug>)emitter
{
    [self.emitters addObject:emitter];
    [emitter prepare];
}

- (void)emitEventName:(NSString *)eventName intentData:(id)intentData
{
    dispatch_async(queue, ^{
        NSNotification *noti = [NSNotification notificationWithName:eventName object:nil userInfo:intentData];
        [XFComponentManager sendGlobalEventForAllComponents:noti];
    });
}

@end
