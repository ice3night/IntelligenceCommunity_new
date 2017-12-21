//
//  LoginViewController.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/25.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ReLogin.h"
#import "PropertyAuthentication.h"
#import <ShareSDK/ShareSDK.h>
#import "BindViewController.h"
#import "JPUSHService.h"
#import "ForgetPwdViewController.h"
#import "RegisteredViewController.h"
#import "WXApi.h"
@interface ReLogin ()
@property (weak, nonatomic) IBOutlet UITextField *psdTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UIView *psdView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;

@end

@implementation ReLogin

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
}
- (void)initView
{
    if(![WXApi isWXAppInstalled]){
        self.wxBtn.hidden = YES;
    }
    self.psdTextField.secureTextEntry = YES;
    self.accountView.layer.borderWidth = 0.5;
    self.accountView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.psdView.layer.borderWidth = 0.5;
    self.psdView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _loginBtn.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_forgetBtn.titleLabel.text];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [_forgetBtn setAttributedTitle:str forState:UIControlStateNormal];
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:_registerBtn.titleLabel.text];
    NSRange strRange2 = {6,5};
    [str2 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange2];
    [_registerBtn setAttributedTitle:str2 forState:UIControlStateNormal];
}
-(void)viewWillLayoutSubviews
{
    _loginBtn.layer.cornerRadius = _loginBtn.bounds.size.height/2;
    _loginBtn.layer.masksToBounds = YES;
}
- (IBAction)login:(id)sender {
    if (!(self.accountTextField.text.length && self.psdTextField.text.length))
    {
        [MBProgressHUD showError:@"信息不完整" ToView:self.view];
        return;
    }
    if (![CYWhetherPhone isValidPhone:self.accountTextField.text])
    {
        [MBProgressHUD showError:@"手机号格式不正确" ToView:self.view];
        return;
    }
    //放弃第一响应身份
    [_psdTextField resignFirstResponder];
    [_accountTextField resignFirstResponder];
    //进度条
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]  =  [NSString stringWithFormat:@"%@",self.accountTextField.text];//
    parames[@"password"]  =  [NSString stringWithFormat:@"%@",self.psdTextField.text];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/doLogin",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"登录请求成功JSON:%@", JSON);
         
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             //处理数据
             [self saveLoginData:JSON];
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
- (void) saveLoginData:(NSDictionary *)JSON
{
    
    [CYSmallTools saveData:nil withKey:ACCOUNTDATA];//清空修改资料后保存的个人数据,只有修改个人资料并且未再次登录才会使用“ACCOUNTDATA”中的数据
    [CYSmallTools saveData:[[JSON objectForKey:@"param"] objectForKey:@"user"] withKey:PERSONALDATA];//保存登录获取的个人数据
    [CYSmallTools saveData:[[[JSON objectForKey:@"param"] objectForKey:@"user"] objectForKey:@"communityDO"] withKey:COMDATA];//保存绑定的小区账号
    if(![[[[JSON objectForKey:@"param"] objectForKey:@"user"] objectForKey:@"communityDO"] isEqual:[NSNull null]]){
        if (![[[[[JSON objectForKey:@"param"] objectForKey:@"user"] objectForKey:@"communityDO"]
               objectForKey:@"id"] isEqual:[NSNull null]]) {
            [CYSmallTools saveData:[[[[JSON objectForKey:@"param"] objectForKey:@"user"] objectForKey:@"communityDO"] objectForKey:@"id"] withKey:@"comNo"];
        }
    }
    [CYSmallTools saveData:[[[JSON objectForKey:@"param"] objectForKey:@"user"] objectForKey:@"imgAddress"] withKey:@"imgAddress"];
    
    [CYSmallTools saveData:[[[JSON objectForKey:@"param"] objectForKey:@"user"] objectForKey:@"nickName"] withKey:@"nickname"];
    NSString *communityDo = [NSString stringWithFormat:@"%@",[[[JSON objectForKey:@"param"] objectForKey:@"user"] objectForKey:@"communityDO"]];
    if (![communityDo isEqualToString:@"<null>"])
    {
        [CYSmallTools saveDataString:[[[[JSON objectForKey:@"param"] objectForKey:@"user"] objectForKey:@"communityDO"] objectForKey:@"comTel"] withKey:PROPERTYCPHONE];//物业投诉电话
    }
    [CYSmallTools saveDataString:[[[JSON objectForKey:@"param"] objectForKey:@"user"]objectForKey:@"trueName"] withKey:@"trueName"];
    NSString *tokenString = [[[JSON objectForKey:@"param"] objectForKey:@"user"] objectForKey:@"token"];
    NSString *accoutString = [[[JSON objectForKey:@"param"] objectForKey:@"user"] objectForKey:@"account"];
    NSLog(@"tokenString = %@",tokenString);
    [CYSmallTools saveDataString:tokenString withKey:TOKEN];
    [CYSmallTools saveDataString:accoutString withKey:ACCOUNT];
    //推送
    [self jushWithAccount:accoutString];
    //跳转
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//设置设备别名
- (void) jushWithAccount:(NSString *)account
{
    [JPUSHService setTags:nil alias:account fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"设置结果:%i 用户别名:%@",iResCode,account);
    }];
    // 这是极光提供的方法，USER_INFO.userID是用户的id，你可以根据账号或者其他来设置，只要保证唯一便可
    // 不要忘了在登出之后将别名置空
    [JPUSHService setTags:nil alias:@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"设置结果:%i 用户别名:%@",iResCode,account);
    }];
    //注销通知
}
//跳转页面
- (void) jumpController
{
    NSString *stringT = [NSString stringWithFormat:@"%@",[CYSmallTools getDataKey:COMDATA]];
    if (stringT.length > 6)//绑定房屋
    {
        //创建标签控制器
        UITabBarController *tabbarController = [[UITabBarController alloc] init];
        NSArray *arryaVC = @[@"RootViewController",@"NewMallViewController",@"HWScanViewController",@"CommunityABBSViewController",@"PersonalCenter"];
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
            else if([str isEqualToString:@"PersonalCenter"])
            {
                navigation.tabBarItem.title = @"我的";
                navigation.tabBarItem.image = [UIImage imageNamed:@"tab_me_default.png"];
                //未标题-1_32
                navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_me_selected"];
            }
        }
        tabbarController.viewControllers = arrayNav;
        //点击之后字体颜色
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.302 green:0.545 blue:0.914 alpha:1.00],UITextAttributeTextColor,nil] forState:UIControlStateSelected];
        tabbarController.tabBar.selectedImageTintColor = [UIColor colorWithRed:0.302 green:0.545 blue:0.914 alpha:1.00];
        self.view.window.rootViewController = tabbarController;
    }
    else
    {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backItem];
        PropertyAuthentication *HCController = [[PropertyAuthentication alloc] init];
        [self.navigationController pushViewController:HCController animated:YES];
    }
}
- (IBAction)forget:(id)sender {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    ForgetPwdViewController *FController = [[ForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:FController animated:YES];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
}
- (IBAction)registerAction:(id)sender {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backItem];
        RegisteredViewController *RController = [[RegisteredViewController alloc] init];
        [self.navigationController pushViewController:RController animated:YES];
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
- (IBAction)wxAction:(id)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.icon);
             NSLog(@"一开始昵称%@，id%@，touxiang%@",user.nickname,user.uid,user.icon);
             
             [self vxLoginWithUserId:user.uid nickName:user.nickname iconUrl:user.icon];
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}
-(void)vxLoginWithUserId:(NSString *)userid nickName:(NSString *)nickName iconUrl:(NSString *)iconUrl
{
    NSLog(@"请求之前昵称%@，id%@，touxiang%@",userid,nickName,iconUrl);
    
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"weChatId"]  =  userid;//
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/weChatLogin",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSLog(@"返回数据%@",responseObject);
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"登录请求成功JSON:%@", JSON);
         NSString *msg = [JSON objectForKey:@"msg"];
         
         if ([msg isEqualToString:@"0"])
         {
             UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
             [self.navigationItem setBackBarButtonItem:backItem];
             BindViewController *bindVc = [[BindViewController alloc] init];
             bindVc.nickName = nickName;
             bindVc.iconUrl = iconUrl;
             bindVc.userid = userid;
             [self.navigationController pushViewController:bindVc animated:YES];
         }
         else{
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
                 //处理数据
                 [self saveLoginData:JSON];
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
}
@end
