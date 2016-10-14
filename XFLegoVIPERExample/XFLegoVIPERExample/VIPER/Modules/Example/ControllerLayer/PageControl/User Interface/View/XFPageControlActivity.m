//
//  XFPageControlActivity.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/10.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPageControlActivity.h"

@interface XFPageControlActivity () <UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *sliderView;

@property (nonatomic, weak) UIImageView *sliderImageView;
@property (nonatomic, weak) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray *subActivitys;
@property (nonatomic, weak) XFActivity *movieActivity;
@property (nonatomic, weak) XFActivity *musicActivity;
@property (nonatomic, weak) XFActivity *bookActivity;

@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) NSUInteger lastPage;
@end

@implementation XFPageControlActivity

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubView];
}

- (void)initSubView {
    // 添加管理视图
	self.pageViewController = self.childViewControllers.firstObject;
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    // 添加模块子视图，当前Activity就为父模块视图
    XFActivity *movieActivity = XF_SubUInterface_(@"Movie");
    XFActivity *musicActivity = XF_SubUInterface_(@"Music");
    XFActivity *bookActivity = XF_SubUInterface_(@"Book");
    self.subActivitys = @[movieActivity,musicActivity,bookActivity];
    self.movieActivity = movieActivity;
    self.musicActivity = musicActivity;
    self.bookActivity = bookActivity;
    
    // 设置每一个显示视图
    [self.pageViewController setViewControllers:@[self.movieActivity] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // 设置Silder
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -1, self.view.frame.size.width / 3.0, 3.0)];
    imageView.image = [UIImage imageNamed:@"slider"];
    [self.sliderView addSubview:imageView];
    self.sliderImageView = imageView;
}


- (void)setCurrentPage:(NSUInteger)currentPage
{
    _currentPage = currentPage;
    
    [self moveSliderBarWithPageNumber:currentPage];
    
    //根据currentPage 和 lastPage的大小关系，控制页面的切换方向
    if (self.currentPage > self.lastPage) {
        [self.pageViewController setViewControllers:@[self.subActivitys[self.currentPage]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }else {
        [self.pageViewController setViewControllers:@[self.subActivitys[self.currentPage]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
    self.lastPage = self.currentPage;
}

- (void)moveSliderBarWithPageNumber:(NSUInteger)pageNumber
{
    //根据当前页面计算得到偏移量
    //一个微小的动画移动提示条
    CGFloat offset = self.view.frame.size.width / 3.0 * pageNumber;
    [UIView animateWithDuration:0.25 animations:^{
        XF_SetFrame_(self.sliderImageView, {
            frame.origin = CGPointMake(offset, -1);
        })
    }];
}


- (IBAction)tabChangeAction:(UIButton *)sender {
    // 第一个button的tag是100,依次递增
    NSUInteger calcIndexFromTag = sender.tag - 100;
    self.currentPage = calcIndexFromTag;
}


#pragma mark - PageViewController DataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    XFActivity *targetActivity;
    if (viewController == self.movieActivity) {
        targetActivity = self.musicActivity;
    } else if (viewController == self.musicActivity){
        targetActivity = self.bookActivity;
    }
    return targetActivity;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    XFActivity *targetActivity;
    if (viewController == self.musicActivity) {
        targetActivity =  self.movieActivity;
    }else if (viewController == self.bookActivity) {
        targetActivity =  self.musicActivity;
    }
    return targetActivity;
}

#pragma mark - PageViewController Delegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    NSUInteger count = self.subActivitys.count;
    for (int i = 0; i < count; i++) {
        XFActivity *activity = self.subActivitys[i];
        if (pendingViewControllers.firstObject == activity) {
            self.currentPage = i;
            return;
        }
    }
}

- (void)switch2SubActivity:(__kindof id<XFUserInterfacePort>)subActivity
{
    [self moveSliderBarWithPageNumber:[self.subActivitys indexOfObject:subActivity]];
}

@end
