//
//  weishopViewController.m
//  WisdomCommunity
//
//  Created by born2try-1 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "weishopViewController.h"
#import "weishopTableViewCell.h"
#import "MerchantsPageViewController.h"

static NSString * ID = @"cellID";


@interface weishopViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong , nonatomic) NSMutableArray * ARR;
@property (strong , nonatomic) NSDictionary * dict;
@property (strong , nonatomic) NSString * shopid;

@end

@implementation weishopViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _table.delegate = self;
    _table.dataSource = self;
    [self.table registerClass:[weishopTableViewCell class] forCellReuseIdentifier:ID];
    [self getdata];
}
- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"微店";
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
    
}
-(void)getdata{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    NSString * name = [userdefaults objectForKey:@"username" ];
    NSString * token = [userdefaults objectForKey:@"token"];
    NSString * comno = @"1";
    [parames setObject:name forKey:@"account"];
    [parames setObject:token forKey:@"token"];
    [parames setObject:comno forKey:@"comNo"];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/vdianList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"%@",responseObject);
        _ARR = [ responseObject objectForKey:@"list"];
        NSLog(@"arrcount=%lu",(unsigned long)_ARR.count);
        [self.table reloadData];
//        _arr = [ responseObject objectForKey:@"list"];
//        NSLog(@"arr=%@",_arr);
//        NSLog(@"arrcount=%lu",(unsigned long)_arr.count);
        
        
//        [self.table reloadData];
//        
        //     else{
        //            [MBProgressHUD showSuccess:@"获取数据失败" ToView:self.view];
        //        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络错误" ToView:self.view];
    }];
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ARR.count;
}

//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *ID = @"CellId";
    weishopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell = [[[UINib nibWithNibName:@"weishopTableViewCell" bundle:nil]instantiateWithOwner:self options:nil]lastObject];
    //如果队列中没有该类型cell，则会返回nil，这个时候就需要自己创建一个cell
    if (cell == nil) {
        
        cell = [[weishopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    _dict = [_ARR objectAtIndex:indexPath.row];
    cell.shopname.text = _dict[@"shopName"];
    cell.sendmoney.text = [NSString stringWithFormat:@"配送费：%@",_dict[@"busFee"]];
    cell.firstpay.text = [NSString stringWithFormat:@"%@起送",_dict[@"minAmount"]];
    cell.number.text =[NSString stringWithFormat:@"月售%@单",_dict[@"successNum"]];
    NSURL *url = [NSURL URLWithString:_dict[@"imgBiao"]];
    NSLog(@"%@",url);
    [cell.shopimage sd_setImageWithURL:url];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _dict = [_ARR objectAtIndex:indexPath.row];
    _shopid = [NSString stringWithFormat:@"%@",_dict[@"id"]];
    MerchantsPageViewController * vc = [[MerchantsPageViewController alloc]init];
    vc.MerchantsId = _shopid;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
