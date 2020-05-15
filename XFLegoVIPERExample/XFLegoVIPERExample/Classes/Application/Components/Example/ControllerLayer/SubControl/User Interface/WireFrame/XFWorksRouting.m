//
//  XFWorksRouting.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 2016/10/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFWorksRouting.h"
#import "XFWorksPresenter.h"

@implementation XFWorksRouting

XF_AutoAssemblyModuleFromIB(@"x-XFWorksActivity")

- (void)dealloc
{
    XF_Debug_M();
}
@end
