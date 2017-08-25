//
//  XFPageControlPresenter.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/10.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPageControlPresenter.h"
#import "ReactiveCocoa.h"
#import "XFPageControlUserInterfacePort.h"
#import "XFComponentManager.h"


#define UI XFConvertUserInterfaceToType(id<XFPageControlUserInterfacePort>)
@implementation XFPageControlPresenter

- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    if ([eventName isEqualToString:@"showSubPage"]) {
        [UI switch2SubActivity:intentData];
    }
}

-(void)dealloc
{
    XF_Debug_M();
}
@end
