//
//  NewMallViewController.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/12/16.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "NewMallViewController.h"
#import "TodaySetionHeader.h"
#import "TodayHotCell.h"
#import "DetailProductVc.h"
#import "ReLogin.h"
#import "MallSearchVc.h"
#import "MJExtension.h"
#import "MallRectCell.h"
#import "MallRecSectionView.h"
#import "MallCateCell.h"
#import "tuanViewController.h"
#import "weishopViewController.h"
@interface NewMallViewController ()<MallCateCellDelegate,OnClickCMallDelegate>
{
    UIView *bgView;
}
@end

@implementation NewMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.recommendedMArray = [[NSMutableArray alloc] init];
    self.sourceArr = [[NSMutableArray alloc] init];
    [self createMainView];
    [self initData];
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
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@//api/seller/homePage",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"%@",responseObject);
        NSNumber *success = [responseObject objectForKey:@"success"];
        NSDictionary *returnValue = [responseObject objectForKey:@"returnValue"];
        if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
            NSString *slideImage = [returnValue objectForKey:@"slideshow"];
            self.showImagesArry = [slideImage componentsSeparatedByString:@","];
            NSDictionary *hotPro = [returnValue objectForKey:@"hotPro"];
            self.sourceArr = [TodayCMDModel objectArrayWithKeyValuesArray:hotPro];
            self.shop = [MallRecShop objectWithKeyValues:[returnValue objectForKey:@"isVip"]];
            [self.collectionView reloadData];
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
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController.navigationBar setHidden:YES];
    
}
#pragma mark - 创建主View
- (void)createMainView {
    //    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.02, CYScreanW, (CYScreanH - 64) * 0.15)];
    //    image.image = [UIImage imageNamed:@"pic_pull_down"];
    //    [self.view addSubview:image];
    
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
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -20, CYScreanW, CYScreanH) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = CQColorFromRGB(0xf7fafc);
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = YES;
    self.collectionView.showsVerticalScrollIndicator = YES;
    //xib注册
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductCMDCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ProductCMDCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TodayHotCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"TodayHotCell"];
    [self.collectionView registerClass:[MallRectCell class] forCellWithReuseIdentifier:@"MallRectCell"];
    [self.collectionView registerClass:[TodayCMDCell class] forCellWithReuseIdentifier:@"TodayCMDCell"];
    [self.collectionView registerClass:[MallCateCell class] forCellWithReuseIdentifier:@"MallCateCell"];
    [self.collectionView registerClass:[MallRecSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MallRecSectionView"];
    [self.collectionView registerClass:[MallCateCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MallCateCell"];
    bgView = [[UIView alloc] init];
    bgView.backgroundColor = CQColor(247,247,247, 0);
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    //（navigationbar）
    CGRect rectOfNavigationbar = self.navigationController.navigationBar.frame;
    bgView.frame = CGRectMake(0, 0, CYScreanW, rectOfNavigationbar.size.height+rectOfStatusbar.size.height);
    UIView *view = [[UIView alloc] init];
    UIImage *bgImage = [UIImage imageNamed:@"bg_textfield"];
    UIImage *BtnImage = [UIImage imageNamed:@"icon_second_search"];
    UIImageView *searchimg = [[UIImageView alloc] initWithFrame:CGRectMake(10, (bgImage.size.height-BtnImage.size.height)/2, BtnImage.size.width, BtnImage.size.height)];

    [searchimg setImage:BtnImage];
    UIButton *searchBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 0, bgImage.size.width, bgImage.size.height);
    searchBtn.backgroundColor = [UIColor whiteColor];
    searchBtn.alpha = 0.1;
    [searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    view.frame = CGRectMake((CYScreanW-bgImage.size.width)/2, rectOfStatusbar.size.height+(self.navigationController.navigationBar.frame.size.height - bgImage.size.height)/2, bgImage.size.width, bgImage.size.height);
    UIImageView *viewBg = [[UIImageView alloc] initWithImage:bgImage];
    
    viewBg.frame = CGRectMake(0, 0, bgImage.size.width, bgImage.size.height);
    
    [view addSubview:viewBg];
    [view addSubview:searchBtn];
    [view addSubview:searchimg];
    [bgView addSubview:view];
    [self.view addSubview:bgView];
}
- (void)search{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    MallSearchVc *searchVc = [[MallSearchVc alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (targetContentOffset->y > 20.000000) {
        bgView.backgroundColor = CQColor(247,247,247, 1);
    }else{
        bgView.backgroundColor = CQColor(247,247,247, 0);
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return  CGSizeMake(CYScreanH, CYScreanH *0.08);
    }else{
        return  CGSizeMake(0, 0);
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    MallRecSectionView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MallRecSectionView" forIndexPath:indexPath];
    if (indexPath.section == 3) {
        return header;
    }else {
        return nil;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 3){
        TodayHotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TodayHotCell" forIndexPath:indexPath];
        [cell setModel:self.sourceArr[indexPath.item]];
        return cell;
    }else if(indexPath.section == 2){
        MallRectCell *cell = (MallRectCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MallRectCell" forIndexPath:indexPath];
        [cell setShop:self.shop];
        return cell;
    }else{
    TodayCMDCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TodayCMDCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
            self.shufflingFigureView = [[JXBAdPageView alloc] init];
            self.shufflingFigureView.frame = CGRectMake( 0, 0, CYScreanW, CYScreanW*647/1440);
            self.shufflingFigureView.bWebImage = YES;//网络图片
            self.shufflingFigureView.iDisplayTime = 4;//停留时间
            self.shufflingFigureView.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:self.shufflingFigureView];
            
            [self.shufflingFigureView startAdsWithBlock:self.showImagesArry block:^(NSInteger clickIndex)
             {
                 NSLog(@"第%ld张",(long)clickIndex);
             }];
//        }
    }else if (indexPath.section == 1){
        if (self.comMallView == nil)
        {
            self.comMallView = [[ComMallView alloc] initWithFrame:CGRectMake(0, 0, CYScreanW, (CYScreanH - 64) * 0.25)];
        }
        self.comMallView.CMallDelegate = self;
        self.comMallView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:self.comMallView];
    }
        return cell;
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 3) {
        return self.sourceArr.count;
    }else{
        return 1;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(CYScreanW,  CYScreanW*647/1440);
    }else if (indexPath.section == 1) {
        return CGSizeMake(CYScreanW,  (CYScreanH-64)*0.25);
    }else if(indexPath.section == 2){
        return CGSizeMake(CYScreanW, (CYScreanH-64)*0.25);
    }else {
        return CGSizeMake((CYScreanW-10)/2,  (CYScreanW-10)/2+100);
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailProductVc *order = [[DetailProductVc alloc] init];
    if (indexPath.section == 2) {
        MerchantsPageViewController *MPController = [[MerchantsPageViewController alloc] init];
        MPController.MerchantsId = [NSString stringWithFormat:@"%@",self.shop.id];
        [self.navigationController pushViewController:MPController animated:YES];
    }else if(indexPath.section == 3){
        TodayCMDModel *model =     self.sourceArr[indexPath.row];
        order.shopId = model.shopId;
        order.proId = model.id;
        [self.navigationController pushViewController:order  animated:YES];
    }
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 按钮代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - -- -
//超市
- (void) supermarketFunction
{
    MerchantsPageViewController *MPController = [[MerchantsPageViewController alloc] init];
    MPController.MerchantsId = @"16";
    [self.navigationController pushViewController:MPController animated:YES];
}
//团购
- (void) foodMarket
{
    MerchantsPageViewController *MPController = [[MerchantsPageViewController alloc] init];
    MPController.MerchantsId = @"15";
    [self.navigationController pushViewController:MPController animated:YES];
}
//微店
- (void) microShop
{
    //[MBProgressHUD showError:@"正在修改中！" ToView:self.view];
    weishopViewController * wei = [[weishopViewController alloc]init];
    [self.navigationController pushViewController:wei animated:YES];
}
//团购
- (void) groupPurchase
{
    tuanViewController * tuan = [[tuanViewController alloc]init];
    [self.navigationController pushViewController:tuan animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

