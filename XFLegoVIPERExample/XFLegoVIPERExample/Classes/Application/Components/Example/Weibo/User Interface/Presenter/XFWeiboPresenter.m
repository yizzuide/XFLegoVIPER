//
//  XFWeiboPresenter.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 2016/10/27.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFWeiboPresenter.h"
#import "XFWeiboWireframePort.h"
#import "XFWeiboUserInterfacePort.h"
#import "XFWeiboInteractorPort.h"
#import "ReactiveCocoa.h"
#import "XFRenderData.h"
#import "XFWeiboExpressPack.h"


#define Interactor XFConvertInteractorToType(id<XFWeiboInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<XFWeiboUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<XFWeiboWireFramePort>)

@interface XFWeiboPresenter ()

@end

@implementation XFWeiboPresenter

#pragma mark - lifeCycle
// 绑定视图层后调用
- (void)viewDidLoad
{
    // 测试用于返回当前导航的根控制器
    /*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [Routing pop2Root];
    });*/
}

// 初始化视图数据
- (void)initRenderView
{
    // 填充绑定的ViewData
    [[Interactor fetchStatus] subscribeNext:^(XFRenderData *renderData) {
        XF_SetExpressPack_(XFWeiboExpressPack, renderData)
    }];
}

// 初始化命令
- (void)initCommand
{
    /*XF_CEXE_Begin
    // 当命令触发时执行代码
    XF_CEXE_(self.command, {
        // TODO
    })*/
}

// 注册MVx通知
- (void)registerMVxNotifactions
{
    // 注册MVx构架通知
//    XF_RegisterMVxNotis_(@[NF_User_XXX])
}


// 接受到MVx构架或XFLegoVIPER模块的通知
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    // 匹配对应通知
    /*XF_EventIs_(NF_User_XXX, {
        // TODO
    })*/
}

#pragma mark - DoAction

- (void)cellActionForSelectedPiece:(id)expressPiece
{
    NSInteger index = [self.expressPack findIndexWithPiece:expressPiece];
    NSLog(@"selected Index: %zd",index);
}


#pragma mark - ValidData


- (void)dealloc
{
    XF_Debug_M();
}
@end
