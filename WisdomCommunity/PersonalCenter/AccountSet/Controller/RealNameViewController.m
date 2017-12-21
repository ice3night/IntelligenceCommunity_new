//
//  RealNameViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "RealNameViewController.h"
#import "ReLogin.h"
@interface RealNameViewController ()

@end

@implementation RealNameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setRNameStyle];
    [self initRNameControllers];
    
    
}
//设置样式
- (void) setRNameStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.typeInt == 2)
    {
        self.navigationItem.title = @"真实姓名";
    }
    else if (self.typeInt == 3)
    {
        self.navigationItem.title = @"身份证号";
    }
    else if (self.typeInt == 5)
    {
        self.navigationItem.title = @"年龄";
    }
    self.view.backgroundColor = CQColor(235,235,235,1);
}
- (void) initRNameControllers
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, CYScreanW, (CYScreanH - 64) * 0.1)];
    bgView.backgroundColor = [UIColor whiteColor];
    //提示
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.02, CYScreanW * 0.25, (CYScreanH - 64) * 0.06)];
    label.font = [UIFont systemFontOfSize:14];
    if (self.typeInt == 2)
    {
        label.text = @"真实姓名";
    }
    else if (self.typeInt == 3)
    {
        label.text = @"身份证号";
    }
    else if (self.typeInt == 5)
    {
        label.text = @"年龄";
    }
    //[NSString stringWithFormat:@"%@",self.promptString];
    label.textColor = [UIColor blackColor];
    [bgView addSubview:label];
    //账号输入框
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake( CYScreanW * 0.30, (CYScreanH - 64) * 0.01, CYScreanW * 0.8, (CYScreanH - 64) * 0.08)];
    _nameTextField.delegate = self;
    _nameTextField.font = [UIFont systemFontOfSize:14];
    if (self.typeInt == 2)
    {
        _nameTextField.placeholder = @"请输入真实姓名";
    }
    else if (self.typeInt == 3)
    {
        _nameTextField.placeholder = @"请输入身份证号";
    }
    else if (self.typeInt == 5)
    {
        _nameTextField.placeholder = @"请输入年龄";
    }
    _nameTextField.textColor = [UIColor grayColor];
    _nameTextField.text = [NSString stringWithFormat:@"%@",[self.beforeString isEqualToString:@"<null>"] ? @"" : self.beforeString];
    _nameTextField.backgroundColor = [UIColor whiteColor];
    _nameTextField.textAlignment = NSTextAlignmentLeft;

    _nameTextField.delegate = self;
    [bgView addSubview:_nameTextField];
    [self.view addSubview:bgView];
        //确定
    UIButton *determineButton =  [[UIButton alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.1+15, CYScreanW * 0.9, (CYScreanH - 64) * 0.08)];
    determineButton.layer.cornerRadius = ((CYScreanH - 64) * 0.08)/2;
    determineButton.layer.masksToBounds = YES;

    [determineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    determineButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    [determineButton setTitle:@"确定" forState:UIControlStateNormal];
    determineButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [determineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [determineButton addTarget:self action:@selector(determineRButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:determineButton];
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
    [_nameTextField resignFirstResponder];
}
//确定按钮
- (void) determineRButtonClick
{
    if (self.typeInt == 2)
    {
        _nameTextField.placeholder = @"请输入真实姓名";
        if (_nameTextField.text.length > 6)
        {
            [MBProgressHUD showError:@"输入过长" ToView:self.view];
        }
        else
        {
            //全中文
            if ([CYSmallTools isChineseFirst:_nameTextField.text]) {
                [self changePersonalInfor:@"trueName"];
            }
            else
                [MBProgressHUD showError:@"输入不合法" ToView:self.view];
        }
    }
    else if (self.typeInt == 3)
    {
        _nameTextField.placeholder = @"请输入身份证号";
        //身份证格式
        if ([CYSmallTools judgeIdentityStringValid:_nameTextField.text]) {
            [self changePersonalInfor:@"idNo"];
        }
        else
            [MBProgressHUD showError:@"身份证格式不正确" ToView:self.view];
    }
    else if (self.typeInt == 5)
    {
        _nameTextField.placeholder = @"请输入年龄";
        if (_nameTextField.text.length > 2)
        {
            [MBProgressHUD showError:@"长度过长" ToView:self.view];
        }
        else
        {
            //纯数字
            if ([CYSmallTools isPureNumandCharacters:_nameTextField.text]) {
                [self changePersonalInfor:@"age"];
            }
            else
                [MBProgressHUD showError:@"只能填写数字" ToView:self.view];
        }
    }
}
//修改个人信息
- (void) changePersonalInfor:(NSString *)key
{
//    isCorrect
    if (self.nameTextField.text.length > 0)
    {
        [MBProgressHUD showLoadToView:self.view];
        NSDictionary *dict = [CYSmallTools getDataKey:PERSONALDATA];
        //数据请求   设置请求管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 拼接请求参数
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
        parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
        parames[@"id"]        =  [dict objectForKey:@"id"];
        parames[key]  =  [NSString stringWithFormat:@"%@",self.nameTextField.text];
        NSLog(@"parames = %@",parames);
        //url
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/updateAccInfo",POSTREQUESTURL];
        NSLog(@"requestUrl = %@",requestUrl);
        [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view];
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
                 [CYSmallTools saveData:JSON withKey:ACCOUNTDATA];//记录账号数据
                 [self.navigationController popViewControllerAnimated:YES];
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
    else
        [MBProgressHUD showError:@"数据不完整" ToView:self.view];
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
