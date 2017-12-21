//
//  ProPayResultViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/10.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ProPayResultViewController.h"

@interface ProPayResultViewController ()

@end

@implementation ProPayResultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void) viewWillAppear:(BOOL)animated
{
    self.promptArray = @[@"订单号",@"缴费账户",@"当前状态",@"支付方式"];
    [self setPPResultStyle];
    [self ProPayConControllers];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [self.ProPayResultTableView removeFromSuperview];
}
- (void) setPPResultStyle
{
    
    [self.navigationItem setHidesBackButton:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"缴费结果";
    [self.tabBarController.tabBar setHidden:YES];

    
    //左
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 40)];
    btn1.backgroundColor = [UIColor clearColor];
    [btn1 setImage:[UIImage imageNamed:@"icon_arrow_left_red"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonLeft = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    self.navigationItem.leftBarButtonItem = buttonLeft;
}
- (void) ProPayConControllers
{
    //缴费详情
    self.ProPayResultTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH - 64)];
    self.ProPayResultTableView.delegate = self;
    self.ProPayResultTableView.dataSource = self;
    self.ProPayResultTableView.scrollEnabled = NO;
    self.ProPayResultTableView.showsVerticalScrollIndicator = NO;
    self.ProPayResultTableView.backgroundColor = [UIColor whiteColor];
    self.ProPayResultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.ProPayResultTableView];
}
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return (CYScreanH - 64) * 0.08;
    }
    else if (indexPath.row == 1)
    {
        return (CYScreanH - 64) * 0.08;
    }
    else if (indexPath.row == 6)
    {
        return (CYScreanH - 64) * 0.1;
    }
    else
        return (CYScreanH - 64) * 0.06;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellPPCId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
    
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:12];
    
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 4 && [self.dataArray[4] isEqual:@"缴费失败"])
    {
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.957 green:0.561 blue:0.271 alpha:1.00];
    }
    if (indexPath.row == 0)
    {
        if (self.showImage == nil)
        {
            //图标
            self.showImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.4, (CYScreanH - 64) * 0.025, CYScreanW * 0.045, (CYScreanH - 64) * 0.03)];
            
            [cell.contentView addSubview:self.showImage];
        }
        if (self.resultLabel == nil)
        {
            //方式
            self.resultLabel = [[UILabel alloc] init];
            self.resultLabel.textColor = [UIColor  colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
            
            self.resultLabel.font = [UIFont fontWithName:@"Arial" size:15];
            self.resultLabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:self.resultLabel];
            [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(self.showImage.mas_right).offset(CYScreanW * 0.03);
                 make.top.equalTo(cell.mas_top).offset(0);
                 make.width.mas_equalTo (CYScreanW * 0.5);
                 make.bottom.equalTo(cell.mas_bottom).offset(0);
             }];
        }
        
        
        if ([self.dataArray[0] integerValue] == 0)
        {
            self.showImage.image = [UIImage imageNamed:@"icon_failed_withbg"];
            self.resultLabel.text = @"缴费失败";
        }
        else
        {
            self.showImage.image = [UIImage imageNamed:@"icon_selected_withbg"];
            self.resultLabel.text = @"缴费成功";
        }
        
    }
    else if (indexPath.row == 1)
    {
        //描述
        UILabel *promptLabel = [[UILabel alloc] init];
        promptLabel.text = [NSString stringWithFormat:@"￥%@",self.dataArray[indexPath.row]];;
        promptLabel.textAlignment = NSTextAlignmentCenter;
        promptLabel.textColor = [UIColor  colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
        promptLabel.font = [UIFont fontWithName:@"Arial" size:26];
        [cell.contentView addSubview:promptLabel];
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(cell.mas_left).offset(0);
             make.width.mas_equalTo (CYScreanW);
             make.top.equalTo(cell.mas_top).offset(0);
             make.bottom.equalTo(cell.mas_bottom).offset(0);
         }];
    }
    else if (indexPath.row == 6)
    {
        UIButton *backButton = [[UIButton alloc] init];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        backButton.layer.cornerRadius = 5;
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        backButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
        [backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:backButton];
        [backButton mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.02);
             make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.02);
             make.bottom.equalTo(cell.mas_bottom).offset(0);
             make.height.mas_equalTo((CYScreanH - 64) * 0.06);
         }];
    }
    else
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.promptArray[indexPath.row - 2]];
    }
    
    
    
    
    

    
    //分割线
    if (indexPath.row != 0 && indexPath.row != 5 && indexPath.row != 6)
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
             make.height.mas_equalTo(1);
         }];
    }
    
    
    return cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//再来一单，进入商城首页
- (void) backButton:(UIButton *)sender
{
    UIViewController *viewCtl = self.navigationController.viewControllers[0];
    [self.navigationController popToViewController:viewCtl animated:YES];
}


@end
