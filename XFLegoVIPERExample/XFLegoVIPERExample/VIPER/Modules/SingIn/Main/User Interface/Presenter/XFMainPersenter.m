//
//  XFMainPersenter.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFMainPersenter.h"
#import "XFMainWireFrameInputPort.h"

@implementation XFMainPersenter

- (void)didRequestToLoginTransition
{
    [XFConvertRoutingToType(id<XFMainWireFrameInputPort>) transitionToLoginMoudle];
}

- (void)viewWillBecomeFocusWithIntentData:(id)intentData
{
    NSLog(@"%@",intentData);
    self.expressData = intentData;
    [self.userInterface fillData:self.expressData];
}
@end
