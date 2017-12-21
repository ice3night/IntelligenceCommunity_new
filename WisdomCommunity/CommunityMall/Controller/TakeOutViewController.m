//
//  TakeOutViewController.m
//  WisdomCommunity
// 社区商城下的 顶部第一个图标  外卖控制器
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "TakeOutViewController.h"
#import "MJExtension.h"
#import "ProductCateCell.h"
#import "DetailProductVc.h"
@interface TakeOutViewController ()

@end

@implementation TakeOutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTakeOutStryle];
    [self initTakeOutController];
    
    [self getMallListRequest:self.LabelCategoryId];//首页数据
}

//设置样式
- (void) setTakeOutStryle
{
    self.navigationItem.title = [NSString stringWithFormat:@"%@",self.ChooseClassificationString];

    
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    //显示导航栏
    [self.navigationController.navigationBar setHidden:NO];
}

//设置控件
- (void) initTakeOutController
{
    //显示商品
    self.TakeOutTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, (CYScreanH - 64))];
    self.TakeOutTableView.delegate = self;
    self.TakeOutTableView.dataSource = self;
    self.TakeOutTableView.showsVerticalScrollIndicator = NO;
    self.TakeOutTableView.backgroundColor = [UIColor whiteColor];
    self.TakeOutTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.TakeOutTableView];
    //提示模块
    UIImageView *PromptImageView = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.2, (CYScreanH - 64) * 0.25, CYScreanW * 0.6, (CYScreanH - 64) * 0.3)];
    PromptImageView.image = [UIImage imageNamed:@"missing_content_01"];
    [self.view addSubview:PromptImageView];
    self.TakeOutPromptImage = PromptImageView;
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//section底部间距
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TakeOutModel *model = self.allDataTOModelArray[indexPath.row];
    return (CYScreanH - 64) * 0.16;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allDataTOArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCateCell *cell = [ProductCateCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellAccessoryNone;
//    cell.delegate = self;
    TakeOutModel *model = _allDataTOArray[indexPath.row];
    cell.model = model;
    return cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailProductVc *order = [[DetailProductVc alloc] init];
        TakeOutModel *model = _allDataTOArray[indexPath.row];
        order.shopId = [NSString stringWithFormat:@"%@",model.shopId];
        order.proId = [NSString stringWithFormat:@"%@",model.id];
    [self.navigationController pushViewController:order  animated:YES];
}
//根据分类获取商城首页数据
- (void) getMallListRequest:(NSString *)categoryId
{
    self.TakeOutPromptImage.hidden = YES;//默认隐藏
    //显示进度条
    [MBProgressHUD showLoadToView:self.view];
    //小区数据
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/productCategoryList",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[NSString stringWithFormat:@"%@",self.LabelCategoryId] forKey:@"category"];
    [parames setObject:[NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]] forKey:@"comNo"];
    [parames setObject:[NSString stringWithFormat:@"%@",[CYSmallTools getDataStringKey:TOKEN]] forKey:@"token"];
    NSLog(@"parames = %@",parames);
    
    [self requestTOWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"根据分类商城首页请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
//        if ([[JSON objectForKey:@"success"] integerValue] == 1)
//        {
//            NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
//            if (!array.count)
//            {
//                if (!self.allDataTOModelArray.count) {
//                    self.TakeOutPromptImage.hidden = NO;
//                }
//                [MBProgressHUD showError:@"没有数据了" ToView:self.view];
//            }
//            else
        NSLog(@"返回数据%@",[JSON objectForKey:@"returnValue"]);
        _allDataTOArray = [[NSMutableArray alloc] init];
                _allDataTOArray = [TakeOutModel objectArrayWithKeyValuesArray:[JSON objectForKey:@"returnValue"]];
        NSLog(@"长度%lu",(unsigned long)_allDataTOArray.count);
            [self.TakeOutTableView reloadData];
//        }
//        else
//            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    }];
}
////获取综合排序和刷选数据
//- (void) RequestSortAndBrushRequest:(NSString *)RequestType
//{
//    //显示进度条
//    [MBProgressHUD showLoadToView:self.view];
//    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",POSTREQUESTURL,RequestType];
//
//    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
//    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
//    [parames setObject:[NSString stringWithFormat:@"%@",self.LabelCategoryId] forKey:@"category"];
//    [parames setObject:[NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]] forKey:@"comNo"];
//    NSLog(@"parames = %@,requestUrl = %@",parames,requestUrl);
//
//    [self requestTOWithUrl:requestUrl parames:parames Success:^(id responseObject)
//    {
//        [MBProgressHUD hideHUDForView:self.view];
//        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"获取综合排序和刷选数据请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
//        NSDictionary *list = [responseObject objectForKey:@"returnValue"];
//        if ([[JSON objectForKey:@"success"] integerValue] == 1)
//        {
//            NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
//            if (array.count)
//            {
////                [self initTakeOutModel:array];
//                _allDataTOArray = [TakeOutModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"returnValue"]];
//                [self.TakeOutTableView reloadData];
//            }
//            else
//                [MBProgressHUD showError:@"没有数据了" ToView:self.view];
//        }
//        else
//            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
//    }];
//}
//初始化数据源
- (void) initTakeOutModel:(NSArray *)array
{
    //初始化
    self.allDataTOArray = [[NSMutableArray alloc] init];
    self.allDataTOModelArray = [[NSMutableArray alloc] init];
    //数据源
    for (NSDictionary *MerchantsDict in array)
    {
        NSDictionary *dataDict = @{
                                   @"headString"        :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"imgBiao"]],
                                   @"nameString"        :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"shopName"]],
                                   @"startTOString"       :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"zongHePingFen"]],
                                   @"numberString"      :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"successNum"]],
                                   @"sendPriceString"   :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"minAmount"]],
                                   @"shippingFeeString" :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"busFee"]],
                                   @"onlineString"      :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"youHuiInfo"]],
                                   @"merchantsId"       :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"id"]],
                                   @"isManJian"         :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"isManJian"]],
                                   @"isNUJianMian"      :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"isNUJianMian"]]
                                   };
        [self.allDataTOArray addObject:dataDict];
//        TakeOutModel *model = [TakeOutModel bodyWithDict:dataDict];
//        [self.allDataTOModelArray addObject:model];
    }
    [self.TakeOutTableView reloadData];
}
//数据请求
- (void)requestTOWithUrl:(NSString *)requestUrl parames:(NSMutableDictionary *)parames Success:(void(^)(id responseObject))success
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSLog(@"requestUrl = %@",requestUrl);
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         success(responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSString *requestUrl2 = [NSString stringWithFormat:@"%@/api/seller/shopCategoryList",POSTREQUESTURL];
         if ([requestUrl isEqualToString:requestUrl2]) {
             self.TakeOutPromptImage.hidden = NO;
         }
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
}

@end
