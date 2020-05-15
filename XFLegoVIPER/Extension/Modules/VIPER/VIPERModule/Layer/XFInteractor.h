//
//  XFInteractor.h
//  XFLegoVIPER
//
//  Created by Yizzuide on 15/12/22.
//  Copyright © 2015年 Yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFInteractorPort.h"
#import "XFDataManagerPort.h"
#import "XFLegoMarco.h"

#define XFConvertDataManagerToType(type) LEGORealPort(type, self.dataManager)

@interface XFInteractor : NSObject <XFInteractorPort>

@property (nonatomic, strong, readonly) __kindof id<XFDataManagerPort> dataManager;
@end
