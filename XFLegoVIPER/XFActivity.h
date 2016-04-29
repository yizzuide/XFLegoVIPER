//
//  XFActivity.h
//  VIPERGem
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFUserInterfaceProt.h"
#import "XFLegoMarco.h"

#define XFConvertPresenterToType(type) LEGORealProt(type, self.eventHandler)

@protocol XFEventHandlerProt;

@interface XFActivity : UIViewController <XFUserInterfaceProt>

@property (nonatomic, strong) id<XFEventHandlerProt> eventHandler;
@end
