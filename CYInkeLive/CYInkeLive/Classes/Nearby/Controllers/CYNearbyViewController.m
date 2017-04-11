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

#define nearbyMargin 3

@interface CYNearbyViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, CLLocationManagerDelegate>

//定位
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy)NSString *requestUrl;

@property (nonatomic, assign) NSInteger index;

@end

@implementation CYNearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _index = 0;
    
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
    [self loadData];
}

- (void)loadData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:self.requestUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *appDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        self.dataArray = [CYLiveModel mj_objectArrayWithKeyValuesArray:appDic[@"lives"]];
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
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
        
    }
    return _collectionView;
}

@end
