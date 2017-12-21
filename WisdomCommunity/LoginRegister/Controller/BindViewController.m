//
//  BindViewController.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/26.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "BindViewController.h"

@interface BindViewController ()

@end

@implementation BindViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:BackGroundColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ShallowGrayColor,UITextAttributeTextColor,nil]];
    self.view.backgroundColor = [UIColor whiteColor];
    NSInteger tokenLength = [CYSmallTools getDataStringKey:TOKEN].length;//登录
    //账号边框
    UIImageView *showImmage = [[UIImageView alloc] init];
    showImmage.image = [UIImage imageNamed:@"2rec_line_code"];
    [self.view addSubview:showImmage];
    [showImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.right.equalTo(self.view.mas_right).offset(- CYScreanW * 0.05);
         if (tokenLength <= 0)
         {
             make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.05 + 64);
         }
         else
             make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.05);
         make.height.mas_equalTo((CYScreanH - 64) * 0.08);
     }];
    //账号图标
    UIImageView *phoneImmage = [[UIImageView alloc] init];
    phoneImmage.image = [UIImage imageNamed:@"1user"];
    [self.view addSubview:phoneImmage];
    [phoneImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(showImmage.mas_left).offset(CYScreanW * 0.03);
         make.width.mas_equalTo(CYScreanW * 0.05);
         make.top.equalTo(showImmage.mas_top).offset((CYScreanH - 64) * 0.015);
         make.bottom.equalTo(showImmage.mas_bottom).offset(-(CYScreanH - 64) * 0.015);
     }];
    //账号输入框
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField.delegate = self;
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextField.textColor = [UIColor blackColor];
    _phoneTextField.backgroundColor = [UIColor clearColor];
    _phoneTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(phoneImmage.mas_right).offset(CYScreanW * 0.05);
         make.right.equalTo(showImmage.mas_right).offset(0);
         make.top.equalTo(showImmage.mas_top).offset(0);
         make.bottom.equalTo(showImmage.mas_bottom).offset(0);
     }];
    //验证码边框
    UIImageView *codeImmage = [[UIImageView alloc] init];
    codeImmage.image = [UIImage imageNamed:@"rec_line_code"];
    [self.view addSubview:codeImmage];
    [codeImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.right.equalTo(self.view.mas_right).offset(- CYScreanW * 0.35);
         make.top.equalTo(showImmage.mas_bottom).offset((CYScreanH - 64) * 0.03);
         make.height.mas_equalTo((CYScreanH - 64) * 0.08);
     }];
    //验证码图标
    UIImageView *codeImmage2 = [[UIImageView alloc] init];
    codeImmage2.image = [UIImage imageNamed:@"icon_account"];
    [self.view addSubview:codeImmage2];
    [codeImmage2 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(codeImmage.mas_left).offset(CYScreanW * 0.03);
         make.width.mas_equalTo(CYScreanW * 0.05);
         make.top.equalTo(codeImmage.mas_top).offset((CYScreanH - 64) * 0.02);
         make.bottom.equalTo(codeImmage.mas_bottom).offset(-(CYScreanH - 64) * 0.02);
     }];
    //验证码输入框
    _codeTextField = [[UITextField alloc] init];
    _codeTextField.delegate = self;
    _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _codeTextField.placeholder = @"请输入验证码";
    _codeTextField.textColor = [UIColor blackColor];
    _codeTextField.backgroundColor = [UIColor clearColor];
    _codeTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_codeTextField];
    [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(codeImmage2.mas_right).offset(CYScreanW * 0.05);
         make.right.equalTo(codeImmage.mas_right).offset(0);
         make.top.equalTo(codeImmage.mas_top).offset(0);
         make.bottom.equalTo(codeImmage.mas_bottom).offset(0);
     }];
    
    
    //获取验证码
    _getCodeButton = [[UIButton alloc] init];
    [_getCodeButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_def"] forState:UIControlStateNormal];
    [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeButton addTarget:self action:@selector(getCodeButton:) forControlEvents:UIControlEventTouchUpInside];
    _getCodeButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [self.view addSubview:_getCodeButton];
    [_getCodeButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(codeImmage.mas_right).offset(CYScreanW * 0.05);
         make.right.equalTo(self.view.mas_right).offset(- CYScreanW * 0.05);
         make.top.equalTo(showImmage.mas_bottom).offset((CYScreanH - 64) * 0.03);
         make.height.mas_equalTo((CYScreanH - 64) * 0.08);
     }];
    //密码管理
    UIImageView *pwdImmage = [[UIImageView alloc] init];
    pwdImmage.image = [UIImage imageNamed:@"2rec_line_code"];
    [self.view addSubview:pwdImmage];
    [pwdImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.right.equalTo(self.view.mas_right).offset(- CYScreanW * 0.05);
         make.top.equalTo(codeImmage.mas_bottom).offset((CYScreanH - 64) * 0.03);
         make.height.mas_equalTo((CYScreanH - 64) * 0.08);
     }];
    //密码图标
    UIImageView *suoImmage = [[UIImageView alloc] init];
    suoImmage.image = [UIImage imageNamed:@"1password"];
    [self.view addSubview:suoImmage];
    [suoImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(pwdImmage.mas_left).offset(CYScreanW * 0.03);
         make.width.mas_equalTo(CYScreanW * 0.05);
         make.top.equalTo(pwdImmage.mas_top).offset((CYScreanH - 64) * 0.02);
         make.bottom.equalTo(pwdImmage.mas_bottom).offset(-(CYScreanH - 64) * 0.02);
     }];
    //密码输入框
    _pwdTextField = [[UITextField alloc] init];
    _pwdTextField.delegate = self;
    _pwdTextField.placeholder = @"6-12位,建议数字加字母组成";
    _pwdTextField.textColor = [UIColor blackColor];
    _pwdTextField.returnKeyType = UIReturnKeyDone;
    _pwdTextField.backgroundColor = [UIColor clearColor];
    _pwdTextField.textAlignment = NSTextAlignmentLeft;
    _pwdTextField.secureTextEntry = YES;
    [self.view addSubview:_pwdTextField];
    [_pwdTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(suoImmage.mas_right).offset(CYScreanW * 0.05);
         make.right.equalTo(pwdImmage.mas_right).offset(0);
         make.top.equalTo(pwdImmage.mas_top).offset(0);
         make.bottom.equalTo(pwdImmage.mas_bottom).offset(0);
     }];
    //业主姓名
    UIImageView *UserImmage = [[UIImageView alloc] init];
    UserImmage.image = [UIImage imageNamed:@"2rec_line_code"];
    [self.view addSubview:UserImmage];
    [UserImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.right.equalTo(self.view.mas_right).offset(- CYScreanW * 0.05);
         make.top.equalTo(pwdImmage.mas_bottom).offset((CYScreanH - 64) * 0.03);
         make.height.mas_equalTo((CYScreanH - 64) * 0.08);
     }];
    //业主姓名图标
    UIImageView *UserIconImmage = [[UIImageView alloc] init];
    UserIconImmage.image = [UIImage imageNamed:@"icon_real_name"];
    [self.view addSubview:UserIconImmage];
    [UserIconImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(UserImmage.mas_left).offset(CYScreanW * 0.03);
         make.width.mas_equalTo(CYScreanW * 0.05);
         make.top.equalTo(UserImmage.mas_top).offset((CYScreanH - 64) * 0.02);
         make.bottom.equalTo(UserImmage.mas_bottom).offset(-(CYScreanH - 64) * 0.02);
     }];
    //业主姓名输入框
    self.UserNameTextField = [[UITextField alloc] init];
    self.UserNameTextField.delegate = self;
    self.UserNameTextField.placeholder = @"业主姓名";
    self.UserNameTextField.textColor = [UIColor blackColor];
    self.UserNameTextField.backgroundColor = [UIColor clearColor];
    self.UserNameTextField.textAlignment = NSTextAlignmentLeft;
    self.UserNameTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.UserNameTextField];
    [self.UserNameTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(UserIconImmage.mas_right).offset(CYScreanW * 0.05);
         make.right.equalTo(UserImmage.mas_right).offset(0);
         make.top.equalTo(UserImmage.mas_top).offset(0);
         make.bottom.equalTo(UserImmage.mas_bottom).offset(0);
     }];
    //选择阅读协议按钮
    _selectAgreementButton = [[UIButton alloc] init];
    [_selectAgreementButton setBackgroundImage:[UIImage imageNamed:@"agree_default"] forState:UIControlStateNormal];
    [_selectAgreementButton setBackgroundImage:[UIImage imageNamed:@"agree"] forState: UIControlStateSelected];
    [self.view addSubview:_selectAgreementButton];
    [_selectAgreementButton addTarget:self action:@selector(agreementOnClickButton:) forControlEvents:UIControlEventTouchUpInside];
    _selectAgreementButton.backgroundColor = [UIColor clearColor];
    [_selectAgreementButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.width.mas_equalTo(CYScreanW * 0.045);
         make.top.equalTo(UserImmage.mas_bottom).offset((CYScreanH - 64) * 0.01);
         make.height.mas_equalTo((CYScreanH - 64) * 0.03);
     }];
    _selectAgreementButton.selected = YES;
    //协议
    UIButton *agreementButton = [[UIButton alloc] init];
    [agreementButton setTitle:@"同意《瀧璟智慧社区使用条款与隐私规则》" forState:UIControlStateNormal];
    agreementButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
    agreementButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左
    [agreementButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:agreementButton];
    [agreementButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(_selectAgreementButton.mas_right).offset(CYScreanW * 0.01);
         make.right.equalTo(self.view.mas_right).offset(- CYScreanW * 0.05);
         make.top.equalTo(UserImmage.mas_bottom).offset(0);
         make.height.mas_equalTo((CYScreanH - 64) * 0.05);
     }];
    NSMutableAttributedString *sendMessageString = [[NSMutableAttributedString alloc] initWithString:agreementButton.titleLabel.text];
    [sendMessageString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.255 green:0.557 blue:0.910 alpha:1.00] range:NSMakeRange(2,17)];
    //        [sendMessageString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:15] range:NSMakeRange(0,2)];
    agreementButton.titleLabel.attributedText = sendMessageString;
    //注册
    UIButton *registeredButton = [[UIButton alloc] init];
    [registeredButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_def"] forState:UIControlStateNormal];
    [registeredButton setTitle:@"注册" forState:UIControlStateNormal];
    registeredButton.layer.cornerRadius = 5;
    registeredButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [registeredButton addTarget:self action:@selector(getRegisteredRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registeredButton];
    [registeredButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.right.equalTo(self.view.mas_right).offset(- CYScreanW * 0.05);
         make.top.equalTo(_selectAgreementButton.mas_bottom).offset((CYScreanH - 64) * 0.05);
         make.height.mas_equalTo((CYScreanH - 64) * 0.08);
     }];
    self.registeredButton = registeredButton;
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
    [_pwdTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [self.UserNameTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取验证码
- (void) getCodeButton:(UIButton *)sender
{
    //是否是手机号
    if (![CYWhetherPhone isValidPhone:self.phoneTextField.text])
    {
        [MBProgressHUD showError:@"手机号格式不正确" ToView:self.view];
        [self dealWithButton];
        return;
    }
    else
    {
        //禁止点击
        _getCodeButton.userInteractionEnabled = NO;
        //申请验证码
        [self getRegisteredCodeRequest];
        //设置倒计时总时长
        _secondsCountDownInput = 60;
        //开始倒计时
        _counTDownTimerInput = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethodInput) userInfo:nil repeats:YES];
        //显示倒计时
        [_getCodeButton setTitle:[NSString stringWithFormat:@"%ld秒后重发",_secondsCountDownInput] forState:UIControlStateNormal];
    }
}
//计时器函数
- (void) timeFireMethodInput
{
    //倒计时-1
    if (_secondsCountDownInput > 0)
    {
        _secondsCountDownInput --;
    }
    //修改倒计时标签现实内容
    [_getCodeButton setTitle:[NSString stringWithFormat:@"%ld秒后重发",_secondsCountDownInput] forState:UIControlStateNormal];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_secondsCountDownInput == 0)
    {
        [_counTDownTimerInput invalidate];
        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeButton.userInteractionEnabled = YES;//时间到之后打开交互
    }
}


- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00]];
    
    self.navigationItem.title = @"绑定手机号";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [self.navigationItem setHidesBackButton:NO];
    [self.navigationController.navigationBar setHidden:NO];
}
//将要消失
- (void) viewWillDisappear:(BOOL)animated
{
    [self dealWithButton];
}
//取消定时器
- (void) dealWithButton
{
    [_counTDownTimerInput invalidate];
    [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getCodeButton.userInteractionEnabled = YES;//时间到之后打开交互
}
//是否遵循协议按钮
- (void) agreementOnClickButton:(UIButton *)sender
{
    if (_selectAgreementButton.selected == YES)
    {
        _selectAgreementButton.selected = NO;
        
        self.registeredButton.userInteractionEnabled = NO;
        [self.registeredButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_bg-1"] forState:UIControlStateNormal];
    }
    else
    {
        _selectAgreementButton.selected = YES;
        
        self.registeredButton.userInteractionEnabled = YES;
        [self.registeredButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_def"] forState:UIControlStateNormal];
    }
}
//获取验证码
- (void) getRegisteredCodeRequest
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]  =  [NSString stringWithFormat:@"%@",self.phoneTextField.text];
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/sendCode",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         self.requestCodeDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@", self.requestCodeDict);
         if ([[self.requestCodeDict objectForKey:@"success"] integerValue] == 1)
         {
             [MBProgressHUD showError:@"发送成功" ToView:self.view];
         }
         else
             [MBProgressHUD showError:@"加载出错" ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         [self dealWithButton];
         NSLog(@"请求失败:%@", error.description);
     }];
}
//注册
- (void) getRegisteredRequest
{
    NSLog(@"[self.requestCodeDict objectForKey:@returnValue] = %@,self.codeTextField.text = %ld",[self.requestCodeDict objectForKey:@"returnValue"],self.codeTextField.text.length);
    if (![CYWhetherPhone isValidPhone:self.phoneTextField.text])
    {
        [MBProgressHUD showError:@"手机号格式不正确" ToView:self.view];
        return;
    }
    if (![CYWhetherPhone judgePassword:self.pwdTextField.text] || self.pwdTextField.text.length < 6 || self.pwdTextField.text.length > 12)
    {
        [MBProgressHUD showError:@"密码格式不正确" ToView:self.view];
        return;
    }
    if (self.UserNameTextField.text.length > 8)
    {
        [MBProgressHUD showError:@"姓名输入过长" ToView:self.view];
        return;
    }
    else
    {
        //全中文
        if (![CYSmallTools isChineseFirst:self.UserNameTextField.text])
        {
            [MBProgressHUD showError:@"请输入姓名" ToView:self.view];
            return;
        }
    }
    [MBProgressHUD showLoadToView:self.view];
    NSLog(@"self.phoneTextField.text = %@,self.pwdTextField.text = %@",self.phoneTextField.text,self.pwdTextField.text);
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    NSLog(@"昵称%@，id%@，touxiang%@",self.nickName,self.userid,self.iconUrl);
    parames[@"weChatId"] = self.userid;
    parames[@"nickName"] = self.nickName;
    parames[@"imgAddress"] = self.iconUrl;
    parames[@"account"]  =  [NSString stringWithFormat:@"%@",self.phoneTextField.text];//
    parames[@"password"]  =  [NSString stringWithFormat:@"%@",self.pwdTextField.text];
    parames[@"trueName"] =  [NSString stringWithFormat:@"%@",self.UserNameTextField.text];
    parames[@"code"] = [NSString stringWithFormat:@"%@",self.codeTextField.text];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/register",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@", JSON);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSLog(@"请求成功");
             [MBProgressHUD showError:@"注册成功" ToView:self.navigationController.view];
             [self.navigationController popViewControllerAnimated:YES];
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



@end
