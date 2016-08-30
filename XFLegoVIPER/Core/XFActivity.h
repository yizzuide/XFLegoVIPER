//
//  XFActivity.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFUserInterfacePort.h"
#import "XFEventHandlerPort.h"
#import "XFLegoMarco.h"
#import "UINavigationController+BackButtonHandler.h"

#define XFConvertPresenterToType(type) LEGORealPort(type, self.eventHandler)

@interface XFActivity : UIViewController <XFUserInterfacePort,UINavigationControllerBackButtonDelegate>

@property (nonatomic, strong) id<XFEventHandlerPort> eventHandler;
@end
