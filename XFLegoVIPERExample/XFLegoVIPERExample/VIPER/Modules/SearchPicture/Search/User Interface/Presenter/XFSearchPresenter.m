//
//  XFSearchPresenter.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/26.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFSearchPresenter.h"
#import "XFSearchWireFramePort.h"
#import "XFSearchInteractorPort.h"

@implementation XFSearchPresenter

- (void)viewDidLoad
{
    [self initialize];
}

- (void)initialize {
    self.navigationTitle = @"开始搜索";
}

- (void)initCommand
{
    // 使用合并信号
    RACSignal *fieldsSignal = [[[RACSignal combineLatest:@[ RACObserve(self, mainCategory), RACObserve(self, secondCategory)]]
                                map:^id(RACTuple *tuple) {
                                    // 设置验证通过的规则
                                    NSString *mainText = tuple.first;
                                    NSString *secondText = tuple.second;
                                    return @(mainText.length > 0 && secondText.length > 0);
                                }] distinctUntilChanged]; // distinctUntilChanged表示只有状态不同才发出信号
    
    [fieldsSignal subscribeNext:^(id valid) {
        NSLog(@"text is valid %@", valid);
    }];
    
    XF_CEXE_Begin
    XF_CEXE_Enable_(self.executeSearch, fieldsSignal, {
        return [self executeSearchSignal];
    })
    
    // 连接错误信号
    self.connectionErrors = self.executeSearch.errors;
}

// 按钮响应信号方法
- (RACSignal *)executeSearchSignal
{
    // 预加载数据
    return [[[XFConvertInteractorToType(id<XFSearchInteractorPort>) fetchPictureDataWithMainCategory:self.mainCategory secondCategory:self.secondCategory] doNext:^(id x) {
        //NSLog(@"%@",x);
        // 设置意图数据
        self.intentData = x;
        // 请求Routing切换界面
        [XFConvertRoutingToType(id<XFSearchWireFramePort>) transitionToShowResultsMoudle];
    }] doError:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
}

- (void)receiveOtherMoudleEventName:(NSString *)eventName intentData:(id)intentData
{
    XF_EventIs_(@"loadData", {
        NSLog(@"接收到模块加载数据事件: %@",eventName);
    })
}
@end
