//
//  CYLiveViewController.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/11.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYLiveViewController.h"
#import "CYCreatorModel.h"
#import "CYLiveModel.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "CYAnchorView.h"
#import "CYBottomView.h"
#import "CYInPiaoView.h"
#import "CYSendGiftView.h"

@interface CYLiveViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@property (nonatomic, strong) CYAnchorView *anchorView;
@property (nonatomic, strong) CYInPiaoView *inPiaoView;
@property (nonatomic, strong) CYBottomView *bottomTool;
@property (nonatomic, strong) CYSendGiftView *giftView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *ykNumLabel;
@property (nonatomic, strong) UILabel *ykNumLabel1;

// 最上层的视图
@property (nonatomic, strong) UIView *topSideView;
// 直播窗口
@property (nonatomic, strong) UIView *showView;
// 占位图
@property (nonatomic, strong) UIImageView *backdropView;

// 关闭直播
@property (nonatomic, strong) UIButton *closeButton;

// 连麦视屏窗口数
@property (nonatomic, strong) NSMutableArray *remoteArray;

// 分享平台
@property (nonatomic, nonnull,strong) NSMutableArray *platformArr;

@property (nonatomic, strong) NSString *adressStr;

@property (nonatomic, strong) NSString *nickName;

@property (nonatomic, strong) NSString *userIcon;

@end

@implementation CYLiveViewController{
    bool use_cap_;
    UITapGestureRecognizer *tapGesture;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
    
    // 拉流
    [self repareStartPlay];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 界面消失要停止
    [_player pause];
    [_player stop];
    [_player shutdown];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scale = scrollView.contentOffset.x/self.view.bounds.size.width;
    self.ykNumLabel.alpha = scale;
    self.ykNumLabel1.hidden = YES;
    if (scale == 0) {
        self.ykNumLabel1.hidden = NO;
    }
    
}

- (void)creatUI {
    [self.view addSubview:self.showView];
    [self.showView addSubview:self.backdropView];
    [self.view insertSubview:self.scrollView aboveSubview:self.showView];
    
    [self.scrollView addSubview:self.topSideView];
    
    // topSideView
    [self.view addSubview:self.closeButton];
    
    [self.topSideView addSubview:self.bottomTool];
    [self.topSideView addSubview:self.anchorView];
    [self.topSideView addSubview:self.inPiaoView];
    
    [self.topSideView addSubview:self.ykNumLabel];
    self.anchorView.model = self.model;
    
    self.ykNumLabel.text = [NSString stringWithFormat:@"映客号:%@", self.model.id];
    self.ykNumLabel1.text = [NSString stringWithFormat:@"映客号:%@", self.model.id];
    
    [self.ykNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.anchorView.mas_bottom).offset(5);
        make.right.equalTo(self.topSideView.mas_right).offset(-10);
        make.width.equalTo(@200);
    }];
    
    [self.scrollView addSubview:self.ykNumLabel1];
    [self.ykNumLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.width.equalTo(@200);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-14);
        make.right.equalTo(self.view).offset(-10);
        make.width.height.equalTo(@40);
    }];
    
    [self.giftView setGiftClick:^(NSInteger tag) {
        
    }];
    __weak typeof(self) weakSelf = self;
    [self.giftView setGrayClick:^{
        weakSelf.bottomTool.hidden = NO;
    }];
}

- (void)repareStartPlay {
    
    // 创建IJKFFMoviePlayerController：专门用来直播，传入拉流地址就好了
    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.model.stream_addr] withOptions:nil];

    // 准备播放
    [playerVc prepareToPlay];

    // 强引用，反正被销毁
    _player = playerVc;

    playerVc.view.frame = [UIScreen mainScreen].bounds;

    [self.view insertSubview:playerVc.view atIndex:1];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.frame = self.view.bounds;
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(self.view.bounds.size.width, 0);
    }
    return _scrollView;
}

