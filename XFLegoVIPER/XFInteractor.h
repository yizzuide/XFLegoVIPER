//
//  XFInteractor.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFInteractorProt.h"
#import "XFDataManagerProt.h"
#import "XFLegoMarco.h"

#define XFConvertDataManagerToType(type) LEGORealProt(type, self.dataManager)

@interface XFInteractor : NSObject <XFInteractorProt>

@property (nonatomic, strong) id<XFDataManagerProt> dataManager;
@end
