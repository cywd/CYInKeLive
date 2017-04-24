//
//  CYSendGiftView.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/24.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYSendGiftView.h"
#import <Masonry.h>
#import "FlowLayout.h"
#import "CYGiftCollectionViewCell.h"

#define GifGetY [UIScreen mainScreen].bounds.size.height - 280
#define Collor_Simple [UIColor colorWithRed:0 green:0 blue:0 alpha:0.58]
#define Collor_Deep [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]

@interface CYSendGiftView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *rechargeView;
@property (nonatomic, strong) UIButton *rechargeButton;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation CYSendGiftView {
    NSInteger _reuse;
}

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

#pragma mark - collection delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 24;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYGiftCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RegisterId" forIndexPath:indexPath];
    if (self.dataArr.count > 0) {
        cell.giftImageView.image = [UIImage imageNamed:self.dataArr[indexPath.row]];
        if (_reuse == indexPath.row) {
            cell.hitButton.selected = YES;
        } else {
            cell.hitButton.selected = NO;
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - event response
- (void)sendTap {
    if (self.giftClick) {
        self.giftClick(_reuse);
    }
}

//弹出礼物
- (void)popShow{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

//点击上方灰色区域移除视图
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    CGPoint point = [touch locationInView:self];
    if ( point.y < GifGetY) {
        if (self.grayClick) {
            self.grayClick();
        }
        [self removeFromSuperview];
    }
}

#pragma mark - private methods
- (void)createUI {
    [self.rechargeView addSubview:self.pageControl];
    [self addSubview:self.collectionView];
    [self addSubview:self.rechargeView];
    [self.rechargeView addSubview:self.rechargeButton];
    [self.rechargeView addSubview:self.sendButton];
}

#pragma mark - getters and setters
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        FlowLayout *flowLay = [[FlowLayout alloc]init];
        flowLay.minimumLineSpacing = 0;
        flowLay.minimumInteritemSpacing = 0;
        flowLay.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLay.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/4, 110);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, GifGetY, [UIScreen mainScreen].bounds.size.width, 220) collectionViewLayout:flowLay];
        _collectionView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        _collectionView.bounces = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[CYGiftCollectionViewCell class] forCellWithReuseIdentifier:@"RegisterId"];

    }
    return _collectionView;
}

- (UIView *)rechargeView {
    if (!_rechargeView) {
        _rechargeView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 60, [UIScreen mainScreen].bounds.size.width, 60)];
        _rechargeView.backgroundColor = Collor_Deep;
    }
    return _rechargeView;
}

- (UIButton *)rechargeButton {
    if (!_rechargeButton) {
        _rechargeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
        [_rechargeButton setTitleColor:[UIColor colorWithRed:249/255.f green:179/255.f blue:61/255.f alpha:1] forState:UIControlStateNormal];
        _rechargeButton.frame = CGRectMake(0, 0, 100, 60);
        _rechargeButton.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _rechargeButton;
}

- (UIButton *)sendButton {
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width- 70, 17, 60, 26);
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:17];
        _sendButton.layer.cornerRadius = 12;
        _sendButton.layer.masksToBounds = YES;
        [_sendButton setBackgroundColor:[UIColor colorWithRed:36/255.f green:215/255.f blue:200/255.f alpha:1]];
        [_sendButton addTarget:self action:@selector(sendTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 20, 5, 40, 20)];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 3;
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
        [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    }
    return _pageControl;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

#pragma mark - receive and dealloc

@end
