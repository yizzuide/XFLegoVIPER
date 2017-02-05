//
//  XFVIPERModuleRunnable.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/20.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFComponentRoutable.h"
#import "XFEventBus.h"

// 导出作为可运行组件
#undef XF_EXPORT_COMPONENT
#define XF_EXPORT_COMPONENT \
- (instancetype)init \
{ \
    self = [super init]; \
    if (self) { \
        [self setValue:[[XFEventBus alloc] initWithComponentRoutable:self] forKeyPath:@"eventBus"]; \
    } \
    return self; \
}

@protocol XFVIPERModuleRunnable <XFComponentRoutable>

@end
