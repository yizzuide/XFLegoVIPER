//
//  XFPictureTableViewCell.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPictureTableViewCell.h"
#import "XFPictureItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "XFLegoVIPER.h"


@interface XFPictureTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation XFPictureTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
 
    self.pictureImage.layer.masksToBounds = YES;
    // 解决UITableViewCell选中时使UILabel背景色清空问题
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.layer.backgroundColor = [UIColor colorWithWhite:0.298 alpha:0.500].CGColor;
}

- (void)bindExpressData:(id)expressData
{
    XFPictureItem *item = expressData;
    self.titleLabel.text = item.title;
    self.pictureImage.contentMode = UIViewContentModeScaleToFill;
    [self.pictureImage sd_setImageWithURL:item.thumbUrl];
}

- (void)setParallax:(CGFloat)value {
    self.pictureImage.transform = CGAffineTransformMakeTranslation(0, value);
    //NSLog(@"当前图片视图Cell绑定了事件处理层：%@",NSStringFromClass([self.eventHandler class]));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
