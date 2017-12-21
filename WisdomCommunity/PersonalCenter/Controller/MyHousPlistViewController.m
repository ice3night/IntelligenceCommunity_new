//
//  MyHousPlistViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/17.
//  Copyright © 2016年 bridge. All rights reserved.
//  

#import "MyHousPlistViewController.h"

@interface MyHousPlistViewController ()

@end

@implementation MyHousPlistViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setMyHouseStyle];
    [self initMyHouseController];
    
    
    
}

//设置样式
- (void) setMyHouseStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的房屋";

    
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    [self getHouselist];
}

//初始化控件
- (void) initMyHouseController
{
    //显示
    self.MyHouseTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, (CYScreanH - 64) * 0.8)];
    self.MyHouseTableView.delegate = self;
    self.MyHouseTableView.dataSource = self;
    self.MyHouseTableView.showsVerticalScrollIndicator = NO;
    self.MyHouseTableView.backgroundColor = [UIColor whiteColor];
    self.MyHouseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.MyHouseTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //数据源
    self.MyHouseAllArray = [[NSMutableArray alloc] init];
    
    //提示没有房屋
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.35, CYScreanW, (CYScreanH - 64) * 0.1)];
    label.text = @"当前小区尚未绑定房屋";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Arial" size:25];
    label.textColor = [UIColor grayColor];
    label.hidden = YES;
    [self.view addSubview:label];
    self.promptLabel = label;
    //提交按钮
    UIButton *queryButton = [[UIButton alloc] init];
    [queryButton setTitle:@"+ 添加房屋" forState:UIControlStateNormal];
    [queryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queryButton.layer.cornerRadius = 5;
    queryButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    [queryButton addTarget:self action:@selector(submitMHButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queryButton];
    [queryButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.mas_equalTo(CYScreanW * 0.9);
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.bottom.equalTo(self.view.mas_bottom).offset(-(CYScreanH - 64) * 0.06);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
     }];

}
//提交
- (void) submitMHButton
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    HousingChoiceViewController *MyHousController = [[HousingChoiceViewController alloc] init];
    MyHousController.InputController = @"MyHousPlistViewController";
    [self.navigationController pushViewController:MyHousController animated:YES];
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (CYScreanH - 64) * 0.12;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.MyHouseAllArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellHouseListId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.MyHouseAllArray[indexPath.row]];
    NSString *build = [NSString stringWithFormat:@"%@",[dict objectForKey:@"build"]];
    //字符串转变为数组2
    NSMutableArray * array = [NSMutableArray arrayWithArray:[build componentsSeparatedByString:@"#"]];
    NSLog(@"array = %@,cout = %ld",array,array.count);
//    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@号楼-%@单元-%@号",[dict objectForKey:@"comName"],array[0],array[1],array[2]];
//    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15];
//    cell.imageView.image = [UIImage imageNamed:@"icon_addr_comp"];
    
    
    UIImageView *image = [[UIImageView alloc] init];
    image.image = [UIImage imageNamed:@"icon_addr_comp"];
    [cell.contentView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.03);
        make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.015);
        make.width.mas_equalTo(CYScreanW * 0.045);
        make.height.mas_equalTo((CYScreanH - 64) * 0.03);
    }];
    //内容label
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = [UIFont fontWithName:@"Arial" size:15];
    contentLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"comName"]];
    contentLabel.backgroundColor = [UIColor whiteColor];
    contentLabel.textColor = [UIColor colorWithRed:0.396 green:0.400 blue:0.404 alpha:1.00];
    [cell.contentView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.1);
        make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.01);
        make.right.equalTo(cell.mas_right).offset(0);
        make.height.mas_equalTo((CYScreanH - 64) * 0.04);
    }];
    //审核情况
    UILabel *auditLabel = [[UILabel alloc] init];
    auditLabel.font = [UIFont fontWithName:@"Arial" size:15];
    auditLabel.backgroundColor = [UIColor whiteColor];
    auditLabel.textAlignment = NSTextAlignmentRight;
    auditLabel.textColor = [UIColor colorWithRed:0.396 green:0.400 blue:0.404 alpha:1.00];
    [cell.contentView addSubview:auditLabel];
    [auditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.03);
        make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.01);
        make.width.mas_equalTo(CYScreanW * 0.4);
        make.height.mas_equalTo((CYScreanH - 64) * 0.04);
    }];
    NSString *stateString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
    if ([stateString integerValue] == 1)
    {
        auditLabel.text = @"审核通过";
        auditLabel.textColor = [UIColor greenColor];
    }
    else if ([stateString integerValue] == 2)
    {
        auditLabel.text = @"申请驳回,点击修改";
        auditLabel.textColor = [UIColor redColor];
    }
    else
    {
        auditLabel.text = @"正在审核";
        auditLabel.textColor = [UIColor orangeColor];
    }
    //
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = [UIFont fontWithName:@"Arial" size:15];
    timeLabel.text = [NSString stringWithFormat:@"%@号楼-%@单元-%@号",array[0],array[1],array[2]];
    timeLabel.backgroundColor = [UIColor whiteColor];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.textColor = [UIColor colorWithRed:0.396 green:0.400 blue:0.404 alpha:1.00];
    [cell.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.1);
        make.top.equalTo(contentLabel.mas_bottom).offset((CYScreanH - 64) * 0.02);
        make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.02);
        make.height.mas_equalTo((CYScreanH - 64) * 0.04);
    }];
    
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    segmentationImmage.backgroundColor = [UIColor colorWithRed:0.396 green:0.400 blue:0.404 alpha:1.00];
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
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.MyHouseAllArray[indexPath.row]];
    if ([[dict objectForKey:@"status"] integerValue] == 2)
    {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backItem];
        HousingChoiceViewController *MyHousController = [[HousingChoiceViewController alloc] init];
        MyHousController.HouseDict = [NSDictionary dictionaryWithDictionary:dict];
        MyHousController.InputController = @"MyHousPlistViewController";
        [self.navigationController pushViewController:MyHousController animated:YES];
    }
}
//获取房屋列表
- (void) getHouselist
{
    [MBProgressHUD showLoadToView:self.view];
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/myBuilds",POSTREQUESTURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"comNo"]       =  [NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]];
    dict[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    dict[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    NSLog(@"dict = %@",dict);
    [manager POST:requestUrl parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             self.MyHouseAllArray = [NSMutableArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
             if (self.MyHouseAllArray.count)
             {
                 self.promptLabel.hidden = YES;
                 self.MyHouseTableView.hidden = NO;
                 [self.MyHouseTableView reloadData];
             }
             else
             {
                 self.promptLabel.hidden = NO;
                 self.MyHouseTableView.hidden = YES;
             }
         }
         else
         {
             self.MyHouseTableView.hidden = YES;
             self.promptLabel.hidden = NO;
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"获取房屋列表失败:%@", error.description);
     }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
