//
//  XFPageControlActivity.m
//  XFLegoVIPERExample
//
//  Created by Yizzuide on 2016/10/10.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "XFPageControlActivity.h"

@interface XFPageControlActivity () <UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *sliderView;

@property (nonatomic, weak) UIImageView *sliderImageView;
@property (nonatomic, weak) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray *subActivitys;
@property (nonatomic, strong) XFActivity *movieActivity;
@property (nonatomic, strong) XFActivity *musicActivity;
@property (nonatomic, strong) XFActivity *bookActivity;

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
    // 管理视图
	self.pageViewController = self.childViewControllers.firstObject;
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    // 添加子视图
    self.movieActivity = XF_SubUInterface_URL(@"xf://search/pictureResults/pageControl/movie");
    self.musicActivity = XF_SubUInterface_URL(@"xf://search/pictureResults/pageControl/Music");
    self.bookActivity = XF_SubUInterface_URL(@"xf://search/pictureResults/pageControl/Book");
    self.subActivitys = @[self.movieActivity,self.musicActivity,self.bookActivity];
    
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
    // 移动sliderBar
    [self moveSliderBarWithPageNumber:currentPage];
    
    //根据currentPage 和 lastPage的大小关系，控制页面的切换方向
    if (currentPage > self.lastPage) {
        [self.pageViewController setViewControllers:@[self.subActivitys[currentPage]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }else {
        [self.pageViewController setViewControllers:@[self.subActivitys[currentPage]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    }
    self.lastPage = currentPage;
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
    self->_currentPage = pageNumber;
}


- (IBAction)tabChangeAction:(UIButton *)sender {
    // 第一个button的tag是100,依次递增
    NSUInteger calcIndexFromTag = sender.tag - 100;
    if (calcIndexFromTag != self.currentPage) {
        self.currentPage = calcIndexFromTag;
    }
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

- (void)dealloc
{
    XF_Debug_M();
}

@end
