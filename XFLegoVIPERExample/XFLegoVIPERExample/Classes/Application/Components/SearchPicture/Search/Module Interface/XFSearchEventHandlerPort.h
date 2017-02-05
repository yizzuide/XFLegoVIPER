//
//  XFSearchEventHandlerPort.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/30.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFEventHandlerPort.h"

@protocol XFSearchEventHandlerPort <XFEventHandlerPort>

// 建立基本视图的填充数据
@property (nonatomic, copy) NSString *navigationTitle;
@property (nonatomic, copy) NSString *mainCategory;
@property (nonatomic, copy) NSString *secondCategory;

@property (strong, nonatomic) RACCommand *executeSearch;
@property (nonatomic, strong) RACCommand *showMessageCommand;
@property (nonatomic, strong) RACCommand *showSettingCommand;

@property (strong, nonatomic) RACSignal *connectionErrors;

@end

