//
//  XFSearchEventHandlerPort.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 16/8/30.
//  Copyright © 2016年 Yizzuide. All rights reserved.
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
@property (nonatomic, strong) RACCommand *showAboutCommand;
@property (nonatomic, strong) RACCommand *showFlutterCommand;

@property (strong, nonatomic) RACSignal *connectionErrors;

@end

