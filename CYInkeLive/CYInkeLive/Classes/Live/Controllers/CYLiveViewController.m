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

@interface CYLiveViewController ()

@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@property (nonatomic, strong) CYAnchorView *anchorView;

@property (nonatomic, strong) CYBottomView *bottomTool;

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatUI {
    [self.view addSubview:self.showView];
    [self.showView addSubview:self.backdropView];
    [self.view insertSubview:self.topSideView aboveSubview:self.showView];
    [self.view addSubview:self.closeButton];
    
    [self.view addSubview:self.anchorView];
    self.anchorView.model = self.model;
    
    [self.topSideView addSubview:self.bottomTool];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-14);
        make.right.equalTo(self.view).offset(-10);
        make.width.height.equalTo(@40);
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
        _topSideView = [[UIView alloc]initWithFrame:self.view.bounds];
        _topSideView.backgroundColor = [UIColor clearColor];
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
        _anchorView = [[CYAnchorView alloc]initWithFrame:CGRectMake(10, 30, 150, 36)];
    }
    return _anchorView;
}

- (CYBottomView *)bottomTool{
    
    if (_bottomTool == nil) {
        _bottomTool = [[CYBottomView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 64, [UIScreen mainScreen].bounds.size.width, 64)];

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


@end
