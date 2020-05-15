//
//  XFPictureResultsInteractorPort.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 16/8/30.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//


@class RACSignal;
@protocol XFPictureResultsInteractorPort <NSObject>

- (RACSignal *)deconstructPreLoadData:(id)preLoadData;
- (RACSignal *)loadNextPagePictures;
@end
