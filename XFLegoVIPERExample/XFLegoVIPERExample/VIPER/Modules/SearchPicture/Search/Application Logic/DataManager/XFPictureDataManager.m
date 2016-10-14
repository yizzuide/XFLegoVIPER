//
//  XFPictureDataManager.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/26.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPictureDataManager.h"
#import "XFPictureService.h"

@interface XFPictureDataManager ()
@property (nonatomic, strong) XFPictureService *pictureService;
@end

@implementation XFPictureDataManager

- (XFPictureService *)pictureService
{
    if (self->_pictureService == nil) {
        self->_pictureService = [[XFPictureService alloc] init];
    }
    return self->_pictureService;
}

- (RACSignal *)pullPictureDataWithMainCategory:(NSString *)mainCategory secondCategory:(NSString *)secondCategory startIndex:(NSUInteger)startIndex
{
    return [self.pictureService pullPictureDataWithMainCategory:mainCategory secondCategory:secondCategory startIndex:startIndex];
}
@end
