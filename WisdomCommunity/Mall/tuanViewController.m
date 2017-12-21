//
//  tuanViewController.m
//  WisdomCommunity
//
//  Created by born2try-1 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "tuanViewController.h"
#import "tuanTableViewCell.h"
#import "tuanModel.h"
#import "DetailProductVc.h"
static NSString * ID = @"cellID";

@interface tuanViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong , nonatomic) NSMutableArray * arr;
@property (strong , nonatomic) NSDictionary * dict;
@property (strong , nonatomic) NSString * iid;    //商品id
@property (strong , nonatomic) NSString * iiid;    //商家id
@end

@implementation tuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _table.dataSource = self;
    _table.delegate = self;
    [self.table registerClass:[tuanTableViewCell class] forCellReuseIdentifier:ID];
    // Do any additional setup after loading the view from its nib.
    [self getdata];
}
- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"团购";
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
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/product/grouponList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"%@",responseObject);
       
        _arr = [ responseObject objectForKey:@"list"];
        NSLog(@"arr=%@",_arr);
        NSLog(@"arrcount=%lu",(unsigned long)_arr.count);

        
            [self.table reloadData];
        
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
    return _arr.count;
}

//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *ID = @"CellId";
    tuanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell = [[[UINib nibWithNibName:@"tuanTableViewCell" bundle:nil]instantiateWithOwner:self options:nil]lastObject];
    //如果队列中没有该类型cell，则会返回nil，这个时候就需要自己创建一个cell
    if (cell == nil) {
        
        cell = [[tuanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    _dict = [_arr objectAtIndex:indexPath.row];
    
    NSString * str = _dict[@"surplusNum"];
    NSString * str1 = _dict[@"price"];
    NSLog(@"str=%@,%@",str,str1);
    NSURL *url = [NSURL URLWithString:_dict[@"img"]];
    NSLog(@"%@",url);
    [cell.image sd_setImageWithURL:url];
    cell.name.text = _dict[@"name"];
    cell.cate.text = _dict[@"categoryName"];
    cell.price.text = [NSString stringWithFormat:@"原价：%@",_dict[@"price"]];
    //cell.price.text = _dict[@"price"];
    cell.nowprice.text = [NSString stringWithFormat:@"团购价：%@",_dict[@"discountPrice"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _dict = [_arr objectAtIndex:indexPath.row];
    NSLog(@"dict=%@",_dict);
    _iid = [_dict objectForKey:@"id"];
    NSLog(@"iid=%@",_iid);
    _iiid = [_dict objectForKey:@"shopId"];
    DetailProductVc * good = [[DetailProductVc alloc]init];
    good.shopId = _iiid;
    good.proId = _iid;
    [self.navigationController pushViewController:good animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
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
