//
//  XFUIOperatorPort.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFUIOperatorPort_h
#define XFUIOperatorPort_h

#import <UIKit/UIKit.h>
#import "XFUserInterfacePort.h"
#import "XFModuleComponentRunnable.h"

@protocol XFUIOperatorPort <XFModuleComponentRunnable>

/**
 *  当前UI交互者的视图给Routing的接口
 */
@property (nonatomic, weak, readonly) id<XFUserInterfacePort> userInterface;
@end


#endif /* XFUIOperatorPort_h */
