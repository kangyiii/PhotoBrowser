//
//  ViewController.m
//  MJPhotoBrowser改进版
//
//  Created by 康义 on 2017/12/19.
//  Copyright © 2017年 康义. All rights reserved.
//

#import "ViewController.h"
#import "MJPhoto.h"
#import "ImageCell.h"
#import "MJPhotoBrowser.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)NSMutableArray <MJPhoto *> * dataArr;

@property (nonatomic, strong)UICollectionView * collectionView;

@end

@implementation ViewController
//collectionView懒加载
- (UICollectionView *)collectionView {
    if(_collectionView==nil){
        //UICollectionViewFlowLayout是系统提供给我们一个封装好的流布局设置类，其中有一些布局属性我们可以进行设置
        //最小行距，最小列距，item大小，item估计大小（通常自适应行高用到），布局方向，头尾视图尺寸，分区的偏移量，这些属性也可以通过delagate来进行设置
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.minimumInteritemSpacing = 5.0f;// 垂直方向的间距
        layout.minimumLineSpacing = 5.0f; // 水平方向的间距
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 5, [[UIScreen mainScreen] bounds].size.width-10, [[UIScreen mainScreen] bounds].size.height-64) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (NSMutableArray<MJPhoto *> *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"MJPhotoBrowser改进版";
    
    //填充数组
    NSArray * picArr = @[@"http://www.zzgs.gov.cn/picture/0/2017527161138.jpg",@"http://www.zzgs.gov.cn/picture/0/2017527161138.jpg",@"http://www.zzgs.gov.cn/picture/0/2017527161138.jpg",@"http://www.zzgs.gov.cn/picture/0/2017527161138.jpg",@"http://www.zzgs.gov.cn/picture/0/2017527161138.jpg",@"http://www.zzgs.gov.cn/picture/0/2017527161138.jpg1",@"http://www.zzgs.gov.cn/picture/0/2017527161138.jpg1"];
    for(NSString * str in picArr){
        MJPhoto * photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:str];
        [self.dataArr addObject:photo];
    }
    
    [self.view addSubview:self.collectionView];
}

/** 总共多少组*/
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:self.dataArr[indexPath.row].url];
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout

/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width/4.3, [[UIScreen mainScreen] bounds].size.width/4.3);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = indexPath.row; // 弹出相册时显示的第一张图片是？
    browser.photos = self.dataArr; // 设置所有的图片
    [browser show];
}

@end
