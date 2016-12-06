//
//  XFInteractor.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFInteractorPort.h"
#import "XFDataManagerPort.h"
#import "XFLegoMarco.h"

#define XFConvertDataManagerToType(type) LEGORealPort(type, self.dataManager)

@interface XFInteractor : NSObject <XFInteractorPort>

@property (nonatomic, strong, readonly) __kindof id<XFDataManagerPort> dataManager;
@end
