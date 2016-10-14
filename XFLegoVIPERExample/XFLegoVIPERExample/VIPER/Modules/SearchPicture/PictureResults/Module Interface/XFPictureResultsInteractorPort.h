//
//  XFPictureResultsInteractorPort.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/30.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#ifndef XFPictureResultsInteractorPort_h
#define XFPictureResultsInteractorPort_h

@class RACSignal;
@protocol XFPictureResultsInteractorPort <NSObject>

- (RACSignal *)deconstructPreLoadData:(id)preLoadData;
- (RACSignal *)loadNextPagePictures;
@end

#endif /* XFPictureResultsInteractorPort_h */
