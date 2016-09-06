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
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    
    
    [self bindViewValue];
}

- (void)bindViewValue {
    UINib *nib = [UINib nibWithNibName:@"XFPictureTableViewCell" bundle:nil];
    self.bindingHelper =
    [CETableViewBindingHelper bindingHelperForTableView:self.tableView
                                           sourceSignal:RACObserve(self.eventHandler, expressData)
                                       selectionCommand:nil
                                           templateCell:nib];
    self.bindingHelper.delegate = self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSArray *cells = [self.tableView visibleCells];
    for (XFPictureTableViewCell *cell in cells) {
        CGFloat value = -40 + (cell.frame.origin.y - self.tableView.contentOffset.y) / 5;
        [cell setParallax:value];
    }
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
