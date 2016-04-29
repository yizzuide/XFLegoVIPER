//
//  XFMainPersenter.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFMainPersenter.h"
#import "XFMainWireFrameInputProt.h"

@implementation XFMainPersenter

- (void)didRequestToLoginTransition
{
    [XFConvertRoutingToType(id<XFMainWireFrameInputProt>) transitionToLoginMoudle];
}

- (void)viewWillBecomeFoucsWithIntentData:(id)intentData
{
    NSLog(@"%@",intentData);
    self.expressData = intentData;
    [self.activity fillData:self.expressData];
}
@end
