//
//  XFControllerRunnable.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFComponentRoutable.h"
#import "UIViewController+ComponentBridge.h"

// 导出作为可运行组件
#undef XF_EXPORT_COMPONENT
#define XF_EXPORT_COMPONENT \
- (instancetype)init \
{ \
    self = [super init]; \
    if (self) { \
        [self setValue:[[XFUIBus alloc] initWithComponentRoutable:self] forKeyPath:@"uiBus"]; \
        [self setValue:[[XFEventBus alloc] initWithComponentRoutable:self] forKeyPath:@"eventBus"]; \
    } \
    return self; \
} \

/**
 *  控制器可进化组件接口
 */
@protocol XFControllerRunnable <XFComponentRoutable>

@end
