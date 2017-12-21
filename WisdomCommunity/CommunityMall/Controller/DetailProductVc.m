//
//  DetailProductVc.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/11.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "DetailProductVc.h"
#import "ShopComment.h"
#import "SubmitMOrderViewController.h"
#import "MerchantsCommentTableViewCell.h"
#import "MJExtension.h"
#import "SubmitMOrderViewController.h"
@interface DetailProductVc ()
{
    DetailProductHeaderFrame *headerFrame;
    ProductDetailHeader *header;
}
@property (weak, nonatomic) IBOutlet UILabel *shopLable;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (nonatomic, copy) NSMutableArray *comments;
@end

@implementation DetailProductVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
//    [self getCommentData];
    [self getDetail];
}
- (IBAction)buyNow:(id)sender {
    [MBProgressHUD showLoadToView:self.view];
    //获取商品数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *string;
        NSString *str = [NSString stringWithFormat:@"{\"productId\":\"%@\",\"productnum\":\"%@\"}",headerFrame.detailProductModel.id,header.amount];
        NSLog(@"str = %@",str);
//    string = str;
//        string = string.length > 0 ? [NSString stringWithFormat:@"%@,%@",string,str] : [NSString stringWithFormat:@"%@",str];
    //URL
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/createOrder",POSTREQUESTURL];
    NSString *busFee = [NSString stringWithFormat:@"%@",headerFrame.detailProductModel.busFee];
    //数据
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
    [parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    parames[@"shopId"]  = [NSString stringWithFormat:@"%@",headerFrame.detailProductModel.shopId];
    parames[@"busFee"]  = [busFee isEqualToString:@"<null>"] ? @"0" : busFee;
    parames[@"details"] = [[@"[" stringByAppendingString:str] stringByAppendingString:@"]"];
    NSLog(@"parames = %@",parames);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏进度条
        [MBProgressHUD hideHUDForView:self.view];
        //
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"生成订单请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
        
                if ([[JSON objectForKey:@"success"] integerValue] == 1)
                {
                    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
                    [self.navigationItem setBackBarButtonItem:backItem];
                    SubmitMOrderViewController *SMOController = [[SubmitMOrderViewController alloc] init];
                    SMOController.OrderDict = [NSDictionary dictionaryWithDictionary:[JSON objectForKey:@"returnValue"]];
                    NSDictionary *dic = [self entityToDictionary:headerFrame.detailProductModel];
                    double price = [headerFrame.detailProductModel.price doubleValue] *[header.amount doubleValue] -[[SMOController.OrderDict objectForKey:@"score2money"] doubleValue];
                    SMOController.MerchantsDict = dic;
                    SMOController.SelectGoodsMoney = [NSString stringWithFormat:@"%.2f",price];
                    [self.navigationController pushViewController:SMOController animated:YES];
                }
                else
                    [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络错误" ToView:self.view];
    }];
//        self.confirmButton.userInteractionEnabled = YES;//允许点击
//        self.shoppingBarView.userInteractionEnabled = YES;
//        //隐藏进度条
//        [MBProgressHUD hideHUDForView:self.view];
//
//        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"生成订单请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
//
//        if ([[JSON objectForKey:@"success"] integerValue] == 1)
//        {
//            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
//            [self.navigationItem setBackBarButtonItem:backItem];
//            SubmitMOrderViewController *SMOController = [[SubmitMOrderViewController alloc] init];
//            SMOController.OrderDict = [NSDictionary dictionaryWithDictionary:[JSON objectForKey:@"returnValue"]];
//            SMOController.MerchantsDict = [NSDictionary dictionaryWithDictionary:self.MerchantsDetailsDict];
//            SMOController.SelectGoodsMoney = [NSString stringWithFormat:@"%@",[SMOController.OrderDict objectForKey:@"nowMoney"]];
//            [self.navigationController pushViewController:SMOController animated:YES];
//        }
//        else
//            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)initView
{
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.shopLable.textColor = CQColor(151, 151, 151, 1);
    self.contactLabel.textColor = CQColor(151, 151, 151, 1);
    self.buyBtn.backgroundColor = CQColor(242, 48, 48, 1);
}
- (void)getCommentData
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"shopId"]     =  _shopId;//
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/product/shopEvaluateList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"%@",responseObject);
        NSNumber *success = [responseObject objectForKey:@"success"];
        if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
            NSDictionary *comlist = [responseObject objectForKey:@"returnValue"];
            _comments = [ShopComment objectArrayWithKeyValuesArray:comlist];
            [self.mTableView reloadData];
        }else{
            [MBProgressHUD showSuccess:@"获取数据失败" ToView:self.view];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络错误" ToView:self.view];
    }];
}
- (IBAction)contac:(id)sender {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"05397165568"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}
- (IBAction)goShop:(id)sender {
    MerchantsPageViewController *MPController = [[MerchantsPageViewController alloc] init];
    MPController.MerchantsId = self.shopId;
    [self.navigationController pushViewController:MPController animated:YES];
}
- (void)getDetail
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"id"]     =  _proId;//
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/product/productDetail",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"%@",responseObject);
        NSNumber *success = [responseObject objectForKey:@"success"];
        if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
            NSDictionary *comlist = [responseObject objectForKey:@"returnValue"];
            _model = [DetailProductModel objectWithKeyValues:comlist];
            headerFrame = [[DetailProductHeaderFrame alloc] init];
            headerFrame.detailProductModel = _model;
            header = [[ProductDetailHeader alloc] init];
            
            header.detailProductHeaderFrame = headerFrame;
            header.delegate = self;
//            header.cout
            header.shopId = [NSString stringWithFormat:@"%@",_model.shopId];
            header.frame = CGRectMake(0, 0, CYScreanW, headerFrame.cellHeight);
            self.mTableView.tableHeaderView = header;
            [self.mTableView reloadData];
        }else{
            [MBProgressHUD showSuccess:@"获取数据失败" ToView:self.view];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络错误" ToView:self.view];
    }];
}
-(void)goMerchant:(NSString *)shopId
{
    MerchantsPageViewController *MPController = [[MerchantsPageViewController alloc] init];
    MPController.MerchantsId = shopId;
    [self.navigationController pushViewController:MPController animated:YES];
}
- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _comments.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"merComCellId";
    MerchantsCommentTableViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (commentCell == nil)
    {
        commentCell = [[MerchantsCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    commentCell.selectionStyle = UITableViewCellSelectionStyleGray;
    commentCell.comment
    = self.comments[indexPath.row];
    return  commentCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CYScreanH * 0.18;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    ComModel *model = _coms[indexPath.row];
    //    [self.delegate getCom:model];
    //    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSDictionary *) entityToDictionary:(id)entity
{
    
    Class clazz = [entity class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        
        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        
        //        const char* attributeName = property_getAttributes(prop);
        //        NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
        //        NSLog(@"%@",[NSString stringWithUTF8String:attributeName]);
        
        id value =  [entity performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
        if(value ==nil)
            [valueArray addObject:[NSNull null]];
        else {
            [valueArray addObject:value];
        }
        //        NSLog(@"%@",value);
    }
    
    free(properties);
    
    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    NSLog(@"%@", returnDic);
    
    return returnDic;
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
