//
//  XFSearchWireFramePort.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/8/30.
//  Copyright © 2016年 yizzuide. All rights reserved.
//


@protocol XFSearchWireFramePort <NSObject>

/**
 *  跳转到结果界面
 */
- (void)transition2PictureResults;

- (void)transition2Message;
- (void)transition2Setting;
- (void)transition2About;
@end


