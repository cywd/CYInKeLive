//
//  CYSearchView.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/14.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYSearchView.h"
#import "UIView+Add.h"

@interface CYSearchView ()

@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic,strong) UIButton *cancleButton;

@end

@implementation CYSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.searchBar];
        [self addSubview:self.cancleButton];
    }
    return self;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 75, 30)];
        [_searchBar setSearchBarStyle:UISearchBarStyleDefault];
        
        //_searchBar.barTintColor = [UIColor whiteColor];
        _searchBar.backgroundImage = [UIImage imageNamed:@"global_searchbox_bg"];
        
        _searchBar.layer.cornerRadius = 14;
        _searchBar.layer.masksToBounds = YES;
        [_searchBar setPlaceholder:@"请输入昵称/印客号"];
        
    }
    return _searchBar;
}

// 取消
- (void)cancleClick {
    if (self.cancleBlock) {
        self.cancleBlock();
    }
}

- (UIButton *)cancleButton {
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.frame = CGRectMake(self.searchBar.width + 5, 0, 50, 30);
        [_cancleButton addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _cancleButton;
}


@end
