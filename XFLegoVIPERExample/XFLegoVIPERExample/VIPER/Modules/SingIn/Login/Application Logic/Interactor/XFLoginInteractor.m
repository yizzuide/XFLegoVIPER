//
//  XFLoginInteractor.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/4/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFLoginInteractor.h"
#import "XFUserService.h"


@interface XFLoginInteractor ()
@property (nonatomic, strong) XFUserService *userService;
@end

@implementation XFLoginInteractor

- (XFUserService *)userService {
    if(_userService == nil) {
        _userService = [[XFUserService alloc] init];
    }
    return _userService;
}

- (RACSignal *)loginWithUserName:(NSString *)name password:(NSString *)pwd {
    return [self.userService loginWithUserName:name password:pwd];
}
@end
