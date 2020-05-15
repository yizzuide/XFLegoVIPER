//
//  XFStatusCell.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 2016/10/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFStatusCell.h"
#import "XFStautsRenderItem.h"
#import "XFExpressPiece.h"
#import "XFStautsFrame.h"
#import "UIView+XFLego.h"
#import "XFWeiboEventHandlerPort.h"

// 昵称字体
#define kNameFont [UIFont systemFontOfSize:14]

// 正文字体
#define kTextFont [UIFont systemFontOfSize:16]

@interface XFStatusCell ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nikeNameLabel;
@property (nonatomic, strong) UIImageView *vipImageView;
@property (nonatomic, strong) UILabel *contentLabel; // 注意父类有textLabel,不要有重名
@property (nonatomic, strong) UIImageView *photoView;

@property (nonatomic, weak) XFExpressPiece *expressPiece;
@end

@implementation XFStatusCell

- (void)bindExpressPiece:(id)expressPiece
{
    _expressPiece = expressPiece;
    // 1.填充数据
    [self settingData];
    // 2.控件布局
    [self settingFrame];
}

- (void)settingData
{
    XFStautsRenderItem *status = self.expressPiece.renderItem;
    self.portraitImageView.image = [UIImage imageNamed:status.portraitImage];
    self.nikeNameLabel.text = status.nikeName;
    // 防止每次每加载图标,使用隐藏技巧
    if (status.isVIP) {
        self.vipImageView.hidden = NO;
        self.nikeNameLabel.textColor = [UIColor redColor];
    }else{
        self.vipImageView.hidden = YES; // 防止有缓存的Cell没有重新设置
        self.nikeNameLabel.textColor = [UIColor blackColor];
    }
    self.contentLabel.text = status.content;
    

    if (status.photo) {
        self.photoView.image = [UIImage imageNamed:status.photo];
    }else
    {
        self.photoView.image = nil;
    }
}

- (void)settingFrame
{
    XFStautsFrame *statusFrame = self.expressPiece.uiFrame;
    // 图标
    self.portraitImageView.frame = statusFrame.portraitImageF;
    // 用户名
    self.nikeNameLabel.frame = statusFrame.nikeNameF;
    // vip标识
    self.vipImageView.frame = statusFrame.vipF;
    // 正文
    self.contentLabel.frame = statusFrame.contentF;
    // 附图
    XFStautsRenderItem *status = self.expressPiece.renderItem;
    if (status.photo) {
        self.photoView.frame = statusFrame.photoF;
    }
}



// 在这里不用初始化大小
- (UIImageView *)portraitImageView
{
    if (_portraitImageView == nil) {
        _portraitImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_portraitImageView];
    }
    return _portraitImageView;
}
- (UILabel *)nikeNameLabel
{
    if (_nikeNameLabel == nil) {
        _nikeNameLabel  = [[UILabel alloc] init];
        // 默认字体是17
        _nikeNameLabel.font = kNameFont;
        [self.contentView addSubview:_nikeNameLabel];
    }
    return _nikeNameLabel ;
}
- (UIImageView *)vipImageView
{
    if (_vipImageView == nil) {
        _vipImageView  = [[UIImageView alloc] init];
        _vipImageView.image = [UIImage imageNamed:@"vip"];
        _vipImageView.hidden = YES;
        [self.contentView addSubview:_vipImageView];
    }
    return _vipImageView ;
}
- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel  = [[UILabel alloc] init];
        _contentLabel.font = kTextFont;
        // 设置为多行
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}
- (UIImageView *)photoView
{
    if (_photoView == nil) {
        _photoView  = [[UIImageView alloc] init];
        [self.contentView addSubview:_photoView];
        _photoView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
        [_photoView addGestureRecognizer:singleTap];
    }
    return _photoView ;
}

- (void)singleTapAction:(id)sender {
//    XFStautsRenderItem *status = self.expressPiece.renderItem;
    NSLog(@"%@",self.eventHandler);
    [XFConvertPresenterToType(id<XFWeiboEventHandlerPort>) cellActionForSelectedPiece:self.expressPiece];
}
@end
