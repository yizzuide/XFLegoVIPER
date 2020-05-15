//
//  XFStautsFrame.h
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2016/10/27.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFStautsFrame : NSObject

// Cell子控件的frame
@property (nonatomic, assign) CGRect portraitImageF;
@property (nonatomic, assign) CGRect nikeNameF;
@property (nonatomic, assign) CGRect vipF;
@property (nonatomic, assign) CGRect contentF;
@property (nonatomic, assign) CGRect photoF;

// 行高
@property (nonatomic, assign) CGFloat cellHeight;

@end
