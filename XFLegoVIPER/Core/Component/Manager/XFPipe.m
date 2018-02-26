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
    dispatch_queue_t __queue;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.emitters = @[].mutableCopy;
        __queue = dispatch_queue_create("com.lego.concurrent", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [super allocWithZone:zone];
    });
    return __instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return __instance;
}

static XFPipe *__instance;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[XFPipe alloc] init];
    });
    return __instance;
}

- (void)addEmitter:(id<XFEmitterPlug>)emitter
{
    [self.emitters addObject:emitter];
    [emitter prepare];
}

- (void)emitEventName:(NSString *)eventName intentData:(id)intentData
{
    dispatch_async(__queue, ^{
        [XFComponentManager sendGlobalEventName:eventName intentData:intentData];
    });
}

- (void)subscribeEventOnReceiver:(nonnull id<XFEventReceivable>)eventReceiver withRegisterCompName:(nonnull NSString *)compName needReceiveEmitterEvent:(BOOL)needReceiveEmitterEvent
{
    if (needReceiveEmitterEvent) {
        [XFComponentManager addIncompatibleComponent:eventReceiver componentName:compName];
    } else {
        [XFComponentManager addEventReceiver:eventReceiver componentName:compName];
    }
}

- (void)unSubscribeEventWithCompName:(NSString *)compName needReceiveEmitterEvent:(BOOL)needReceiveEmitterEvent
{
    if (needReceiveEmitterEvent) {
        [XFComponentManager removeIncompatibleComponentWithName:compName];
    } else {
        [XFComponentManager removeEventReceiverComponentWithName:compName];
    }
}

@end
