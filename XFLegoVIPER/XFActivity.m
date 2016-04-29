//
//  XFActivity.m
//  VIPERGem
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
    [LEGORealProt(XFPresenter *, self.eventHandler) bindView:self];
    [LEGORealProt(XFPresenter *, self.eventHandler) viewDidLoad];
}

- (void)fillData:(id)data{}

- (void)dealloc
{
    [LEGORealProt(XFPresenter *, self.eventHandler) viewDidUnLoad];
}
@end
