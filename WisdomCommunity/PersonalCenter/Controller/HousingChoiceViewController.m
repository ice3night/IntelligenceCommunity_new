//
//  HousingChoiceViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "HousingChoiceViewController.h"
#import "LoginViewController.h"
@interface HousingChoiceViewController ()

@end

@implementation HousingChoiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self setHChoiceStyle];
    [self initHouChoControllers];
    
}
//设置样式
- (void) setHChoiceStyle
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"房屋选择";

}
- (void) viewWillAppear:(BOOL)animated
{
    [self getCommunityHousePlist];
}
- (void) viewWillDisappear:(BOOL)animated
{
    //清空房屋信息
    self.HouseDict = nil;
}
//页面初始化
- (void) initHouChoControllers
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    //选择小区
    UIButton *btnLeft = [[UIButton alloc] init];
    if ([self.InputController isEqualToString:@"MyHousPlistViewController"])
    {
        btnLeft.frame = CGRectMake(CYScreanW * 0.05, (CYScreanH - 64) * 0.05, CYScreanW * 0.4, (CYScreanH - 64) * 0.06);
    }
    else
    {
        btnLeft.frame = CGRectMake(CYScreanW * 0.05, 64 + (CYScreanH - 64) * 0.05, CYScreanW * 0.4, (CYScreanH - 64) * 0.06);
    }
    
    btnLeft.backgroundColor = [UIColor clearColor];
    [btnLeft setTitle:@"小区选择" forState:UIControlStateNormal];
    [btnLeft setTitleColor:[UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00] forState:UIControlStateNormal];
    [btnLeft setImage:[UIImage imageNamed:@"icon_title_service"] forState:UIControlStateNormal];
    btnLeft.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    btnLeft.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:btnLeft];
    //选择按钮
    self.selectButton = [[UIButton alloc] init];
    self.selectButton.backgroundColor = [UIColor clearColor];
    [self.selectButton setImage:[UIImage imageNamed:@"icon_drop_down"] forState:UIControlStateNormal];
    [self.selectButton setTitleColor:[UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00] forState:UIControlStateNormal];
    self.selectButton.layer.cornerRadius = 5;
    self.selectButton.layer.borderWidth = 1;
    self.selectButton.titleLabel.font = font;
    self.selectButton.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
    [self.selectButton addTarget:self action:@selector(selectCommunityButton) forControlEvents:UIControlEventTouchUpInside];
