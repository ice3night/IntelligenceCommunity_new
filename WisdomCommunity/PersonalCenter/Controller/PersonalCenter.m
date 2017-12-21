//
//  PersonalCenter.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/6.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "PersonalCenter.h"
#import "MessagePlistViewController.h"
#import "ScoreVc.h"
#import "MyHouseVc.h"
#import "ReLogin.h"
#import "SmallShopViewController.h"
#import "CommunityChangeVc.h"
#import "CreatWeishopVc.h"
#import "AccountInforViewController.h"
#import "MyComplaintsViewController.h"
#import "MyRepairViewController.h"
#import "OrderMViewController.h"
#import "MyActivity.h"
#import "PropertyViewController.h"
@interface PersonalCenter ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end

@implementation PersonalCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    // Do any additional setup after loading the view from its nib.
    [self initView];
}
- (void)initView
{
    _bgView.backgroundColor = CQColor(246, 246, 246, 1);
    
    _nickname.text = [CYSmallTools getDataStringKey:ACCOUNT];;
}
//初始化控件
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController.navigationBar setHidden:NO];
    NSDictionary *dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:ACCOUNTDATA]];
    
    NSString *headString;
    NSString *nameString;
    
    if ([[dictT objectForKey:@"success"] integerValue] == 1)
    {
        NSLog(@"第一个成功了%@",@"第一个成功了");
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[dictT objectForKey:@"returnValue"]];
        headString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"imgAddress"]];
        nameString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"nickName"]];
    }
    else
    {
        NSLog(@"第二个成功了%@",@"第二个成功了");
        
        dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:PERSONALDATA]];
        headString = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"imgAddress"]];
        nameString = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"nickName"]];
        NSLog(@"昵称%@",nameString);
        
    }
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:headString] placeholderImage:nil];
    self.nickname.text = [NSString stringWithFormat:@"%@",[nameString isEqualToString:@"<null>"] ? @"" : [ActivityDetailsTools UTFTurnToStr:nameString]];
    
}
-(void)viewWillLayoutSubviews
{
    _iconImage.layer.cornerRadius = _iconImage.bounds.size.height/2;
    _iconImage.layer.masksToBounds = YES;
}
- (IBAction)wuye:(id)sender {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    ProPayCostController *PPController = [[ProPayCostController alloc] init];
    [self.navigationController pushViewController:PPController animated:YES];
}
- (IBAction)GoMyOrder:(id)sender {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    OrderMViewController *OrderController = [[OrderMViewController alloc] init];
    [self.navigationController pushViewController:OrderController animated:YES];
}
- (IBAction)goMyRepair:(id)sender {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    MyRepairViewController *PRController = [[MyRepairViewController alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
- (IBAction)goMyComplaint:(id)sender {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    MyComplaintsViewController *PRController = [[MyComplaintsViewController alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
- (IBAction)goMyNotice:(id)sender {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    MessagePlistViewController *PRController = [[MessagePlistViewController alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
- (IBAction)goMyScore:(id)sender {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    ScoreVc *PRController = [[ScoreVc alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
- (IBAction)goMyActivity:(id)sender {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    MyActivity *PRController = [[MyActivity alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
- (IBAction)sign:(id)sender {
    [MBProgressHUD showLoadToView:self.view];
    
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/doSign",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSString *msg = [JSON objectForKey:@"msg"];
             [MBProgressHUD showSuccess:msg ToView:self.view];
         }else{
             NSString *error = [JSON objectForKey:@"error"];
             [MBProgressHUD showError:error ToView:self.view];
             NSString *type = [JSON objectForKey:@"type"];
             if ([type isEqualToString:@"1"]||[type isEqual:@"2"]) {
                 ReLogin *relogin = [[ReLogin alloc] init];
                 [self.navigationController presentViewController:relogin animated:YES completion:^{
                     
                 }];
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
}
- (IBAction)goMyHouse:(id)sender {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    MyHouseVc *PRController = [[MyHouseVc alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
- (IBAction)changeCom:(id)sender {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    CommunityChangeVc *PRController = [[CommunityChangeVc alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
- (IBAction)createWeiShop:(id)sender {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    CreatWeishopVc *PRController = [[CreatWeishopVc alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
- (IBAction)callWuye:(id)sender {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"05397165568"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}
- (IBAction)myInfo:(id)sender {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    AccountInforViewController *PRController = [[AccountInforViewController alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
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
