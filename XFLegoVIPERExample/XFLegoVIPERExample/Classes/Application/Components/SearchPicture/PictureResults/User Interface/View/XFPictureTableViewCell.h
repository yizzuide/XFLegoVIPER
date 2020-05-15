//
//  XFPictureTableViewCell.h
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CEReactiveView.h"
#import "UIView+XFLego.h"


@interface XFPictureTableViewCell : UITableViewCell <CEReactiveView>

- (void)setParallax:(CGFloat)value;
@end
