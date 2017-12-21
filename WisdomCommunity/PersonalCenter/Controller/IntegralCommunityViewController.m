//
//  IntegralCommunityViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/17.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "IntegralCommunityViewController.h"
#import "ReLogin.h"
@interface IntegralCommunityViewController ()

@end

@implementation IntegralCommunityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setIntegrealStyle];
    [self initIntegrealController];
    
}
- (void) initIntegrealData:(NSArray *)array
{
    for (NSInteger i = array.count - 1; i >= 0; i --)
    {
        NSDictionary *dictDetails = array[i];
        NSString *time = [NSString stringWithFormat:@"%@",[dictDetails objectForKey:@"gmtCreate"]];
        NSString *type = [NSString stringWithFormat:@"%@",[dictDetails objectForKey:@"type"]];
        NSDictionary *dict;
        NSString *intro = [NSString stringWithFormat:@"%@",[dictDetails objectForKey:@"intro"]];
        NSString *integral = [NSString stringWithFormat:@"%@",[dictDetails objectForKey:@"money"]];
        if ([type integerValue] == 1)
        {
            dict = @{@"user":[NSString stringWithFormat:@"%@,获取%@积分",intro,[integral isEqualToString:@"<null>"] ? @"0" : integral],@"time":[NSString stringWithFormat:@"日期 %@",time.length> 10 ? [time substringToIndex:10] : time]};
        }
        else
        {
            dict = @{@"user":[NSString stringWithFormat:@"%@,消耗%@积分",intro,[integral isEqualToString:@"<null>"] ? @"0" : integral],@"time":[NSString stringWithFormat:@"日期 %@",time.length> 10 ? [time substringToIndex:10] : time]};
        }
        [self.integralArray addObject:dict];
    }
    [self.IntegralTableView reloadData];
}
//设置样式
- (void) setIntegrealStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"社区积分";

    //数据源
    self.integralArray = [[NSMutableArray alloc] init];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    [self getIntegralRequest];
}

//初始化控件
- (void) initIntegrealController
{
    //显示
    self.IntegralTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH - 64)];
    self.IntegralTableView.delegate = self;
    self.IntegralTableView.dataSource = self;
    self.IntegralTableView.showsVerticalScrollIndicator = NO;
    self.IntegralTableView.backgroundColor = [UIColor whiteColor];
    self.IntegralTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.IntegralTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.text = @"没有积分数据";
    promptLabel.textColor = [UIColor grayColor];
    promptLabel.font = [UIFont fontWithName:@"Arial" size:20];
    promptLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:promptLabel];
    promptLabel.hidden = YES;
    self.promptLabel = promptLabel;
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
    return self.integralArray.count + 1;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        static NSString *ID = @"cellIId2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        if (self.btnLeft == nil)
        {
            self.btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW * 0.04, (CYScreanH - 64) * 0.02, CYScreanW * 0.5, (CYScreanH - 64) * 0.06)];
            self.btnLeft.backgroundColor = [UIColor clearColor];
            [self.btnLeft setTitle:@"服务内容" forState:UIControlStateNormal];
            [self.btnLeft setTitleColor:[UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00] forState:UIControlStateNormal];
            [self.btnLeft setImage:[UIImage imageNamed:@"icon_title_service"] forState:UIControlStateNormal];
            self.btnLeft.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
            self.btnLeft.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            self.btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [cell.contentView addSubview:self.btnLeft];
        }
        return cell;
    }
    else
    {
        UIFont *font = [UIFont fontWithName:@"Arial" size:13];
        static NSString *ID = @"cellIId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.integralArray[indexPath.row - 1]];
        
        
        UIImageView *image = [[UIImageView alloc] init];
        image.image = [UIImage imageNamed:@"icon_jifen"];
        [cell.contentView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.03);
            make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.015);
            make.width.mas_equalTo(CYScreanW * 0.045);
            make.height.mas_equalTo((CYScreanH - 64) * 0.03);
        }];
        //内容label
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = font;
        contentLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"user"]];
        contentLabel.backgroundColor = [UIColor whiteColor];
        contentLabel.textColor = [UIColor colorWithRed:0.396 green:0.400 blue:0.404 alpha:1.00];
        [cell.contentView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.1);
            make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.01);
            make.right.equalTo(cell.mas_right).offset(0);
            make.height.mas_equalTo((CYScreanH - 64) * 0.04);
        }];
        
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = font;
        timeLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"time"]];
        timeLabel.backgroundColor = [UIColor whiteColor];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.textColor = [UIColor colorWithRed:0.396 green:0.400 blue:0.404 alpha:1.00];
        [cell.contentView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CYScreanW * 0.7);
            make.top.equalTo(contentLabel.mas_bottom).offset((CYScreanH - 64) * 0.02);
            make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.02);
            make.height.mas_equalTo((CYScreanH - 64) * 0.04);
        }];
        return cell;
    }
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//获取积分记录
- (void) getIntegralRequest
{
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
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/myScoreLog",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
             if (array.count)
             {
                 self.IntegralTableView.hidden = NO;
                 self.promptLabel.hidden = YES;
                 [self initIntegrealData:array];
             }
             else
             {
                 self.promptLabel.hidden = NO;
                 self.IntegralTableView.hidden = YES;
             }
         }
         else{
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
