//
//  NSObject+XFLegoInvokeMethod.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/28.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XFLegoInvokeMethod)

- (void)invokeMethod:(NSString *)selector param:(id)param forObject:(id)object;
@end
