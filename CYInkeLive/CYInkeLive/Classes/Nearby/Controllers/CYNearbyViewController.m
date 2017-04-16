//
//  CYNearbyViewController.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/11.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYNearbyViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CYNearbyCollectionViewCell.h"
#import "YKAPI.h"
#import "CYLiveModel.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import "CYNearbyHeaderCollectionReusableView.h"
#import "CYMainRefrashGifHeader.h"
#import "UIView+CYDisplay.h"
#import "YKConst.h"

#define nearbyMargin 3

@interface CYNearbyViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, CLLocationManagerDelegate>

/** 上次选中的索引(或者控制器) */
@property (nonatomic, assign) NSInteger lastSelectedIndex;

//定位
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) NSString *requestUrl;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UIAlertController *alertVc;

@property (nonatomic, copy) NSString *limitStr;

@end

@implementation CYNearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _index = 0;
    
    _limitStr = @"看全部";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.locationManager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 2 * nearbyMargin)/3, ([UIScreen mainScreen].bounds.size.width - 2 * nearbyMargin)/3 * 1.3);
}

#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CYNearbyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CYNearbyCollectionViewCell class]) forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    CYNearbyCollectionViewCell *nearCell = (CYNearbyCollectionViewCell *)cell;
    [nearCell showAnimation];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CYNearbyHeaderId" forIndexPath:indexPath];
    
    if ([reusableView isKindOfClass:[CYNearbyHeaderCollectionReusableView class]]) {
        CYNearbyHeaderCollectionReusableView *headView = (CYNearbyHeaderCollectionReusableView *)reusableView;
        [headView setBtnTitle:_limitStr];
        __weak typeof(self) weakSelf = self;
        [headView setChooseCondition:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf showAcition];
        }];
    }
    
    return reusableView;
}

#pragma CLLocationManagerDelegate
//定位成功
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    if (_index == 1) {
        return;
    }
    self.requestUrl = [NSString stringWithFormat:NearByUrl,newLocation.coordinate.latitude,newLocation.coordinate.longitude];
    [self.locationManager stopUpdatingLocation];
    [self setUpLocation];
    _index ++;
}
//定位失败
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    self.requestUrl = [NSString stringWithFormat:NearFakeUrl];
    [self setUpLocation];
}

- (void)setUpLocation {
    CYMainRefrashGifHeader *header = [CYMainRefrashGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    [header beginRefreshing];
    self.collectionView.mj_header = header;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelect) name:CYTabBarDidSelectNotification object:nil];
}

- (void)loadData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:self.requestUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.dataArray removeAllObjects];
        NSDictionary *appDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        self.dataArray = [CYLiveModel mj_objectArrayWithKeyValuesArray:appDic[@"lives"]];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
    }];
}

//选择限制条件
- (void)showAcition{
    [self presentViewController:self.alertVc animated:YES completion:^{
        NSLog(@"已经弹出");
    }];
}

- (void)changeRequestURLWithIndex:(NSInteger)index {
    //限制条件未知  0为查看全部  1查看女生  2为男生
    NSString *limitStr = [NSString stringWithFormat:@"&interest=%zd",index];
    
    if ([self.requestUrl rangeOfString:@"&interest"].location == NSNotFound) {
        self.requestUrl = [NSString stringWithFormat:@"%@%@",self.requestUrl,limitStr];
    } else {
        NSArray *arr = [self.requestUrl componentsSeparatedByString:@"&interest"];
        self.requestUrl = [NSString stringWithFormat:@"%@%@",arr[0],limitStr];
    }
    
    switch (index) {
        case 0:
            _limitStr = @"看全部";
            break;
        case 1:
            _limitStr = @"只看女";
            break;
        case 2:
            _limitStr = @"只看男";
            break;
        default:
            break;
    }
    
//    [self loadData];
    [self.collectionView.mj_header beginRefreshing];
}

- (void)tabBarSelect {
    
    if (![self.view isDisplayedInScreen]) {
        return;
    }
    
    // 如果是连续点击2次，直接刷新
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && self.tabBarController.selectedViewController == self.navigationController) {
        
        [self.collectionView.mj_header beginRefreshing];
    }
    
    // 记录这一次选中的索引
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        //创建定位对象
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 100.0;
//        [_locationManager requestWhenInUseAuthorization];
        [_locationManager requestAlwaysAuthorization];
    }
    return _locationManager;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = nearbyMargin;
        layout.minimumInteritemSpacing = nearbyMargin;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 113)  collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CYNearbyCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CYNearbyCollectionViewCell class])];
        [_collectionView registerNib:[UINib nibWithNibName:@"CYNearbyHeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CYNearbyHeaderId"];
    }
    return _collectionView;
}

- (UIAlertController *)alertVc
{
    if (!_alertVc) {
        _alertVc = [UIAlertController alertControllerWithTitle:@"选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *allAction = [UIAlertAction actionWithTitle:@"看全部" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self changeRequestURLWithIndex:0];
        }];
        UIAlertAction *manAction = [UIAlertAction actionWithTitle:@"只看男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self changeRequestURLWithIndex:2];
        }];
        UIAlertAction *faleAction = [UIAlertAction actionWithTitle:@"只看女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self changeRequestURLWithIndex:1];
        }];
        
        [_alertVc addAction:allAction];
        [_alertVc addAction:manAction];
        [_alertVc addAction:faleAction];
        [_alertVc addAction:cancelAction];
    }
    return _alertVc;
}

- (void)dealloc {
    self.collectionView.dataSource = nil;
    self.collectionView.delegate = nil;
    self.locationManager.delegate = nil;
    
    
}

@end
