//
//  CYHomeViewController.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/10.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYHomeViewController.h"
#import "CYHotViewController.h"
#import "CYNearbyViewController.h"
#import "CYFollowViewController.h"
#import "CYTopTitleView.h"

@interface CYHomeViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) CYTopTitleView *titleView;
@property (nonatomic, strong) UIScrollView *homeScrollView;

@property (nonatomic, strong) NSMutableArray *vcArr;

@end

@implementation CYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.titleView;
    
    UIImage *leftImg = [UIImage imageNamed:@"left_search"];
    leftImg = [leftImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftImg style:UIBarButtonItemStylePlain target:self action:@selector(enterSearchClick)];
    UIImage *rightImg = [UIImage imageNamed:@"right_message"];
    rightImg = [rightImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightImg style:UIBarButtonItemStylePlain target:self action:nil];
    [self.view addSubview:self.homeScrollView];
    
    [self initChildViewControllers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initChildViewControllers {
    //关注
    CYFollowViewController *followVc = [[CYFollowViewController alloc]init];
    [self addChildViewController:followVc];
    
    //热门
    CYHotViewController *mainVc = [[CYHotViewController alloc]init];
    [self addChildViewController:mainVc];
    
    //附近
    CYNearbyViewController *nearVc = [[CYNearbyViewController alloc]init];
    [self addChildViewController:nearVc];
    
    self.vcArr = [NSMutableArray arrayWithObjects:followVc,mainVc,nearVc,nil];
    
    for (NSInteger i=0; i<self.childViewControllers.count; i++) {
        UIViewController *cls = self.childViewControllers[i];
        cls.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49-64);
        [self.homeScrollView addSubview:cls.view];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.titleView scrollMove:(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width)];
}

- (void)enterSearchClick {
    
}

- (CYTopTitleView *)titleView
{
    if (!_titleView) {
        __weak typeof(self) weakSelf = self;
        _titleView = [[CYTopTitleView alloc] initWithFrame:CGRectMake(0, 0, 240, 44)];
        [_titleView setTitleClick:^(NSInteger tag) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CGPoint point = CGPointMake(tag * [UIScreen mainScreen].bounds.size.width, strongSelf.homeScrollView.contentOffset.y);
            [strongSelf.homeScrollView setContentOffset:point animated:YES];
            
        }];
    }
    return _titleView;
}

- (UIScrollView *)homeScrollView{
    if (!_homeScrollView) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        _homeScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _homeScrollView.contentSize = CGSizeMake(3 * [UIScreen mainScreen].bounds.size.width, 0);
        _homeScrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width, 0);
        _homeScrollView.showsHorizontalScrollIndicator = NO;
        _homeScrollView.pagingEnabled = YES;
        _homeScrollView.bounces = NO;
        _homeScrollView.delegate = self;
        _homeScrollView.userInteractionEnabled = YES;
        _homeScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _homeScrollView;
}

@end
