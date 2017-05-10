//
//  SkyLeftItemsViewController.m
//  LeftCollectionViewItemsFlowLayout
//
//  Created by fangd@silviscene.com on 2017/5/8.
//  Copyright © 2017年 skm. All rights reserved.
//

#import "SkyLeftItemsViewController.h"
#import "Header.h"
#import "SkyLeftItemsModel.h"
#import "SkyLeftCollectionViewItems.h"
#import "SkyLeftItemsCollectionViewFlowLayout.h"
@interface SkyLeftItemsViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *collectionDataArray;
//导航栏
@property (nonatomic,strong)UIView *navigationView;
@end

@implementation SkyLeftItemsViewController
#pragma mark --- 懒加载
- (NSMutableArray *)collectionDataArray
{
    if (_collectionDataArray == nil) {
        _collectionDataArray = [NSMutableArray array];
    }
    return _collectionDataArray;
}
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        //layOut布局
        SkyLeftItemsCollectionViewFlowLayout *flowLayout = [[SkyLeftItemsCollectionViewFlowLayout alloc]init];
        //创建集合视图
        UICollectionView *collectionView  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor  = [UIColor whiteColor];
        [collectionView registerClass:[SkyLeftCollectionViewItems class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView = collectionView;

    }
    return _collectionView;
}
#pragma mark --- 视图加载
static NSString * const reuseIdentifier = @"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createCustomNavigationBar];
    [self.view addSubview:self.collectionView];
    [self loadDataForSearch];
}
#pragma mark --- 数据请求
- (void)loadDataForSearch{
    WS(weakSelf);
    [SkyLeftItemsModel dealDataWithSucess:^(NSMutableDictionary *dataDictionary) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObjectsFromArray:dataDictionary[@"SkyNameModel"]];
//        [weakSelf.collectionDataArray removeAllObjects];
        [weakSelf.collectionDataArray addObjectsFromArray:array];
        [weakSelf.collectionView reloadData];
    } FailureBlock:^(NSError *error) {
        
    }];
}
#pragma mark-----创建自定义navigationBar
-(void)createCustomNavigationBar
{
    UIView *navigationView = [[UIView alloc]init];
    [self.view addSubview:navigationView];
    self.navigationView = navigationView;
    
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.backgroundColor = kRGBColor(100, 149, 237);
    [navigationView addSubview:bgView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backBtnClcik:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backButton];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setImage:[UIImage imageNamed:@"ic_menu_search_f.png"] forState:UIControlStateNormal];
    
    [searchButton addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:searchButton];
    
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.delegate = self;
    searchBar.searchBarStyle = UISearchBarStyleDefault;
    [searchBar setBackgroundImage:[UIImage new]];
    self.searchBar = searchBar;
    [navigationView addSubview:searchBar];
    
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(WIDTH));
        make.height.mas_equalTo(@(64));
        make.top.left.equalTo(self.view);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(WIDTH));
        make.height.mas_equalTo(@(64));
        make.top.left.equalTo(self.view);
    }];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(49));
        make.height.mas_equalTo(@(20));
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.view).offset(35);
    }];
    
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@25);
        make.height.mas_equalTo(@25);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(backButton.mas_top).offset(-2.5);
    }];
    
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30);
        make.bottom.equalTo(navigationView.mas_bottom).offset(-6);
        make.left.equalTo(backButton.mas_right).offset(15);
        make.right.equalTo(searchButton.mas_left).offset(-15);
    }];
}
#pragma mark --- 返回上一个界面
- (void)backBtnClcik:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --- 搜索按钮
-(void)searchBtnClick:(UIButton *)sender
{
    if (self.searchBar.searchResultsButtonSelected == YES) {
        return;
    }
    [self.searchBar resignFirstResponder];
    
    if (self.searchBar.text.length == 0) {
        return;
    }
    
}
#pragma mark --- 搜索代理
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        
    }
    
}
#pragma mark --- 搜索按钮的点击事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //键盘消失，searchBar失去第一响应
    [searchBar resignFirstResponder];
    //如果searchBar.text为空 则点击事件无效
    if (searchBar.text.length == 0) {
        return;
    }
    //将搜索的字加到collectionView上
    SkyNameModel *model = [[SkyNameModel alloc]init];
    model.NAME = searchBar.text;
    [self.collectionDataArray addObject:model];
    [self.collectionView reloadData];
    // Do the search...
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SkyLeftCollectionViewItems *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (self.collectionDataArray.count != 0) {
        SkyNameModel *model = self.collectionDataArray[indexPath.row];
        cell.model = model;
    }

    // Configure the cell
    
    return cell;
}
//计算每个items的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //model里的widthCount为model.NAME的自适应宽度
    if (self.collectionDataArray.count != 0) {
        SkyNameModel *model = self.collectionDataArray[indexPath.row];
        return CGSizeMake(model.widthCount+20, 44);
    }
    return CGSizeZero;

}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self loadDataForSearch];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
