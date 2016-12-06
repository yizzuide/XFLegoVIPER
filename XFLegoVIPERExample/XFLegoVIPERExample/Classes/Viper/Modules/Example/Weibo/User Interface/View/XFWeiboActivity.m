//
//  XFWeiboActivity.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/27.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFWeiboActivity.h"
#import "XFWeiboEventHandlerPort.h"
#import "XFStatusCell.h"
#import "ReactiveCocoa.h"
#import "CEReactiveView.h"
#import "XFStautsFrame.h"


#define EventHandler  XFConvertPresenterToType(id<XFWeiboEventHandlerPort>)

@interface XFWeiboActivity () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation XFWeiboActivity

static NSString *ID = @"cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化视图
    [self setUpViews];
    // 绑定视图数据
    [self bindViewData];
}

#pragma mark - 初始化
- (void)setUpViews {
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[XFStatusCell class] forCellReuseIdentifier:ID];
}

- (void)bindViewData {
    XF_Define_Weak
    [RACObserve(self.eventHandler.expressPack,expressPieces) subscribeNext:^(id x) {
        XF_Define_Strong
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}


#pragma mark - UITableViewDataSurce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.eventHandler expressPack].expressPieces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XFStatusCell<CEReactiveView> *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell bindExpressPiece:[self.eventHandler expressPack].expressPieces[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XFStautsFrame *frame = [self.eventHandler expressPack].expressPieces[indexPath.row].uiFrame;
    return frame.cellHeight;
}

#pragma mark - Getter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)dealloc
{
    XF_Debug_M();
}
@end
