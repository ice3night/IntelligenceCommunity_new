//
//  PersonalCenterViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "PersonalCenterViewController.h"

@interface PersonalCenterViewController ()

@end

@implementation PersonalCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setPersonalUI];
    [self initPersonalController];
    

}
#pragma mark - 设置主controller的UI
- (void) setPersonalUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    //背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, 64 + (CYScreanH - 113) * 0.15)];
    imageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:imageView];
}
- (void) viewWillAppear:(BOOL)animated
{
    //隐藏导航栏
    [self.navigationController.navigationBar setHidden:YES];
    //显示
    [self.tabBarController.tabBar setHidden:NO];
    
    [self SetHeadAndName];
}
- (void) viewWillDisappear:(BOOL)animated
{
    //显示导航栏
    [self.navigationController.navigationBar setHidden:YES];
}
//刷新设置积分等
- (void) SetHeadAndName
{
    NSLog(@"来了");
    //目的：实时更新积分
    [self signIn:@"checkTodaySign"];
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
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:headString] placeholderImage:nil];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",[nameString isEqualToString:@"<null>"] ? @"" : [ActivityDetailsTools UTFTurnToStr:nameString]];
    //赋值
    self.integralLabel.text = [NSString stringWithFormat:@"%@ 积分",[CYSmallTools getDataStringKey:CURRENTINTEGRAL]];
    if ([[CYSmallTools getDataStringKey:WHETHERSIGNIN] integerValue] == 1)//未签到
    {
        self.signInImage.image = [UIImage imageNamed:@"sign"];
        self.signInImage.userInteractionEnabled = YES;
    }
    else
    {
        [self.signInImage setImage:[UIImage imageNamed:@"sign_done"]];
        self.signInImage.userInteractionEnabled = NO;
    }
}
//初始化控件
- (void) initPersonalController
{
    //显示
    self.personalTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 64, CYScreanW, CYScreanH - 113)];
    self.personalTableView.delegate = self;
    self.personalTableView.dataSource = self;
    self.personalTableView.showsVerticalScrollIndicator = NO;
    self.personalTableView.scrollEnabled = NO;
    self.personalTableView.backgroundColor = [UIColor clearColor];
    self.personalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉cell白线
    [self.view addSubview:self.personalTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return (CYScreanH - 113) * 0.15;
    }
