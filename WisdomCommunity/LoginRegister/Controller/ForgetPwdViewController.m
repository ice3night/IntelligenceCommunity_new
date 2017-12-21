//
//  ForgetPwdViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ForgetPwdViewController.h"

@interface ForgetPwdViewController ()

@end

@implementation ForgetPwdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    _phoneFPTextField = [[UITextField alloc] init];
    _phoneFPTextField.placeholder = @"请输入手机号";
    _phoneFPTextField.delegate = self;
    _phoneFPTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneFPTextField.textColor = [UIColor blackColor];
    _phoneFPTextField.backgroundColor = [UIColor clearColor];
    _phoneFPTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_phoneFPTextField];
    [_phoneFPTextField mas_makeConstraints:^(MASConstraintMaker *make)
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
    _codeFPTextField = [[UITextField alloc] init];
    _codeFPTextField.delegate = self;
    _codeFPTextField.placeholder = @"请输入密码";
    _codeFPTextField.textColor = [UIColor blackColor];
    _codeFPTextField.backgroundColor = [UIColor clearColor];
    _codeFPTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_codeFPTextField];
    [_codeFPTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(codeImmage2.mas_right).offset(CYScreanW * 0.05);
         make.right.equalTo(codeImmage.mas_right).offset(0);
         make.top.equalTo(codeImmage.mas_top).offset(0);
         make.bottom.equalTo(codeImmage.mas_bottom).offset(0);
     }];
    //获取验证码
    _getFPCodeButton = [[UIButton alloc] init];
    [_getFPCodeButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_def"] forState:UIControlStateNormal];
    [_getFPCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getFPCodeButton addTarget:self action:@selector(getFPCodeButton:) forControlEvents:UIControlEventTouchUpInside];
    _getFPCodeButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [self.view addSubview:_getFPCodeButton];
    [_getFPCodeButton mas_makeConstraints:^(MASConstraintMaker *make)
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
    _pwdFPTextField = [[UITextField alloc] init];
    _pwdFPTextField.delegate = self;
    _pwdFPTextField.placeholder = @"6-12位,建议数字加字母组成";
    _pwdFPTextField.textColor = [UIColor blackColor];
    _pwdFPTextField.secureTextEntry = YES;
    _pwdFPTextField.backgroundColor = [UIColor clearColor];
    _pwdFPTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_pwdFPTextField];
    [_pwdFPTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(suoImmage.mas_right).offset(CYScreanW * 0.05);
         make.right.equalTo(pwdImmage.mas_right).offset(0);
         make.top.equalTo(pwdImmage.mas_top).offset(0);
         make.bottom.equalTo(pwdImmage.mas_bottom).offset(0);
     }];
    //密码管理
    UIImageView *confirmPwdImmage = [[UIImageView alloc] init];
    confirmPwdImmage.image = [UIImage imageNamed:@"2rec_line_code"];
    [self.view addSubview:confirmPwdImmage];
    [confirmPwdImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.right.equalTo(self.view.mas_right).offset(- CYScreanW * 0.05);
         make.top.equalTo(pwdImmage.mas_bottom).offset((CYScreanH - 64) * 0.03);
         make.height.mas_equalTo((CYScreanH - 64) * 0.08);
     }];
    //密码图标
    UIImageView *confirmImmage = [[UIImageView alloc] init];
    confirmImmage.image = [UIImage imageNamed:@"1password"];
    [self.view addSubview:confirmImmage];
    [confirmImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(confirmPwdImmage.mas_left).offset(CYScreanW * 0.03);
         make.width.mas_equalTo(CYScreanW * 0.05);
         make.top.equalTo(confirmPwdImmage.mas_top).offset((CYScreanH - 64) * 0.02);
         make.bottom.equalTo(confirmPwdImmage.mas_bottom).offset(-(CYScreanH - 64) * 0.02);
     }];
    //密码输入框
    _confirmPwdFPTextField = [[UITextField alloc] init];
    _confirmPwdFPTextField.delegate = self;
    _confirmPwdFPTextField.placeholder = @"请确认新密码";
    _confirmPwdFPTextField.textColor = [UIColor blackColor];
    _confirmPwdFPTextField.backgroundColor = [UIColor clearColor];
    _confirmPwdFPTextField.textAlignment = NSTextAlignmentLeft;
    _confirmPwdFPTextField.secureTextEntry = YES;
    [self.view addSubview:_confirmPwdFPTextField];
    [_confirmPwdFPTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(confirmImmage.mas_right).offset(CYScreanW * 0.05);
         make.right.equalTo(confirmPwdImmage.mas_right).offset(0);
         make.top.equalTo(confirmPwdImmage.mas_top).offset(0);
         make.bottom.equalTo(confirmPwdImmage.mas_bottom).offset(0);
     }];
    //确认
    UIButton *registeredButton = [[UIButton alloc] init];
    [registeredButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_def"] forState:UIControlStateNormal];
    [registeredButton setTitle:@"确定" forState:UIControlStateNormal];
    registeredButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [registeredButton addTarget:self action:@selector(registeredFPButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registeredButton];
    [registeredButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.right.equalTo(self.view.mas_right).offset(- CYScreanW * 0.05);
         make.top.equalTo(confirmPwdImmage.mas_bottom).offset((CYScreanH - 64) * 0.05);
         make.height.mas_equalTo((CYScreanH - 64) * 0.08);
     }];
    
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
    [_pwdFPTextField resignFirstResponder];
    [_codeFPTextField resignFirstResponder];
    [_phoneFPTextField resignFirstResponder];
    [_confirmPwdFPTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取验证码
- (void) getFPCodeButton:(UIButton *)sender
{
    //是否是手机号
    if (![CYWhetherPhone isValidPhone:self.phoneFPTextField.text])
    {
        [MBProgressHUD showError:@"手机号格式不正确" ToView:self.view];
        [self dealForgetWithButton];
        return;
    }
    else
    {
        //禁止点击
        _getFPCodeButton.userInteractionEnabled = NO;
        //设置倒计时总时长
        _countDownInput = 60;
        //获取验证码
        [self RequestVerificationCode];
        //开始倒计时
        _downFPTimerInput = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFPFireMethodInput) userInfo:nil repeats:YES];
        //显示倒计时
        [_getFPCodeButton setTitle:[NSString stringWithFormat:@"%ld秒后重发",_countDownInput] forState:UIControlStateNormal];
    }
    
}
//计时器函数
- (void) timeFPFireMethodInput
{
    //倒计时-1
    if (_countDownInput > 0)
    {
        _countDownInput --;
    }
    //修改倒计时标签现实内容
    [_getFPCodeButton setTitle:[NSString stringWithFormat:@"%ld秒后重发",_countDownInput] forState:UIControlStateNormal];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_countDownInput == 0)
    {
        [self dealForgetWithButton];
    }
}
//取消定时器
- (void) dealForgetWithButton
{
    [_downFPTimerInput invalidate];
    [_getFPCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getFPCodeButton.userInteractionEnabled = YES;//时间到之后打开交互
}
//确定
- (void) registeredFPButton:(UIButton *)sender
{
    //是否是手机号
    if ([CYWhetherPhone isValidPhone:self.phoneFPTextField.text])
    {
        [self ModifyPasswordRequest];
    }
    else
    {
        [MBProgressHUD showError:@"手机号格式不正确" ToView:self.view];
    }
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00]];
    
    self.navigationItem.title = @"设置密码";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [self.navigationItem setHidesBackButton:NO];
    [self.navigationController.navigationBar setHidden:NO];
}
//将要消失
- (void) viewWillDisappear:(BOOL)animated
{
    [self dealForgetWithButton];
}
//获取验证码
- (void) RequestVerificationCode
{
    [MBProgressHUD showLoadToView:self.view];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/sendRCode",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]  =  [NSString stringWithFormat:@"%@",self.phoneFPTextField.text];
    NSLog(@"parames = %@",parames);

    [self requestForgetWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"获取验证码请求成功JSON:%@", dict);
        if ([[dict objectForKey:@"success"] integerValue] == 1)
        {
            [MBProgressHUD showError:@"发送成功" ToView:self.view];
        }
        else
        {
            [self dealForgetWithButton];
            [MBProgressHUD showError:@"加载出错" ToView:self.view];
        }
    }];
}
///重置密码
- (void) ModifyPasswordRequest
{
    if ([self.pwdFPTextField.text isEqual:self.confirmPwdFPTextField.text])
    {
        if (![CYWhetherPhone judgePassword:self.pwdFPTextField.text] || (self.pwdFPTextField.text.length < 6 || self.pwdFPTextField.text.length > 12) || (self.confirmPwdFPTextField.text.length < 6 || self.confirmPwdFPTextField.text.length > 12))
        {
            [MBProgressHUD showError:@"密码格式不正确" ToView:self.view];
        }
        else
        {
            [MBProgressHUD showLoadToView:self.view];
            NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/resetPassword",POSTREQUESTURL];
            NSMutableDictionary *parames = [NSMutableDictionary dictionary];
            parames[@"account"]   =  self.phoneFPTextField.text;//
            parames[@"password"]  =  self.pwdFPTextField.text;
            parames[@"code"]      =  self.codeFPTextField.text;
            NSLog(@"parames = %@",parames);
            
            [self requestForgetWithUrl:requestUrl parames:parames Success:^(id responseObject) {
                [MBProgressHUD hideHUDForView:self.view];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"重置密码请求成功JSON:%@", dict);
                if ([[dict objectForKey:@"success"] integerValue] == 1)
                {
                    [MBProgressHUD showError:@"重置密码成功" ToView:self.navigationController.view];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [self dealForgetWithButton];
                    [MBProgressHUD showError:[dict objectForKey:@"error"] ToView:self.view];
                }
            }];
        }
    }
    else
    {
        [MBProgressHUD showError:@"两次密码不相同" ToView:self.view];
    }
}
//数据请求
- (void)requestForgetWithUrl:(NSString *)requestUrl parames:(NSMutableDictionary *)parames Success:(void(^)(id responseObject))success
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

@end