- (UIView *)showView {
    if (_showView == nil) {
        _showView = [[UIView alloc]init];
        _showView.frame = self.view.bounds;
        _showView.backgroundColor = [UIColor whiteColor];
    }
    return _showView;
}

- (UIImageView *)backdropView {
    if (_backdropView == nil) {
        _backdropView = [[UIImageView alloc] init];
        _backdropView.frame = self.view.bounds;
        _backdropView.contentMode = UIViewContentModeScaleAspectFill;
        // 虚化
        UIVisualEffect *effcet = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:effcet];
        visualEffectView.frame = _backdropView.bounds;
        [_backdropView addSubview:visualEffectView];
        NSString *urlStr = [NSString stringWithFormat:@"%@",self.model.creator.portrait];
        [_backdropView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"swipe_bg"]];
    }
    return _backdropView;
}

// 最上层视图
- (UIView *)topSideView {
    if (_topSideView == nil) {
        _topSideView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds), self.view.bounds.origin.y, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
        _topSideView.backgroundColor = [UIColor clearColor];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:_topSideView.bounds];
        imgView.image = [UIImage imageNamed:@"room_jianbian_all"];
        [_topSideView addSubview:imgView];
    }
    return _topSideView;
}

// 关闭按钮
- (UIButton *)closeButton {
    if (_closeButton == nil) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeRoom) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

// 关闭直播
- (void)closeRoom {
    //有连麦窗口则不能直接关闭
    if (self.remoteArray.count > 0) {
        return;
    }
    [self.navigationController popViewControllerAnimated:NO];
}

// 主播
- (CYAnchorView *)anchorView {
    if (!_anchorView) {
        _anchorView = [[CYAnchorView alloc] initWithFrame:CGRectMake(10, 30, 140, 36)];
        [_anchorView setFollowBlock:^(CYLiveModel *mode){
            
        }];
    }
    return _anchorView;
}

- (CYBottomView *)bottomTool{
    
    if (_bottomTool == nil) {
        _bottomTool = [[CYBottomView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 64, [UIScreen mainScreen].bounds.size.width, 64)];
        __weak typeof(self) weakSelf = self;
        [_bottomTool setButtonClick:^(NSInteger tag) {
            switch (tag) {
                case 100:
                    // 发送消息/弹幕
                {
                    
                }
                    break;
                case 101:
                    // 礼物
                {
                    [weakSelf.giftView popShow];
                    weakSelf.bottomTool.hidden = YES;
                }
                    
                    break;
                case 102:
                    // 显示分享面板
                {
                    
                }
                    
                    break;
                default:
                    break;
            }
        }];
    }
    return _bottomTool;
}

- (CYInPiaoView *)inPiaoView {
    if (!_inPiaoView) {
        _inPiaoView = [[CYInPiaoView alloc] initWithFrame:CGRectMake(10, 70, 140, 30)];
    }
    return _inPiaoView;
}

- (CYSendGiftView *)giftView {
    if (!_giftView) {
        _giftView = [[CYSendGiftView alloc] initWithFrame:self.view.bounds];
    }
    return _giftView;
}

- (UILabel *)ykNumLabel {
    if (!_ykNumLabel) {
        _ykNumLabel = [[UILabel alloc] init];
        _ykNumLabel.textColor = [UIColor whiteColor];
        _ykNumLabel.textAlignment = NSTextAlignmentRight;
        _ykNumLabel.font = [UIFont systemFontOfSize:12];
    }
    return _ykNumLabel;
}

- (UILabel *)ykNumLabel1 {
    if (!_ykNumLabel1) {
        _ykNumLabel1 = [[UILabel alloc] init];
        _ykNumLabel1.textColor = [UIColor whiteColor];
        _ykNumLabel1.textAlignment = NSTextAlignmentRight;
        _ykNumLabel1.font = [UIFont systemFontOfSize:12];
    }
    return _ykNumLabel1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
