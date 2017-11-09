//
//  XFSearchPresenter.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/26.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPresenter.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "XFSearchEventHandlerPort.h"


@interface XFSearchPresenter : XFPresenter <XFSearchEventHandlerPort>

@property (nonatomic, copy) NSString *navigationTitle;
@property (nonatomic, copy) NSString *mainCategory;
@property (nonatomic, copy) NSString *secondCategory;

@property (strong, nonatomic) RACCommand *executeSearch;
@property (nonatomic, strong) RACCommand *showMessageCommand;
@property (nonatomic, strong) RACCommand *showSettingCommand;
@property (nonatomic, strong) RACCommand *showAboutCommand;

@property (strong, nonatomic) RACSignal *connectionErrors;

@end
