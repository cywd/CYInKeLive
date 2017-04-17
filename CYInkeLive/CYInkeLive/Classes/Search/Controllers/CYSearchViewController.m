//
//  CYSearchViewController.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/11.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYSearchViewController.h"
#import "CYSearchView.h"
#import "CYRecommendTableViewCell.h"
#import "CYRecommendContentTableViewCell.h"
#import "CYRecommendTitleView.h"
#import <AFNetworking.h>
#import "YKAPI.h"
#import <MJExtension.h>
#import "CYRecommendModel.h"
#import "CYRecommendMoreViewController.h"

@interface CYSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CYSearchView *searchView;
@property (nonatomic, strong) UITableView *tableView;

// 标题
@property (nonatomic, strong) NSMutableArray *sectionTitleArr;

@property (nonatomic, strong) NSMutableArray *dataArr;
// 今日推荐数组
@property (nonatomic, strong) NSMutableArray *recommendArray;

@property (nonatomic, strong) CYRecommendTitleView *titleView;

@end

@implementation CYSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.searchView;
    [self.view addSubview:self.tableView];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchView endEdit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchView endEdit];
}

#pragma UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == self.sectionTitleArr.count ? self.recommendArray.count : 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitleArr.count + 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    _titleView = [[[NSBundle mainBundle] loadNibNamed:@"CYRecommendTitleView" owner:self options:nil] lastObject];
    
    if (self.sectionTitleArr.count > 0) {
        if (section < self.sectionTitleArr.count) {
            _titleView.recommedTitle.text = self.sectionTitleArr[section];
        } else {
            _titleView.recommedTitle.text = @"今日推荐";
            _titleView.recommendButton.hidden = YES;
        }
    }
    __weak typeof(self) weakSelf = self;
    [_titleView setRecommdMoreClick:^(NSString *keyStr) {
        
        CYRecommendMoreViewController *vc = [[CYRecommendMoreViewController alloc] init];
        vc.keyword = keyStr;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    return _titleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == self.sectionTitleArr.count ? 60 : 170;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section < self.sectionTitleArr.count) {
        // 好声音、小清新、搞笑达人
        CYRecommendContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYRecommendContentTableViewCell"];
        cell.model = self.dataArr[indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        // 今日推荐
        CYRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYRecommendTableViewCell"];
        cell.indexPath = indexPath;
        [cell setFollowBlock:^(NSIndexPath *tapIndexPath) {
            
        }];
        cell.model = self.recommendArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)loadData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:SEARCHURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *appDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        // 字典那转Model
        CYRecommendModel *model = [CYRecommendModel mj_objectWithKeyValues:appDic];
        for (NSInteger i = 0; i < model.live_nodes.count; i++) {
            [self.sectionTitleArr addObject:model.live_nodes[i].title];
            [self.dataArr addObject:model.live_nodes[i]];
        }
        //今日推荐
        for (NSInteger i = 0; i < model.user_nodes[0].users.count; i++) {
            [self.recommendArray addObject:model.user_nodes[0].users[i]];
        }
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 搜索栏
- (CYSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[CYSearchView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        __weak typeof(self) weakSelf = self;
        [_searchView setCancleBlock:^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _searchView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"CYRecommendTableViewCell" bundle:nil] forCellReuseIdentifier:@"CYRecommendTableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"CYRecommendContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"CYRecommendContentTableViewCell"];
    }
    return _tableView;
}

// 标题数组
- (NSMutableArray *)sectionTitleArr {
    if (!_sectionTitleArr) {
        _sectionTitleArr = [NSMutableArray array];
    }
    return _sectionTitleArr;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

// 今日热门
- (NSMutableArray *)recommendArray {
    if (!_recommendArray) {
        _recommendArray = [NSMutableArray array];
    }
    return _recommendArray;
}


@end
