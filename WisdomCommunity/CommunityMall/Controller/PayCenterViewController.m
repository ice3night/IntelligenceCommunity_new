//
//  PayCenterViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "PayCenterViewController.h"

@interface PayCenterViewController ()

@end

@implementation PayCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setPCStyle];
    [self initPCController];
    
}
- (void) viewWillAppear:(BOOL)animated
{
    NSArray *viewControllers = self.navigationController.viewControllers;//获取当前的视图控制其
    NSLog(@"viewControllers = %@",viewControllers);
    
    
    if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count - 2] == self) {
        NSLog(@"push");
    } else if ([viewControllers indexOfObject:self] == NSNotFound) {
        //当前视图控制器不在栈中，故为pop操作
        NSLog(@"pop");
    }
    
}
//设置样式
- (void) setPCStyle
{
    self.view.backgroundColor = CQColor(246,243,254, 1);
    self.navigationItem.title = @"支付中心";
    self.TOController = [[MallPayReViewController alloc] init];
}
//返回
- (void) backButtoPay
{
    NSArray* array =self.navigationController.viewControllers;
    NSLog(@"array = %@",array);
    NSLog(@"array[0] = %@",array);
    //判断是不是从个人中心页进入的
    if ([array[array.count - 2] isKindOfClass:[SubmitMOrderViewController class]])
    {
        //回到外卖首页
        UIViewController *viewCtl = self.navigationController.viewControllers[array.count - 3];
        [self.navigationController popToViewController:viewCtl animated:YES];
    }
    else
        [self.navigationController popViewControllerAnimated:YES];
}
- (void) initPCController
{
    //支付方式列表
    self.PayCenterTypeTableView = [[UITableView alloc] init];
    self.PayCenterTypeTableView.delegate = self;
    self.PayCenterTypeTableView.dataSource = self;
    self.PayCenterTypeTableView.scrollEnabled = NO;
    self.PayCenterTypeTableView.showsVerticalScrollIndicator = NO;
    self.PayCenterTypeTableView.backgroundColor = [UIColor whiteColor];
    self.PayCenterTypeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.PayCenterTypeTableView];
    [self.PayCenterTypeTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.top.equalTo(self.view.mas_top).offset(0);
         make.height.mas_equalTo((CYScreanH - 64) * 0.4+5);
     }];
    
    //确认支付
    UIButton *complaintsButton = [[UIButton alloc] init];
    [complaintsButton setTitle:@"确认支付" forState:UIControlStateNormal];
    [complaintsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    complaintsButton.layer.cornerRadius = (CYScreanH - 64) * 0.03;
    complaintsButton.layer.masksToBounds = YES;
    complaintsButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    complaintsButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [complaintsButton addTarget:self action:@selector(payCenterButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:complaintsButton];
    [complaintsButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
    make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
        make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.05);
        make.top.equalTo(self.PayCenterTypeTableView.mas_bottom).offset(CYScreanW * 0.05);
        make.height.mas_equalTo((CYScreanH - 64) * 0.06);
             }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return (CYScreanH - 64) * 0.1;
    }
    else if (indexPath.row == 1)
    {
        return (CYScreanH - 64) * 0.1;
    }
    else if (indexPath.row == 4)
    {
        return (CYScreanH - 64) * 0.1;
    }
    else
        return (CYScreanH - 64) * 0.1;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else{
        UIView *header = [[UIView alloc] init];
        header.backgroundColor = CQColor(246,243,254, 1);
        return header;
    }
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellPayPCId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0&&indexPath.row == 0)
    {
        cell.textLabel.textColor = CQColor(51,51,51, 1);
        cell.detailTextLabel.textColor = CQColor(245,64,72, 1);
        cell.textLabel.text = @"订单金额";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.payMoney];
    }
    else if (indexPath.section == 1&&indexPath.row == 0)
    {
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = CQColor(102,102,102, 1);
        cell.textLabel.text = @"请选择支付方式";
    }
    else if (indexPath.section == 1&&indexPath.row == 1)
    {
        self.orderMallType = @"alipay";
        //图标
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.04, (CYScreanH - 64) * 0.02, (CYScreanH - 64) * 0.06, (CYScreanH - 64) * 0.06)];
        headImage.image = [UIImage imageNamed:@"icon_alipay"];
        [cell.contentView addSubview:headImage];
        //方式
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.text = @"支付宝支付";
        nameLabel.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.03);
             make.top.equalTo(headImage.mas_top).offset((CYScreanH - 64) * 0.01/2);
             make.width.mas_equalTo (CYScreanW * 0.5);
             make.height.mas_equalTo((CYScreanH - 64) * 0.05);
         }];
        
        //选择显示图标
        self.PayTreasureButton = [[UIButton alloc] init];
        [self.PayTreasureButton setBackgroundImage:[UIImage imageNamed:@"icon_payway_selected"] forState:UIControlStateNormal];
        self.PayTreasureButton.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:self.PayTreasureButton];
        [self.PayTreasureButton mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.02);
             make.width.mas_equalTo((CYScreanH - 64) * 0.04);
             make.top.equalTo(headImage.mas_top).offset((CYScreanH - 64) * 0.01);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
    }
    else if (indexPath.section == 1&&indexPath.row == 2)
    {
        //图标
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.04, (CYScreanH - 64) * 0.02, (CYScreanH - 64) * 0.06, (CYScreanH - 64) * 0.06)];
        headImage.image = [UIImage imageNamed:@"icon_weixin"];
        [cell.contentView addSubview:headImage];
        //方式
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.text = @"微信支付";
        nameLabel.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
        make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.03);
             make.top.equalTo(headImage.mas_top).offset((CYScreanH - 64) * 0.01/2);
             make.width.mas_equalTo (CYScreanW * 0.5);
             make.height.mas_equalTo((CYScreanH - 64) * 0.05);
         }];
        
        //选择显示图标
        self.WeChatButton = [[UIButton alloc] init];
        [self.WeChatButton setBackgroundImage:[UIImage imageNamed:@"icon_payway_selected"] forState:UIControlStateNormal];
        self.WeChatButton.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:self.WeChatButton];
        [self.WeChatButton mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.02);
             make.width.mas_equalTo((CYScreanH - 64) * 0.04);
             make.top.equalTo(headImage.mas_top).offset((CYScreanH - 64) * 0.01);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        self.WeChatButton.hidden = YES;
    }
   
    if (indexPath.section == 1&&(indexPath.row == 1||indexPath.row == 0))
    {
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
        [cell.contentView addSubview:segmentationImmage];
        [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(cell.mas_left).offset(0);
             make.right.equalTo(cell.mas_right).offset(0);
             make.bottom.equalTo(cell.mas_bottom).offset(0);
             make.height.mas_equalTo(0.5);
         }];
    }
    
    
    
    
    return cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1&&indexPath.section == 1)
    {
        self.PayTreasureButton.hidden = NO;
        self.WeChatButton.hidden = YES;
        self.orderMallType = @"alipay";
    }
    else if (indexPath.row == 2&&indexPath.section == 1)
    {
        self.PayTreasureButton.hidden = YES;
        self.WeChatButton.hidden = NO;
        self.orderMallType = @"wx";
    }
}
//支付
- (void) payCenterButton
{
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
//    [self.navigationItem setBackBarButtonItem:backItem];
//    MallPayReViewController *TOController = [[MallPayReViewController alloc] init];
//    TOController.dataMallArray = @[@"1",@"180.00",@"11231231321",@"2017.01.06",@"支付成功",@"支付宝"];
//    [self.navigationController pushViewController:TOController animated:YES];
    
    [self MallProPayRequest];
}
//发起支付
- (void) MallProPayRequest
{
    [MBProgressHUD showLoadToView:self.view];
    
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"type"]        =  [NSString stringWithFormat:@"%@",self.orderMallType];//
    parames[@"id"]          =  [NSString stringWithFormat:@"%@",self.orderMallId];
    parames[@"useScore"]    =  [NSString stringWithFormat:@"%@",self.whetherUseScore];//是否使用积分
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/pay",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [self requestPCSubWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"发起支付请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
        
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            self.chargeMallDict = [NSDictionary dictionaryWithDictionary:[[JSON objectForKey:@"param"] objectForKey:@"charge"]];
            [self wakeUpPingWithCharge:[[JSON objectForKey:@"param"] objectForKey:@"charge"]];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    }];
}

