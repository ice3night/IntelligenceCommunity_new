//
//  ProPayCConfirmViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/10.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ProPayCConfirmViewController.h"

@interface ProPayCConfirmViewController ()

@end
@implementation ProPayCConfirmViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setPPCCStyle];
    // Do any additional setup after loading the view.
}
- (void) viewWillAppear:(BOOL)animated
{
    [self ProPayConControllers];
}
- (void) viewWillDisappear:(BOOL)animated
{
    NSArray *viewControllers = self.navigationController.viewControllers;//获取当前的视图控制器
    if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count - 2] == self) {
        //当前视图控制器在栈中，故为push操作
        NSLog(@"push");
    } else if ([viewControllers indexOfObject:self] == NSNotFound) {
        //当前视图控制器不在栈中，故为pop操作
        [self cannelOrderRequest:@"back"];
        NSLog(@"pop");
    }
}
- (void) setPPCCStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"物业缴费";
    [self.tabBarController.tabBar setHidden:YES];
}
- (void) ProPayConControllers
{
    //支付结果
    self.ProPayController = [[ProPayResultViewController alloc] init];
    //支付结果
    ProPayResultViewController *PPRController = [[ProPayResultViewController alloc] init];
    //缴费详情
    self.ProPayConfirmTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.05, CYScreanW, (CYScreanH - 64) * 0.42)];
    self.ProPayConfirmTableView.delegate = self;
    self.ProPayConfirmTableView.dataSource = self;
    self.ProPayConfirmTableView.scrollEnabled = NO;
    self.ProPayConfirmTableView.showsVerticalScrollIndicator = NO;
    self.ProPayConfirmTableView.backgroundColor = [UIColor whiteColor];
    self.ProPayConfirmTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.ProPayConfirmTableView];
    
    //立即缴费
    self.ImmediatePaymentButton = [[UIButton alloc] init];
    [self.ImmediatePaymentButton setTitle:@"立即缴费" forState:UIControlStateNormal];
    [self.ImmediatePaymentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.ImmediatePaymentButton.layer.cornerRadius = 5;
    self.ImmediatePaymentButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    [self.ImmediatePaymentButton addTarget:self action:@selector(showPayTypeButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ImmediatePaymentButton];
    [self.ImmediatePaymentButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.02);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
         make.bottom.equalTo(self.view.mas_bottom).offset(-(CYScreanH - 64) * 0.06);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
     }];
    //提示
    UIButton *promptButton = [[UIButton alloc] init];
    [promptButton setTitle:@"有疑问请致电物业管理部门" forState:UIControlStateNormal];
    [promptButton setTitleColor:[UIColor colorWithRed:0.639 green:0.635 blue:0.639 alpha:1.00] forState:UIControlStateNormal];
    [promptButton setImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];
    promptButton.backgroundColor = [UIColor clearColor];
    promptButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:10];
    [self.view addSubview:promptButton];
    [promptButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.mas_equalTo(CYScreanW * 0.5);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
         make.top.equalTo(self.ImmediatePaymentButton.mas_bottom).offset(0);
         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
     }];
    self.shadowImage = [[UIImageView alloc] init];
    self.shadowImage.image = [UIImage imageNamed:@"222支付"];
    [self.view addSubview:self.shadowImage];
    [self.shadowImage mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.width.mas_equalTo(CYScreanW);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo((CYScreanH - 64) * 0.43);
    }];
    self.shadowImage.hidden = YES;
    //支付方式列表
    self.selectPayTypeTableView = [[UITableView alloc] init];
    self.selectPayTypeTableView.delegate = self;
    self.selectPayTypeTableView.dataSource = self;
    self.selectPayTypeTableView.scrollEnabled = NO;
    self.selectPayTypeTableView.showsVerticalScrollIndicator = NO;
    self.selectPayTypeTableView.backgroundColor = [UIColor whiteColor];
    self.selectPayTypeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.selectPayTypeTableView];
    [self.selectPayTypeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo((CYScreanH - 64) * 0.42);
    }];
    self.selectPayTypeTableView.hidden = YES;
}
//使用积分
- (void) useIntegralButton:(UIButton *)sender
{
    NSString *score2money = [NSString stringWithFormat:@"%@",[self.orderDetailsDict objectForKey:@"score2money"]];
    if (self.useIntegralButton.selected == NO)
    {
        self.useIntegralButton.selected = YES;
        self.priceLabel.text = [NSString stringWithFormat:@"%.2f",[self.priceLabel.text floatValue] - [score2money floatValue]];
    }
    else
    {
        self.useIntegralButton.selected = NO;
        self.priceLabel.text = [NSString stringWithFormat:@"%.2f",[self.priceLabel.text floatValue] + [score2money floatValue]];
    }
    
}
// - - - - -- - - - -- - -   -- - - - - -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.selectPayTypeTableView)
    {
        if (indexPath.row == 0)
        {
            return (CYScreanH - 64) * 0.05;
        }
        else if (indexPath.row == 3)
        {
            return (CYScreanH - 64) * 0.06;
        }
        else if (indexPath.row == 4)
        {
            return (CYScreanH - 64) * 0.03;
        }
        else
            return (CYScreanH - 64) * 0.13;
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
    if (tableView == self.selectPayTypeTableView)
    {
        return 5;
    }
    else
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
    if (tableView == self.selectPayTypeTableView)
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"请选择支付方式";
        }
        else if (indexPath.row == 1)
        {
            self.orderType = @"alipay";
            //图标
            UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.02, (CYScreanH - 64) * 0.015, CYScreanW * 0.15, (CYScreanH - 64) * 0.1)];
            headImage.image = [UIImage imageNamed:@"icon_alipay"];
            [cell.contentView addSubview:headImage];
            //方式
            UILabel *nameLabel = [[UILabel alloc] init];
            nameLabel.textColor = [UIColor blackColor];
            nameLabel.text = @"支付宝支付";
            nameLabel.font = [UIFont fontWithName:@"Arial" size:15];
            [cell.contentView addSubview:nameLabel];
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.03);
                 make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.015);
                 make.width.mas_equalTo (CYScreanW * 0.5);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.05);
             }];
            //描述
            UILabel *promptLabel = [[UILabel alloc] init];
            promptLabel.text = @"支持有支付宝账号的用户使用";
            promptLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
            promptLabel.font = [UIFont fontWithName:@"Arial" size:12];
            [cell.contentView addSubview:promptLabel];
            [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(nameLabel);
                 make.width.mas_equalTo (CYScreanW * 0.5);
                 make.top.equalTo(nameLabel.mas_bottom).offset(0);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.05);
             }];
            //选择显示图标
            self.selectPayTreasureButton = [[UIButton alloc] init];
            [self.selectPayTreasureButton setBackgroundImage:[UIImage imageNamed:@"icon_selected_withbg"] forState:UIControlStateNormal];
            self.selectPayTreasureButton.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:self.selectPayTreasureButton];
            [self.selectPayTreasureButton mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.02);
                 make.width.mas_equalTo(CYScreanW * 0.045);
                 make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.05);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.03);
             }];
        }
        else if (indexPath.row == 2)
        {
            //图标
            UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.02, (CYScreanH - 64) * 0.015, CYScreanW * 0.15, (CYScreanH - 64) * 0.1)];
            headImage.image = [UIImage imageNamed:@"icon_weixin"];
            [cell.contentView addSubview:headImage];
            //方式
            UILabel *nameLabel = [[UILabel alloc] init];
            nameLabel.textColor = [UIColor blackColor];
            nameLabel.text = @"微信支付";
            nameLabel.font = [UIFont fontWithName:@"Arial" size:15];
            [cell.contentView addSubview:nameLabel];
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.03);
                 make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.015);
                 make.width.mas_equalTo (CYScreanW * 0.5);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.05);
             }];
            //描述
            UILabel *promptLabel = [[UILabel alloc] init];
            promptLabel.text = @"推荐已安装微信的用户使用";
            promptLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
            promptLabel.font = [UIFont fontWithName:@"Arial" size:12];
            [cell.contentView addSubview:promptLabel];
            [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(nameLabel);
                 make.width.mas_equalTo (CYScreanW * 0.5);
                 make.top.equalTo(nameLabel.mas_bottom).offset(0);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.05);
             }];
            //选择显示图标
            self.selectWeChatButton = [[UIButton alloc] init];
            [self.selectWeChatButton setBackgroundImage:[UIImage imageNamed:@"icon_selected_withbg"] forState:UIControlStateNormal];
            self.selectWeChatButton.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:self.selectWeChatButton];
            [self.selectWeChatButton mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.02);
                 make.width.mas_equalTo(CYScreanW * 0.045);
                 make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.05);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.03);
             }];
            self.selectWeChatButton.hidden = YES;
        }
        else if (indexPath.row == 3)
        {
            //确认支付
            UIButton *complaintsButton = [[UIButton alloc] init];
            [complaintsButton setTitle:@"确认支付" forState:UIControlStateNormal];
            [complaintsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            complaintsButton.layer.cornerRadius = 5;
            complaintsButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
            [complaintsButton addTarget:self action:@selector(ProPayRequest) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:complaintsButton];
            [complaintsButton mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.02);
                 make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.02);
                 make.top.equalTo(cell.mas_top).offset(0);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.06);
             }];
        }
    }
    else
    {
        NSArray *promptArray = @[@"缴费单位",@"手机号",@"户名",@"住址信息",@"缴费金额"];
        if (indexPath.row == 4)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@",promptArray[indexPath.row]];
            self.priceLabel = [[UILabel alloc] init];
            self.priceLabel.text = [NSString stringWithFormat:@"%@",self.proPayConArray[indexPath.row]];
            self.priceLabel.font = [UIFont fontWithName:@"Arial" size:12];
            self.priceLabel.textAlignment = NSTextAlignmentRight;
            self.priceLabel.textColor = [UIColor colorWithRed:0.255 green:0.557 blue:0.910 alpha:1.00];
            [cell.contentView addSubview:self.priceLabel];
            [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.05);
                 make.width.mas_equalTo(CYScreanW * 0.6);
                 make.top.equalTo(cell.mas_top).offset(0);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.06);
             }];        }
        else if (indexPath.row == 5)
        {
            //选择阅读协议按钮
            self.useIntegralButton = [[UIButton alloc] init];
            [self.useIntegralButton setBackgroundImage:[UIImage imageNamed:@"agree_default"] forState:UIControlStateNormal];
            [self.useIntegralButton setBackgroundImage:[UIImage imageNamed:@"agree"] forState: UIControlStateSelected];
            [cell.contentView addSubview:self.useIntegralButton];
            [self.useIntegralButton addTarget:self action:@selector(useIntegralButton:) forControlEvents:UIControlEventTouchUpInside];
            self.useIntegralButton.backgroundColor = [UIColor clearColor];
            [self.useIntegralButton mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.05);
                 make.width.mas_equalTo(CYScreanW * 0.06);
                 make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.01);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.04);
             }];
            self.useIntegralButton.selected = NO;
            
            
            //积分
            NSString *totalScore = [NSString stringWithFormat:@"%@",[self.orderDetailsDict objectForKey:@"totalScore"]];
            NSString *scoreUsed = [NSString stringWithFormat:@"%@",[self.orderDetailsDict objectForKey:@"scoreUsed"]];
            NSString *score2money = [NSString stringWithFormat:@"%@",[self.orderDetailsDict objectForKey:@"score2money"]];
            UILabel *label = [[UILabel alloc] init];
            label.text = [NSString stringWithFormat:@"当前可用积分%.0f,消耗积分%.0f,抵现%.2f元",[totalScore floatValue],[scoreUsed floatValue],[score2money floatValue]];
            label.font = [UIFont fontWithName:@"Arial" size:10];
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
            [cell.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.right.equalTo(self.useIntegralButton.mas_left).offset(-CYScreanW * 0.02);
                 make.width.mas_equalTo(CYScreanW);
                 make.top.equalTo(cell.mas_top).offset(0);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.06);
             }];
        }
        else if (indexPath.row == 6)
        {
            //选择阅读协议按钮
            self.agreementPPCButton = [[UIButton alloc] init];
            [self.agreementPPCButton setBackgroundImage:[UIImage imageNamed:@"agree_default"] forState:UIControlStateNormal];
            [self.agreementPPCButton setBackgroundImage:[UIImage imageNamed:@"agree"] forState: UIControlStateSelected];
            [cell.contentView addSubview:self.agreementPPCButton];
            [self.agreementPPCButton addTarget:self action:@selector(agreementOnOClickButton:) forControlEvents:UIControlEventTouchUpInside];
            self.agreementPPCButton.backgroundColor = [UIColor clearColor];
            [self.agreementPPCButton mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.04);
                 make.width.mas_equalTo(CYScreanW * 0.06);
                 make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.01);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.04);
             }];
            self.agreementPPCButton.selected = YES;
            //协议
            UIButton *agreementButton = [[UIButton alloc] init];
            [agreementButton setTitle:@"同意《瀧璟智慧社区使用条款与隐私规则》" forState:UIControlStateNormal];
            agreementButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12];
            agreementButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左
            [agreementButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [cell.contentView addSubview:agreementButton];
            [agreementButton mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(self.agreementPPCButton.mas_right).offset(CYScreanW * 0.01);
                 make.right.equalTo(cell.mas_right).offset(- CYScreanW * 0.05);
                 make.top.equalTo(cell.mas_top).offset(0);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.06);
             }];
            NSMutableAttributedString *sendMessageString = [[NSMutableAttributedString alloc] initWithString:agreementButton.titleLabel.text];
            [sendMessageString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.255 green:0.557 blue:0.910 alpha:1.00] range:NSMakeRange(2,17)];
            //        [sendMessageString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:15] range:NSMakeRange(0,2)];
            agreementButton.titleLabel.attributedText = sendMessageString;
        }
        else
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.proPayConArray[indexPath.row]];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",promptArray[indexPath.row]];
        }
    }
    //分割线
    if ((tableView == self.selectPayTypeTableView && (indexPath.row == 0 || indexPath.row== 1)) || (tableView == self.ProPayConfirmTableView && indexPath.row < 4))
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
    if (tableView == _selectPayTypeTableView)
    {
        if (indexPath.row == 1)
        {
            self.selectPayTreasureButton.hidden = NO;
            self.selectWeChatButton.hidden = YES;
            self.orderType = @"alipay";
        }
        else if (indexPath.row == 2)
        {
            self.selectPayTreasureButton.hidden = YES;
            self.selectWeChatButton.hidden = NO;
            self.orderType = @"wx";
        }
    }
    else
    {
        self.selectPayTypeTableView.hidden = YES;
        self.shadowImage.hidden = YES;
    }
}
//是否遵循协议按钮
- (void) agreementOnOClickButton:(UIButton *)sender
{
    if (self.agreementPPCButton.selected == YES)
    {
        self.ImmediatePaymentButton.backgroundColor = [UIColor grayColor];
        self.ImmediatePaymentButton.userInteractionEnabled = NO;
        self.agreementPPCButton.selected = NO;
    }
    else
    {
        self.ImmediatePaymentButton.userInteractionEnabled = YES;
        self.ImmediatePaymentButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
        self.agreementPPCButton.selected = YES;
    }
}

