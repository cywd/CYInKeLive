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

@interface CYLiveViewController ()

@property (nonatomic, strong) IJKFFMoviePlayerController *player;
//最上层的视图
@property (nonatomic, strong) UIView *topSideView;
//直播窗口
@property (nonatomic, strong) UIView *showView;
//占位图
@property (nonatomic, strong) UIImageView *backdropView;

//关闭直播
@property (nonatomic, strong) UIButton *closeButton;

//连麦视屏窗口数
@property (nonatomic, strong) NSMutableArray *remoteArray;

//分享平台
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
    
    //拉流
    [self repareStartPlay];
}

- (void)viewWillAppear:(BOOL)animated{
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
    
//    [self.view addSubview:self.anchorView];
//    [self.topSideView addSubview:self.bottomTool];
//    
//    [self.topSideView addSubview:self.keyBoardView];
//    [self.topSideView addSubview:self.messageTableView];
//    [self.topSideView addSubview:self.presentView];
//    
//    [self.view addSubview:self.danmuView];
    
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-14);
        make.right.equalTo(self.view).offset(-10);
        make.width.height.equalTo(@40);
    }];
    
//    [self registerForKeyboardNotifications];
    
    //送礼物
//    WEAKSELF;
//    [self.giftView setGiftClick:^(NSInteger tag) {
//        [weakSelf chooseGift:tag + 100];
//    }];
//    //显示底部工具栏
//    [self.giftView setGrayClick:^{
//        [weakSelf bottomToolShow];
//    }];
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    [self.view addGestureRecognizer:tapGesture];
}

// 键盘弹起
- (void)keyboardWasShown:(NSNotification*)notification {
//    NSDictionary *info = [notification userInfo];
//    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    if (self.keyBoardView) {
//        self.keyBoardView.frame = CGRectMake(self.keyBoardView.frame.origin.x, CGRectGetMaxY(self.view.frame)-CGRectGetHeight(self.keyBoardView.frame)-keyboardRect.size.height, CGRectGetWidth(self.keyBoardView.frame), CGRectGetHeight(self.keyBoardView.frame));
//    }
//    
//    if (self.messageTableView) {
//        self.messageTableView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)-CGRectGetHeight(self.keyBoardView.frame)-keyboardRect.size.height - CGRectGetHeight(self.messageTableView.frame) -10, CGRectGetWidth(self.messageTableView.frame), 120);
//    }
//    if (self.danmuView) {
//        self.danmuView.frame = CGRectMake(self.danmuView.frame.origin.x, CGRectGetMinY(self.messageTableView.frame)-CGRectGetHeight(self.danmuView.frame), CGRectGetWidth(self.danmuView.frame), CGRectGetHeight(self.danmuView.frame));
//    }
}

// 键盘隐藏
- (void)keyboardWasHidden:(NSNotification*)notification {
//    if (self.keyBoardView) {
//        self.keyBoardView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame), self.view.bounds.size.width, 44);
//    }
//    if (self.messageTableView) {
//        self.messageTableView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)-180, CGRectGetWidth(self.view.frame)/3*2, 120);
//    }
//    if (self.danmuView) {
//        self.danmuView.frame = CGRectMake(self.danmuView.frame.origin.x, CGRectGetMinY(self.messageTableView.frame)-CGRectGetHeight(self.danmuView.frame), CGRectGetWidth(self.danmuView.frame), CGRectGetHeight(self.danmuView.frame));
//    }
}

- (void)tapEvent:(UITapGestureRecognizer*)recognizer {
//    DMHeartFlyView* heart = [[DMHeartFlyView alloc]initWithFrame:CGRectMake(0, 0, 46, 46)];
//    [self.view addSubview:heart];
//    CGPoint fountainSource = CGPointMake(SCREEN_WIDTH - 40, self.view.bounds.size.height - 90);
//    heart.center = fountainSource;
//    [heart animateInView:self.view];
    
    
//    CGPoint point = [recognizer locationInView:self.view];
//    CGRect rect = [self.view convertRect:self.keyBoardView.frame toView:self.view];
//    if (CGRectContainsPoint(rect, point)) {
//        
//    }else{
//        if (self.keyBoardView.isEdit) {
//            [self.keyBoardView editEndTextField];
//        }
//    }
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

- (UIView *)showView{
    if (_showView == nil) {
        _showView = [[UIView alloc]init];
        _showView.frame = self.view.bounds;
        _showView.backgroundColor = [UIColor whiteColor];
    }
    return _showView;
}


- (UIImageView *)backdropView{
    if (_backdropView == nil) {
        _backdropView = [[UIImageView alloc]init];
        _backdropView.frame = self.view.bounds;
        NSString *urlStr = [NSString stringWithFormat:@"%@",self.model.creator.portrait];
        [_backdropView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"swipe_bg"]];
        UIVisualEffect *effcet = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:effcet];
        visualEffectView.frame = _backdropView.bounds;
        [_backdropView addSubview:visualEffectView];
    }
    return _backdropView;
}

//最上层视图
- (UIView *)topSideView{
    if (_topSideView == nil) {
        _topSideView = [[UIView alloc]initWithFrame:self.view.bounds];
        _topSideView.backgroundColor = [UIColor clearColor];
    }
    return _topSideView;
}

//关闭按钮
- (UIButton *)closeButton{
    if (_closeButton == nil) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeRoom) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

//关闭直播
- (void)closeRoom{
    //有连麦窗口则不能直接关闭
    if (self.remoteArray.count > 0) {
        return;
    }
    [self.navigationController popViewControllerAnimated:NO];
}


@end