- (void)wakeUpPingWithCharge:(NSDictionary *)charge
{
    NSString *kURLScheme = @"BridgeworldWisdomCommunity";
    [Pingpp createPayment:charge
           viewController:self.TOController
             appURLScheme:kURLScheme
           withCompletion:^(NSString *result, PingppError *error) {
               if ([result isEqualToString:@"success"]){
                   // 支付成功
                   NSLog(@"支付成功");
                   [self paySayResult];
               }else{
                   // 支付失败或取消
                   NSLog(@"支付失败");
                   [self paySayResult];
               }
               
           }];
}

//注册成为监听者
- (instancetype) init
{
    self = [super init];
    if (self)
    {
        //注册成为监听者
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySayResult:) name:@"payResult" object:nil];
    }
    return self;
}
//声明通知
- (void)paySayResult//:(NSNotification *)payNotificat
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"charge_id"]   =  [NSString stringWithFormat:@"%@",[self.chargeMallDict objectForKey:@"id"]];;//
    parames[@"id"]          =  [NSString stringWithFormat:@"%@",self.orderMallId];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/paySelect",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [self requestPCSubWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
        NSString *type = [[NSString alloc] init];
        if ([self.orderMallType isEqual:@"alipay"])
        {
            type = @"支付宝";
        }
        else
        {
            type = @"微信";
        }
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            NSLog(@"后台支付成功");
            self.TOController.dataMallArray = @[@"1",self.payMoney,[NSString stringWithFormat:@"%@",self.orderMallId],[CYSmallTools getTimeStamp],@"支付成功",type];
        }
        else
        {
            [self CannelCenterOrderRequest];
            self.TOController.dataMallArray = @[@"0",self.payMoney,[NSString stringWithFormat:@"%@",self.orderMallId],[CYSmallTools getTimeStamp],@"支付失败",type];
            NSLog(@"后台支付失败");
        }
        //跳转
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backItem];
        self.TOController.orderId = self.orderMallId;
        [self.navigationController pushViewController:self.TOController animated:YES];
    }];
}
//取消订单
- (void) CannelCenterOrderRequest
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/cancelOrder",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"id"]        =  [NSString stringWithFormat:@"%@",self.orderMallId];
    NSLog(@"parames = %@",parames);
    [self requestPCSubWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"取消订单请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
    }];
}
//数据请求
- (void)requestPCSubWithUrl:(NSString *)requestUrl parames:(NSMutableDictionary *)parames Success:(void(^)(id responseObject))success
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
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
}
- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"payResult" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