//显示支付选择页面
- (void) showPayTypeButton
{
    self.shadowImage.hidden = NO;
    self.selectPayTypeTableView.hidden = NO;
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.shadowImage.hidden = YES;
    self.selectPayTypeTableView.hidden = YES;
}
//发起支付
- (void) ProPayRequest
{
    [MBProgressHUD showLoadToView:self.view];
    //
    self.shadowImage.hidden = YES;
    self.selectPayTypeTableView.hidden = YES;
    
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //[manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"type"]        =  [NSString stringWithFormat:@"%@",self.orderType];;//
    parames[@"id"]          =  [NSString stringWithFormat:@"%@",self.orderId];
    parames[@"useScore"]    =  [NSString stringWithFormat:@"%@",self.useIntegralButton.selected == YES ? @"1" : @"0"];
    NSLog(@"parames = %@",parames);
    //url  
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/pay",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSLog(@"支付成功");
             self.chargeDict = [NSDictionary dictionaryWithDictionary:[[JSON objectForKey:@"param"] objectForKey:@"charge"]];
             [self wakeUpPingWithCharge:[[JSON objectForKey:@"param"] objectForKey:@"charge"]];
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
}

- (void)wakeUpPingWithCharge:(NSDictionary *)charge
{
    NSString *kURLScheme = @"BridgeworldWisdomCommunity";
    [Pingpp createPayment:charge
           viewController:self.ProPayController
             appURLScheme:kURLScheme
           withCompletion:^(NSString *result, PingppError *error) {
               if ([result isEqualToString:@"success"]){
                   // 支付成功
                   NSLog(@"支付成功");
                   [self paySayResult];
               }else{
                   // 支付失败或取消
                   NSLog(@"Error: code=%lu msg=%@", error.code, [error getMsg]);
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
    parames[@"charge_id"]   =  [NSString stringWithFormat:@"%@",[self.chargeDict objectForKey:@"id"]];;//
    parames[@"id"]          =  [NSString stringWithFormat:@"%@",self.orderId];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/paySelect",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         NSString *type = [[NSString alloc] init];
         if ([self.orderType isEqual:@"alipay"])
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
             self.ProPayController.dataArray = @[@"1",self.proPayConArray[4],self.orderId,self.proPayConArray[2],@"缴费成功",type,@"返回"];
         }
         else
         {
             self.ProPayController.dataArray = @[@"0",self.proPayConArray[4],self.orderId,self.proPayConArray[2],@"缴费失败",type,@"返回缴费"];;
             NSLog(@"后台支付失败");
             [self cannelOrderRequest:@"cancel"];
         }
         //跳转
         UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
         [self.navigationItem setBackBarButtonItem:backItem];
         [self.navigationController pushViewController:self.ProPayController animated:YES];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"后台支付结果请求失败:%@", error.description);
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
     }];
}
- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"payResult" object:nil];
}

//取消订单
- (void) cannelOrderRequest:(NSString *)type
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"id"]          =  [NSString stringWithFormat:@"%@",self.orderId];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/cancelPopOrder",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
        
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"取消订单请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             if ([type isEqualToString:@"back"])
             {
                 [self.navigationController popViewControllerAnimated:YES];
             }
         }
         else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"取消订单请求失败:%@", error.description);
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
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