//    else if (indexPath.row == 1 || indexPath.row == 2)
//    {
//        return (CYScreanH - 113) * 0.2;
//    }
    else
        return (CYScreanH - 113) * 0.09;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    static NSString *ID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //箭头
    if (indexPath.row > 2)
    {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//右侧箭头
    }
    if (indexPath.row == 0)
    {
        cell.backgroundColor = [UIColor clearColor];
        
        if (self.signInImage == nil)
        {
            //头像
            UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.05, 10, (CYScreanH - 64) * 0.08, (CYScreanH - 64) * 0.08)];
            
            [cell.contentView addSubview:headImage];
            [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(cell.contentView);
                make.top.equalTo(cell.contentView).offset(10);
                make.width.equalTo(@((CYScreanH - 64) * 0.08));
                make.height.equalTo(@((CYScreanH - 64) * 0.08));
            }];
            //圆角
            headImage.layer.cornerRadius = headImage.frame.size.width / 2;
            headImage.clipsToBounds = YES;
            self.headImage = headImage;
            //用户名
            UILabel *nameLabel = [[UILabel alloc] init];
            nameLabel.textColor = ShallowBrownColoe;
            nameLabel.font = font;
            nameLabel.textAlignment = 1;
            [cell.contentView addSubview:nameLabel];
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.centerX.equalTo(headImage);
                 make.top.equalTo(headImage.mas_bottom).offset(10);
                 make.width.mas_equalTo (CYScreanW * 0.3);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.03);
             }];
            self.nameLabel = nameLabel;
            //赋值
            [self SetHeadAndName];
        }
    }
    if (indexPath.row == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"icon_my_order_p"];
        cell.textLabel.text = @"商城订单";
    }
    if (indexPath.row == 2)
    {
        cell.imageView.image = [UIImage imageNamed:@"icon_my_order_p"];
        cell.textLabel.text = @"物业缴费";
    }
    if (indexPath.row == 3)
    {
        cell.imageView.image = [UIImage imageNamed:@"icon_my_order_p"];
        cell.textLabel.text = @"我的保修";
    } 
    else if (indexPath.row == 4)
    {
        cell.imageView.image = [UIImage imageNamed:@"icon_mini_shop"];
        cell.textLabel.text = @"我要投诉";
    }
    else if (indexPath.row == 5)
    {
        cell.imageView.image = [UIImage imageNamed:@"nowicon_integration"];
        cell.textLabel.text = @"我的房产";
        
    }
    else if (indexPath.row == 6)
    {
        cell.imageView.image = [UIImage imageNamed:@"icon_myadvise"];
        cell.textLabel.text = @"切换社区";
    }
    else if (indexPath.row == 7)
    {
        cell.imageView.image = [UIImage imageNamed:@"icon_about_us"];
        cell.textLabel.text = @"积分商城";
    }
    else if (indexPath.row == 8)
    {
        cell.imageView.image = [UIImage imageNamed:@"icon_myadvise"];
        cell.textLabel.text = @"我要开店";
    }
    else if (indexPath.row == 9)
    {
        cell.imageView.image = [UIImage imageNamed:@"icon_about_us"];
        cell.textLabel.text = @"呼叫物业";
    }
    else if (indexPath.row == 10)
    {
        cell.imageView.image = [UIImage imageNamed:@"icon_myadvise"];
        cell.textLabel.text = @"我的信息";
    }
    
    //字体颜色
    cell.textLabel.font = font;
    cell.textLabel.textColor = ShallowGrayColor;
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    segmentationImmage.backgroundColor = ShallowGrayColor;
    [cell.contentView addSubview:segmentationImmage];
    [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(cell.mas_left).offset(0);
         make.right.equalTo(cell.mas_right).offset(0);
         make.bottom.equalTo(cell.mas_bottom).offset(0);
         make.height.mas_equalTo(1);
     }];
    return cell;
    
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    if (indexPath.row == 0)
    {
        AccountInforViewController *accountController = [[AccountInforViewController alloc] init];
        [self.navigationController pushViewController:accountController animated:YES];
    }
    else if (indexPath.row == 3)
    {
        OrderMViewController *OrderController = [[OrderMViewController alloc] init];
        [self.navigationController pushViewController:OrderController animated:YES];
    }
    else if (indexPath.row == 4)
    {
        SmallShopViewController *smallController = [[SmallShopViewController alloc] init];
        [self.navigationController pushViewController:smallController animated:YES];
    }
    else if (indexPath.row == 5)
    {
        IntegralCommunityViewController *IntegralController = [[IntegralCommunityViewController alloc] init];
        [self.navigationController pushViewController:IntegralController animated:YES];
    }
    else if (indexPath.row == 6)
    {
        OpinionsSuggestionsViewController *OSController = [[OpinionsSuggestionsViewController alloc] init];
        [self.navigationController pushViewController:OSController animated:YES];
    }
    else if (indexPath.row == 7)
    {
        AboutUsViewController *AUController = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:AUController animated:YES];
    }
}
//我的社区
- (void) myCommuntyButton:(UIButton *)sender
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    if (sender.tag == 110)
    {
        NeighborhoodActivitiesViewController *NAController = [[NeighborhoodActivitiesViewController alloc] init];
        [self.navigationController pushViewController:NAController animated:YES];
    }
    else if (sender.tag == 111)
    {
        MyBBSViewController *MBBSController = [[MyBBSViewController alloc] init];
        [self.navigationController pushViewController:MBBSController animated:YES];
    }
    else if (sender.tag == 112)
    {
        MyCommentViewController *MComController = [[MyCommentViewController alloc] init];
        [self.navigationController pushViewController:MComController animated:YES];
    }
//    else
//    {
//        MyThumbUpViewController *MTUController = [[MyThumbUpViewController alloc] init];
//        [self.navigationController pushViewController:MTUController animated:YES];
//    }
}
//我的物业
- (void) MyPrepertyButton:(UIButton *)sender
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    if (sender.tag == 120)
    {
        MyHousPlistViewController *MHController = [[MyHousPlistViewController alloc] init];
        [self.navigationController pushViewController:MHController animated:YES];
    }
    else if (sender.tag == 121)
    {
        MyRepairViewController *MRController = [[MyRepairViewController alloc] init];
        [self.navigationController pushViewController:MRController animated:YES];
    }
    else if (sender.tag == 122)
    {
        MyComplaintsViewController *MCController = [[MyComplaintsViewController alloc] init];
        [self.navigationController pushViewController:MCController animated:YES];
    }
}
//签到按钮
-(void)handleSignInTap:(UITapGestureRecognizer *)sender
{
    self.signInImage.userInteractionEnabled = NO;//先设置为不可再次点击
    [self signIn:@"doSign"];
}
//签到
- (void) signIn:(NSString *)type
{
    if ([type isEqualToString:@"doSign"])//只有签到才会有进度条
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
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/%@",POSTREQUESTURL,type];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             if ([type isEqualToString:@"doSign"])
             {
                 [self.signInImage setImage:[UIImage imageNamed:@"sign_done"]];
                 [self signIn:@"checkTodaySign"];
             }
             else
             {
                 NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[JSON objectForKey:@"param"]];
                 [CYSmallTools saveDataString:[dict objectForKey:@"canSign"] withKey:WHETHERSIGNIN];
                 [CYSmallTools saveDataString:[dict objectForKey:@"score"] withKey:CURRENTINTEGRAL];
                 self.integralLabel.text = [NSString stringWithFormat:@"%@ 积分",[dict objectForKey:@"score"]];
             }
         }
         else
         {
             //如果是签到失败，还可以继续签到
             if ([type isEqualToString:@"doSign"])
             {
                 self.signInImage.userInteractionEnabled = YES;
             }
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
         if ([type isEqualToString:@"doSign"])
         {
             self.signInImage.userInteractionEnabled = YES;
         }
     }];
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
