//
//  XFWeiboExpressPack.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 2016/10/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFWeiboExpressPack.h"
#import "XFStautsRenderItem.h"
#import "XFStautsFrame.h"
#import "NSString+Tools.h"

#define kNameFont [UIFont systemFontOfSize:14]
#define kTextFont [UIFont systemFontOfSize:16]

@implementation XFWeiboExpressPack

- (id)onMeasureFrameWithItem:(__kindof XFRenderItem *)renderItem index:(NSUInteger)index
{
    CGFloat padding = 10;
    // 用户图像
    CGFloat iconX = padding;
    CGFloat iconY = padding;
    CGFloat iconW = 30;
    CGFloat iconH =30;
    
    XFStautsRenderItem *item = renderItem;
    XFStautsFrame *stautsframe = [[XFStautsFrame alloc] init];
    
    // 头像
    stautsframe.portraitImageF = CGRectMake(iconX, iconY, iconW, iconH);
    // 昵称
    NSDictionary *nameDict = @{NSFontAttributeName : kNameFont};
    CGRect nikeNameFrame = [item.nikeName textRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) attributes:nameDict];
    nikeNameFrame.origin.x = CGRectGetMaxX(stautsframe.portraitImageF) + padding;
    nikeNameFrame.origin.y = padding + (stautsframe.portraitImageF.size.height - nikeNameFrame.size.height) * 0.5;
    stautsframe.nikeNameF = nikeNameFrame;
    // vip
    stautsframe.vipF = CGRectMake(CGRectGetMaxX(nikeNameFrame) + padding, nikeNameFrame.origin.y, 14, 14);
    // 正文
    NSDictionary *textDict = @{NSFontAttributeName : kTextFont};
    CGRect contentFrame = [item.content textRectWithSize:CGSizeMake([ UIScreen mainScreen ].bounds.size.width - padding * 2, MAXFLOAT)  attributes:textDict];
    
    contentFrame.origin.x = padding;
    contentFrame.origin.y = padding + CGRectGetMaxY(stautsframe.portraitImageF);
    stautsframe.contentF = contentFrame;
    
    // 附图
    // 计算cell高度
    if (item.photo) {
        CGFloat pictrueX = padding;
        CGFloat pictrueY = padding + CGRectGetMaxY(contentFrame);
        CGFloat pictureW = 100;
        CGFloat pictureH =pictureW;
        
        stautsframe.photoF = CGRectMake(pictrueX, pictrueY, pictureW, pictureH);
        
        stautsframe.cellHeight = CGRectGetMaxY(stautsframe.photoF) + padding;
    }else{
       stautsframe.cellHeight = CGRectGetMaxY(contentFrame) + padding;
    }
    
    return stautsframe;
}
@end
