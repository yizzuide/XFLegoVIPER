//
//  XFPictureResultsActivity.m
//  XFLegoVIPERExample
//
//  Created by yizzuide on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPictureResultsActivity.h"
#import "CETableViewBindingHelper.h"
#import "XFPictureTableViewCell.h"
#import "XFPictureResultsEventHandlerPort.h"
#import "MJRefresh.h"
#import "XFExpressPack.h"

#define EventHandler XFConvertPresenterToType(id<XFPictureResultsEventHandlerPort>)

@interface XFPictureResultsActivity () <UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) CETableViewBindingHelper *bindingHelper;
@end

@implementation XFPictureResultsActivity

- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Results";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self bindViewData];
    
    // 上拉刷新
    XF_Define_Weak
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        XF_Define_Strong
        [[EventHandler didFooterRefresh] subscribeNext:^(NSMutableArray *indexPaths) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                [self.tableView.mj_footer endRefreshing];
            });
        }];
    }];
}

- (void)bindViewData {
    UINib *nib = [UINib nibWithNibName:@"XFPictureTableViewCell" bundle:nil];
    self.bindingHelper =
    [CETableViewBindingHelper bindingHelperForTableView:self.tableView
                                           sourceSignal:RACObserve(self.eventHandler,expressPack)
                                       selectionCommand:EventHandler.cellSelectedCommad
                                           templateCell:nib];
}

/*- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSArray *cells = [self.tableView visibleCells];
    for (XFPictureTableViewCell *cell in cells) {
        CGFloat value = -40 + (cell.frame.origin.y - self.tableView.contentOffset.y) / 5;
        [cell setParallax:value];
    }
}*/

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