//    selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:self.selectButton];
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(btnLeft.mas_bottom).offset((CYScreanH - 64) * 0.01);
         make.left.equalTo(btnLeft);
         make.width.mas_equalTo(CYScreanW * 0.7);
         make.height.mas_equalTo((CYScreanH - 64) * 0.05);
    }];
    
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    segmentationImmage.backgroundColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
    [self.view addSubview:segmentationImmage];
    [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.bottom.equalTo(self.selectButton.mas_bottom).offset((CYScreanH - 64) * 0.05);
         make.height.mas_equalTo(1);
     }];
    //楼号、单元、门牌号
    NSArray *promptArray = @[@"楼号:",@"单元:",@"门牌号:"];
    NSArray *promptArrayT = @[@"号楼",@"单元",@"号"];
    for (int i = 0 ; i < promptArray.count; i ++)
    {
        UILabel *promptLabel = [[UILabel alloc] init];
        promptLabel.textAlignment = NSTextAlignmentCenter;
        promptLabel.text = [NSString stringWithFormat:@"%@",promptArray[i]];
        promptLabel.textColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
        [self.view addSubview:promptLabel];
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.left.equalTo(self.view.mas_left).offset(0);
            make.height.mas_equalTo((CYScreanH - 64) * 0.06);
            make.width.mas_equalTo(CYScreanW * 0.2);
            make.top.equalTo(segmentationImmage.mas_bottom).offset((CYScreanH - 64) * 0.02 + (CYScreanH - 64) * 0.08 * i);
        }];
        
        UILabel *promptLabelT = [[UILabel alloc] init];
        promptLabelT.textAlignment = NSTextAlignmentLeft;
        promptLabelT.text = [NSString stringWithFormat:@"%@",promptArrayT[i]];
        promptLabelT.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
        [self.view addSubview:promptLabelT];
        [promptLabelT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.48);
            make.height.mas_equalTo((CYScreanH - 64) * 0.06);
            make.width.mas_equalTo(CYScreanW * 0.2);
            make.top.equalTo(segmentationImmage.mas_bottom).offset((CYScreanH - 64) * 0.02 + (CYScreanH - 64) * 0.08 * i);
        }];
    }
    
    //
    self.buildNumberTextField = [[UITextField alloc] init];
    self.buildNumberTextField.delegate = self;
    self.buildNumberTextField.placeholder = @"必填";
    self.buildNumberTextField.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
    self.buildNumberTextField.backgroundColor = [UIColor clearColor];
    self.buildNumberTextField.textAlignment = NSTextAlignmentCenter;
    self.buildNumberTextField.layer.cornerRadius = 5;
    self.buildNumberTextField.keyboardType = UIReturnKeyDone;
    self.buildNumberTextField.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
    self.buildNumberTextField.layer.borderWidth = 1;
    [self.view addSubview:self.buildNumberTextField];
    [self.buildNumberTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.2);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
         make.width.mas_equalTo(CYScreanW * 0.25);
         make.top.equalTo(segmentationImmage.mas_bottom).offset((CYScreanH - 64) * 0.02);
     }];
    //
    self.unitNumberTextField = [[UITextField alloc] init];
    self.unitNumberTextField.delegate = self;
    self.unitNumberTextField.placeholder = @"非必填";
    self.unitNumberTextField.keyboardType = UIReturnKeyDone;
    self.unitNumberTextField.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
    self.unitNumberTextField.backgroundColor = [UIColor clearColor];
    self.unitNumberTextField.textAlignment = NSTextAlignmentCenter;
    self.unitNumberTextField.layer.cornerRadius = 5;
    self.unitNumberTextField.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
    self.unitNumberTextField.layer.borderWidth = 1;
    [self.view addSubview:self.unitNumberTextField];
    [self.unitNumberTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.2);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
         make.width.mas_equalTo(CYScreanW * 0.25);
         make.top.equalTo(segmentationImmage.mas_bottom).offset((CYScreanH - 64) * 0.1);
     }];
    //
    self.houseNumberTextField = [[UITextField alloc] init];
    self.houseNumberTextField.delegate = self;
    self.houseNumberTextField.placeholder = @"必填";
    self.houseNumberTextField.keyboardType = UIReturnKeyDone;
    self.houseNumberTextField.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
    self.houseNumberTextField.backgroundColor = [UIColor clearColor];
    self.houseNumberTextField.textAlignment = NSTextAlignmentCenter;
    self.houseNumberTextField.layer.cornerRadius = 5;
    self.houseNumberTextField.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
    self.houseNumberTextField.layer.borderWidth = 1;
    [self.view addSubview:self.houseNumberTextField];
    [self.houseNumberTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.2);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
         make.width.mas_equalTo(CYScreanW * 0.25);
         make.top.equalTo(segmentationImmage.mas_bottom).offset((CYScreanH - 64) * 0.18);
     }];
    //填写信息
    if (self.HouseDict)
    {
        NSString *buildString = [NSString stringWithFormat:@"%@",[self.HouseDict objectForKey:@"build"]];
        NSArray *Array = [buildString componentsSeparatedByString:@"#"];//拆分成数组
        if (Array.count == 3)
        {
            self.buildNumberTextField.text = [NSString stringWithFormat:@"%@",Array[0]];
            self.unitNumberTextField.text = [NSString stringWithFormat:@"%@",Array[1]];
            self.houseNumberTextField.text = [NSString stringWithFormat:@"%@",Array[2]];
        }
    }
    //注册
    UIButton *registeredButton = [[UIButton alloc] init];
    [registeredButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_def"] forState:UIControlStateNormal];
    [registeredButton setTitle:@"提交" forState:UIControlStateNormal];
    registeredButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [registeredButton addTarget:self action:@selector(AddMyHouseRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registeredButton];
    [registeredButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.25);
         make.right.equalTo(self.view.mas_right).offset(- CYScreanW * 0.25);
         make.top.equalTo(self.houseNumberTextField.mas_bottom).offset((CYScreanH - 64) * 0.1);
         make.height.mas_equalTo((CYScreanH - 64) * 0.08);
     }];
    //物业公司
    self.SelectComTableView = [[UITableView alloc] init];
    self.SelectComTableView.delegate = self;
    self.SelectComTableView.dataSource = self;
    self.SelectComTableView.showsVerticalScrollIndicator = NO;
    self.SelectComTableView.layer.borderWidth = 1;
    self.SelectComTableView.layer.borderColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00].CGColor;
    self.SelectComTableView.backgroundColor = [UIColor whiteColor];
    self.SelectComTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.SelectComTableView];
    self.SelectComTableView.hidden = YES;
}
//选择小区
- (void) selectCommunityButton
{
    if (self.SelectComTableView.hidden == YES)
    {
        self.SelectComTableView.hidden = NO;
    }
    else
        self.SelectComTableView.hidden = YES;
}
//设置物业公司布局
- (void) setButtonHouseLayout:(NSString *)string
{
    //编辑进入
    if (self.HouseDict)
    {
        //首先遍历有没有要修改小区的数据
        for (NSDictionary *dict in self.communityDataArray)
        {
            if ([[dict objectForKey:@"id"] integerValue] == [[self.HouseDict objectForKey:@"comNo"] integerValue])
            {
                self.selectHouseComDict = dict;//将符合的数据记录下来
                self.selectHouseComId = [NSString stringWithFormat:@"%@",[self.HouseDict objectForKey:@"comNo"]];
                string = [NSString stringWithFormat:@"%@ %@",[self.selectHouseComDict objectForKey:@"city"],[self.selectHouseComDict objectForKey:@"comName"]];
                break;
            }
        }
    }
    CGSize sizeP = [string sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    CGSize sizePImage = [UIImage imageNamed:@"icon_title_heart"].size;
    [self.selectButton setTitle:string forState:UIControlStateNormal];
    self.selectButton.imageEdgeInsets = UIEdgeInsetsMake(0, sizeP.width, 0, - sizeP.width);
    self.selectButton.titleEdgeInsets = UIEdgeInsetsMake(0, - sizePImage.width, 0, sizePImage.width);
}
//提交
- (void) submitHouseData
{
    if ([self.InputController isEqualToString:@"MyHousPlistViewController"])
    {
        [MBProgressHUD showError:@"提交成功" ToView:self.navigationController.view];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        NSArray *array = self.navigationController.viewControllers;
        NSLog(@"array = %@",array);
        //创建标签控制器
        UITabBarController *tabbarController = [[UITabBarController alloc] init];
        NSArray *arryaVC = @[@"RootViewController",@"NewMallViewController",@"HWScanViewController",@"CommunityABBSViewController",@"PersonalCenterViewController"];
        NSMutableArray *arrayNav = [[NSMutableArray alloc] initWithCapacity:arryaVC.count];
        for (NSString *str in arryaVC)
        {
            UIViewController *viewController = [[NSClassFromString(str) alloc] init];
            UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
            navigation.navigationBar.translucent = NO;
            navigation.navigationBar.barStyle = UIBarStyleBlackTranslucent;
            [navigation.navigationBar setBarTintColor:BackGroundColor];
            [navigation.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ShallowGrayColor,UITextAttributeTextColor,nil]];
            navigation.navigationBar.tintColor = ShallowBrownColoe;
            [arrayNav addObject:navigation];
            if ([str isEqualToString:@"RootViewController"])
            {
                navigation.tabBarItem.title = @"首页";
                navigation.tabBarItem.image = [UIImage imageNamed:@"tab_home_default"];
                navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_home_selected"];
            }
            else if([str isEqualToString:@"NewMallViewController"])
            {
                navigation.tabBarItem.title = @"社区商城";
                navigation.tabBarItem.image = [UIImage imageNamed:@"tab_mall_default"];
                //未标题-1_26
                navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_mall_selected"];
            }else if([str isEqualToString:@"HWScanViewController"])
            {
                navigation.tabBarItem.title = @"";
                navigation.tabBarItem.image = [UIImage imageNamed:@"erweim"];
                //未标题-1_26
                navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"erweim"];
            }
            else if([str isEqualToString:@"CommunityABBSViewController"])
            {
                navigation.tabBarItem.title = @"社区大小事";
                navigation.tabBarItem.image = [UIImage imageNamed:@"tab_community_default.png"];
                //未标题-1_32
                navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_community_selected"];
            }
            else if([str isEqualToString:@"PersonalCenterViewController"])
            {
                navigation.tabBarItem.title = @"我的";
                navigation.tabBarItem.image = [UIImage imageNamed:@"tab_me_default.png"];
                //未标题-1_32
                navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_me_selected"];
            }
            //        navigation.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 30, 30);
        }
        tabbarController.viewControllers = arrayNav;
        //点击之后字体颜色
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.302 green:0.545 blue:0.914 alpha:1.00],UITextAttributeTextColor,nil] forState:UIControlStateSelected];
        tabbarController.tabBar.selectedImageTintColor = [UIColor colorWithRed:0.302 green:0.545 blue:0.914 alpha:1.00];
        self.view.window.rootViewController = tabbarController;
    }
}
//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//屏幕点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.buildNumberTextField resignFirstResponder];
    [self.houseNumberTextField resignFirstResponder];
    [self.unitNumberTextField resignFirstResponder];
}

