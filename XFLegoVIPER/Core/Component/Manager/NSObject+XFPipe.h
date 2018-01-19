//
//  NSObject+XFPipe.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 2018/1/18.
//  Copyright © 2018年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFPipePort.h"

@interface NSObject (XFPipe)

@property (nonatomic, weak) id<XFPipePort> pipe;
@end
