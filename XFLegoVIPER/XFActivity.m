//
//  XFActivity.m
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFActivity.h"
#import "XFEventHandlerProt.h"
#import <objc/runtime.h>
#import "XFLegoMarco.h"
#import "XFPresenter.h"


@interface XFActivity ()

@end

@implementation XFActivity

- (void)viewDidLoad
{
    [super viewDidLoad];
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [XFConvertPresenterToType(XFPresenter *) bindView:self];
    [XFConvertPresenterToType(XFPresenter *) viewDidLoad];
#pragma clang diagnostic pop
}

- (void)fillData:(id)data{}

- (void)dealloc
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [XFConvertPresenterToType(XFPresenter *) viewDidUnLoad];
#pragma clang diagnostic pop
}
@end