//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    return self.communityDataArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.communityDataArray[indexPath.row]];
    NSString *string = [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"city"],[dict objectForKey:@"comName"]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",string];
    return cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.SelectComTableView.hidden = YES;
    self.selectHouseComDict = [NSDictionary dictionaryWithDictionary:self.communityDataArray[indexPath.row]];
    
    self.selectHouseComId = [NSString stringWithFormat:@"%@",[self.selectHouseComDict objectForKey:@"id"]];
    NSString *string = [NSString stringWithFormat:@"%@ %@",[self.selectHouseComDict objectForKey:@"city"],[self.selectHouseComDict objectForKey:@"comName"]];
    CGSize sizeP = [string sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    CGSize sizePImage = [UIImage imageNamed:@"icon_title_heart"].size;
    [self.selectButton setTitle:string forState:UIControlStateNormal];
    self.selectButton.imageEdgeInsets = UIEdgeInsetsMake(0, sizeP.width, 0, - sizeP.width);
    self.selectButton.titleEdgeInsets = UIEdgeInsetsMake(0, - sizePImage.width, 0, sizePImage.width);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//获取社区列表
- (void) getCommunityHousePlist
{
    [MBProgressHUD showLoadToView:self.view];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/community/comList",POSTREQUESTURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlStringUTF8 = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStringUTF8 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            self.communityDataArray = [NSArray arrayWithArray:[[JSON objectForKey:@"param"] objectForKey:@"comList"]];
            if (self.communityDataArray.count > 0)
            {
                [self setComTV:self.communityDataArray];
            }
            else
                [MBProgressHUD showError:@"没有社区数据" ToView:self.view];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"加载出错" ToView:self.view];
        NSLog(@"请求失败:%@", error.description);
    }];
}
- (void) setComTV:(NSArray *)array
{
    self.selectHouseComDict = [NSDictionary dictionaryWithDictionary:array[0]];
    self.selectHouseComId = [NSString stringWithFormat:@"%@",[self.selectHouseComDict objectForKey:@"id"]];
    NSString *string = [NSString stringWithFormat:@"%@ %@",[self.selectHouseComDict objectForKey:@"city"],[self.selectHouseComDict objectForKey:@"comName"]];
    //物业公司
    [self setButtonHouseLayout:string];
    [self.SelectComTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.selectButton);
         make.right.equalTo(self.selectButton);
         make.top.equalTo(self.selectButton.mas_bottom).offset(0);
         make.height.mas_equalTo(array.count * (CYScreanH - 64) * 0.06);
     }];
    [self.SelectComTableView reloadData];
}
//添加我的房屋
- (void) AddMyHouseRequest
{
    if (self.buildNumberTextField.text.length && self.houseNumberTextField.text.length)
    {
        
        if ([CYSmallTools isPureNumandCharacters:self.buildNumberTextField.text] && [CYSmallTools isPureNumandCharacters:self.houseNumberTextField.text])
        {
            [self alertShow];
        }
        else
            [MBProgressHUD showError:@"只能填写数字信息" ToView:self.view];
    }
    else
        [MBProgressHUD showError:@"信息不完整" ToView:self.view];
    
}
- (void) alertShow
{
    NSString *string = [NSString stringWithFormat:@"请确认房屋信息:%@,%@号楼%@单元%@室",[self.selectHouseComDict objectForKey:@"comName"],self.buildNumberTextField.text,self.unitNumberTextField.text,self.houseNumberTextField.text];
    //初始化提示框；
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:  UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          //点击按钮的响应事件；
                      }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          //点击按钮的响应事件；
                          [MBProgressHUD showLoadToView:self.view];
                          NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/addMyBuild",POSTREQUESTURL];
                          AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                          manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                          NSMutableDictionary *parames = [NSMutableDictionary dictionary];
                          parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
                          parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
                          parames[@"comNo"]     =  [NSString stringWithFormat:@"%@",self.selectHouseComId];
                          parames[@"build"]     =  [NSString stringWithFormat:@"%@#%@#%@",self.buildNumberTextField.text,self.unitNumberTextField.text.length > 0 ? self.unitNumberTextField.text : @"1",self.houseNumberTextField.text];
                          if (self.HouseDict) {
                              requestUrl = [NSString stringWithFormat:@"%@/api/account/updateMyBuild",POSTREQUESTURL];
                              parames[@"id"] = [NSString stringWithFormat:@"%@",[self.HouseDict objectForKey:@"id"]];
                          }
                          NSLog(@"parames = %@,requestUrl = %@",parames,requestUrl);
                          
                          [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
                              
                          } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                           {
                               [MBProgressHUD hideHUDForView:self.view];
                               NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                               NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
                               if ([[JSON objectForKey:@"success"] integerValue] == 1)
                               {
                                   NSString *stringT = [NSString stringWithFormat:@"%@",[CYSmallTools getDataKey:COMDATA]];
                                   if (stringT.length <= 6)//绑定房屋
                                   {
                                       [CYSmallTools saveData:self.selectHouseComDict withKey:COMDATA];//记录
                                       [CYSmallTools saveDataString:[self.selectHouseComDict objectForKey:@"comTel"] withKey:PROPERTYCPHONE];//手机号
                                   }
                                   [self submitHouseData];
                               }
                               else
                               {
                                   //是否需要重新登录
                                   [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.navigationController.view];
                                   //进入登录页
                                   LoginViewController *GoLoController = [[LoginViewController alloc] init];
                                   [self.navigationController pushViewController:GoLoController animated:YES];
                               }
                               
                           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                           {
                               [MBProgressHUD hideHUDForView:self.view];
                               [MBProgressHUD showError:@"加载出错" ToView:self.view];
                               NSLog(@"请求失败:%@", error.description);
                           }];
                      }]];
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
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
