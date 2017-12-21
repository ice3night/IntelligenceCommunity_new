//
//  MallSearchResult.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "MallSearchResult.h"
#import "TodayHotCell.h"
#import "MJExtension.h"
#import "DetailProductVc.h"
#import "SearchResult.h"
#import "ReLogin.h"
#import "ResultHeader.h"
@interface MallSearchResult ()<UICollectionViewDelegate,UICollectionViewDataSource,SearchResultHeaderDelegate>
{
    NSString *sales;
    NSString *view;
    NSString *price;
}
@end

@implementation MallSearchResult

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self initData];
}
- (void)initView{
    self.title = @"商品搜索";
    sales = @"";
    view = @"";
    price = @"1";
    //创建布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(0, 0);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    //最小水平间隙
    layout.minimumInteritemSpacing = 10;
    //最小垂直间隙
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    //设置单元格的大小
    //    layout.itemSize = CGSizeMake((CYScreanW-10)/2,  (CYScreanW-10)/2);
    //下面竖向滚动collectionView
    self.mcollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CYScreanW, CYScreanH) collectionViewLayout:layout];
    [self.view addSubview:self.mcollectionView];
    self.mcollectionView.delegate = self;
    self.mcollectionView.dataSource = self;
    self.mcollectionView.backgroundColor = CQColorFromRGB(0xf7fafc);
    self.mcollectionView.showsHorizontalScrollIndicator = NO;
    self.mcollectionView.bounces = YES;
    self.mcollectionView.showsVerticalScrollIndicator = NO;
    //xib注册
    [self.mcollectionView registerNib:[UINib nibWithNibName:@"TodayHotCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"TodayHotCell"];
    
    [self.mcollectionView registerClass:[ResultHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ResultHeader"];
}
- (void)initData{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    parames[@"comNo"]       =  [NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]];
    parames[@"currentPage"]       =  @"1";
    parames[@"pageSize"]       =  @"100";
    parames[@"name"]       =  self.key;
    parames[@"saleNum"]       =  sales;
    parames[@"viewCount"]       =  view;
    parames[@"price"]       =  price;
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/product/searchPro",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"%@",responseObject);
        NSNumber *success = [responseObject objectForKey:@"success"];
        NSDictionary *returnValue = [responseObject objectForKey:@"list"];
        if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
            self.sourceArr = [SearchResult objectArrayWithKeyValuesArray:returnValue];
            [self.mcollectionView reloadData];
        }else{
            [MBProgressHUD showSuccess:[responseObject objectForKey:@"error"] ToView:self.view];
            NSString *type = [responseObject objectForKey:@"type"];
            if ([type isEqualToString:@"1"]||[type isEqual:@"2"]) {
                ReLogin *relogin = [[ReLogin alloc] init];
                [self.navigationController presentViewController:relogin animated:YES completion:^{
                    
                }];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络错误" ToView:self.view];
    }];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(0, CYScreanH*0.08);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ResultHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ResultHeader" forIndexPath:indexPath];
    header.delegate = self;
    return header;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        TodayHotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TodayHotCell" forIndexPath:indexPath];
        [cell setModel:self.sourceArr[indexPath.item]];
        return cell;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sourceArr.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((CYScreanW-10)/2,  (CYScreanW-10)/2+100);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    DetailProductVc *order = [[DetailProductVc alloc] init];
    SearchResult *model = self.sourceArr[indexPath.row];
    order.shopId = model.shopId;
    order.proId = [NSString stringWithFormat:@"%@",model.id];
    [self.navigationController pushViewController:order  animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setHidden:NO];
}
//按照价格排序
-(void)priceAction
{
    sales = @"";
    view = @"";
    price = @"1";
    NSLog(@"代理方法");
    [self initData];
}
//按照人气排序
-(void)viewAction
{
    sales = @"";
    view = @"1";
    price = @"";
    [self initData];
}
//按照销量排序
-(void)salesAction
{
    sales = @"2";
    view = @"";
    price = @"";
    [self initData];
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
