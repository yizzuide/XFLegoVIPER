//
//  XFPictureResultsActivity.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/8/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPictureResultsActivity.h"
#import "CETableViewBindingHelper.h"
#import "XFPictureTableViewCell.h"
#import "XFPictureResultsEventHandlerPort.h"
#import "MJRefresh.h"

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
    self.title = @"所有图片";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self bindViewData];
    
    // 上拉刷新
    @weakify(self)
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
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
                                           sourceSignal:RACObserve(self.eventHandler, expressData)
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
