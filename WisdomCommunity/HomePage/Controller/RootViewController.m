 //
//  RootViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "RootViewController.h"
#import "HomeMsgView.h"
#import "Yuyue.h"
#import "PropertyRepairController.h"
#import "MessagePlistViewController.h"
#import "PropertyAuthentication.h"
#import "BiyouxinVc.h"
#import "TakeOutViewController.h"
#import "RenzhengCell.h"
#import "ReLogin.h"
#import "LoginViewController.h"
//#import "tuanViewController.h"
//#import "weishopViewController.h"
@interface RootViewController ()
{
    BOOL ishidden;
}
@property (nonatomic, strong) HomeMsgView *msgView;
@property (nonatomic, copy) NSString *paintUrl;
@property (nonatomic, weak) HomeMiddleCell *middleCell;

@end
@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setRootCStyle];
    [self initMainViews];
    NSUserDefaults * nsuserdefaults = [NSUserDefaults standardUserDefaults];
    NSString * name = [nsuserdefaults objectForKey:@"username"];
    NSString * token = [nsuserdefaults objectForKey: @"token"];
    if (name != nil && token !=nil) {
        
    
    [self GetFirstShowImgs];
    [self getRootActivity];
    }
    else{
        LoginViewController * login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }
}
- (void) viewWillAppear:(BOOL)animated
{
    ishidden = YES;
    NSDictionary *getDict = [[NSDictionary alloc] init];
    if ([[CYSmallTools getDataKey:COMDATA] isEqual:[NSNull null]]) {
        ishidden = NO;
    }else{
        getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];

        NSString *comNo = [NSString stringWithFormat:@"%@",[getDict objectForKey:@"comNo"]];
        if (comNo) {
            NSLog(@"第二层隐藏");
            self.middleCell.renzhengView.hidden = YES;
        }else{
            NSLog(@"第二层不隐藏");
            self.middleCell.renzhengView.hidden = NO;

        }
    }
    [self.RootSTableView reloadData];
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController.navigationBar setHidden:YES];
    //切换数据
    [self.communityButton setTitle:[NSString stringWithFormat:@"%@ %@",[getDict objectForKey:@"city"],[getDict objectForKey:@"comName"]] forState:UIControlStateNormal];
    //签到
//    if ([[CYSmallTools getDataStringKey:WHETHERSIGNIN] integerValue] == 1)//未签到
//    {
//        self.signInBtn.selected = NO;
//    }
//    else
//    {
//        self.whetherSignIn = YES;//说明已签到
//        if (self.signInBtn.selected == NO)
//        {
//            self.signInBtn.selected = YES;
//        }
//    }
}
//首页样式
- (void) setRootCStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //背景
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.02, CYScreanW, (CYScreanH - 64) * 0.15)];
    image.image = [UIImage imageNamed:@"pic_pull_down"];
    [self.view addSubview:image];
    
//#warning 小区移动到我的页面了
    //小区
//    self.communityButton = [[UIButton alloc] initWithFrame:CGRectMake( CYScreanW * 0.2, 20, CYScreanW * 0.6, 44)];
//    [self.communityButton setImage:[UIImage imageNamed:@"nav_area"] forState:UIControlStateNormal];
//    [self.communityButton setTitle:[NSString stringWithFormat:@"%@ %@",[getDict objectForKey:@"city"],[getDict objectForKey:@"comName"]] forState:UIControlStateNormal];
//    [self.communityButton setTitleColor:ShallowGrayColor forState:UIControlStateNormal];
//    self.communityButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
//    self.communityButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
//    self.communityButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
//    [self.communityButton addTarget:self action:@selector(SelectCommunity:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.titleView = self.communityButton;
    
//#warning 签到移动到我的页面了
    //签到
//    self.signInBtn = [[CYEmitterButton alloc] initWithFrame:CGRectMake(0, 0, 25, 30)];
//    [self.signInBtn addTarget:self action:@selector(SignIn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.signInBtn setImage:[UIImage imageNamed:@"icon_nav_sign"] forState:UIControlStateNormal];
//    [self.signInBtn setImage:[UIImage imageNamed:@"icon_nav_sign_done"] forState:UIControlStateSelected];
//    self.signInBtn.selected = NO;
//    UIBarButtonItem *buttonRight2 = [[UIBarButtonItem alloc] initWithCustomView:self.signInBtn];
//    self.navigationItem.rightBarButtonItems = @[buttonRight1,buttonRight2];
    
    //标记：没有进入帖子详情页，防止从帖子详情页直接退出APP导致记录出错
    [CYSmallTools saveDataString:nil withKey:@"InputPostDetailsView"];
    //将本次登录账号保存
//    NSMutableArray *accountArray = [NSMutableArray arrayWithArray:[CYSmallTools getArrData:ACCOUNTARRAY]];
//    //如果不存在
//    if (![accountArray containsObject:[CYSmallTools getDataStringKey:ACCOUNT]]) {
//        [accountArray addObject:[NSString stringWithFormat:@"%@",[CYSmallTools getDataStringKey:ACCOUNT]]];
//        [CYSmallTools saveArrData:accountArray withKey:ACCOUNTARRAY];
//    };
}
//选择小区
- (void) SelectCommunity:(UIButton *)sender
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    MyCommunityListViewController *MCLontroller = [[MyCommunityListViewController alloc] init];
    [self.navigationController pushViewController:MCLontroller animated:YES];
}
//消息列表
- (void) MessageList:(UIButton *)sender
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    MessagePlistViewController *messageController = [[MessagePlistViewController alloc] init];
    [self.navigationController pushViewController:messageController animated:YES];
}
//签到
//- (void) SignIn:(UIButton *)sender
//{
//    if (self.whetherSignIn == NO)
//    {
//        [self ownerSignInRequest:@"doSign"];
//    }
//}
//初始化首页控件
- (void)initMainViews
{
    self.view.backgroundColor = CQColorFromRGB(0xf3f6fe);
    //显示
    self.RootSTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, -20, CYScreanW, CYScreanH)];
    self.RootSTableView.delegate = self;
    self.RootSTableView.dataSource = self;
    self.RootSTableView.showsVerticalScrollIndicator = NO;
    self.RootSTableView.separatorStyle = 0;
    self.RootSTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.RootSTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.RootSTableView registerNib:[UINib nibWithNibName:@"HomeFuctionCell" bundle:nil]  forCellReuseIdentifier:@"HomeFuctionCell"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//section底部间距
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (ishidden) {
    if (indexPath.section == 0)
    {
        return (CYScreanH - 64) * 0.3;
    }
    else if (indexPath.section == 1)
    {
        return (CYScreanH - 64) * 0.14;
    }else if(indexPath.section == 3)
    {
        return (CYScreanH - 64) * 0.20;
    }
    else if(indexPath.section == 4)
    {
        return (CYScreanH - 64) * 0.18;
    }else if(indexPath.section == 6)
    {
        return (CYScreanH - 64) * 0.25;
    }
    else if(indexPath.section == 5)
    {
        return (CYScreanH - 64) * 0.25;
    }
    else
    {
        return (CYScreanH - 64) * 0.2;
    }
    }else{
        if (indexPath.section == 0)
        {
            return (CYScreanH - 64) * 0.3;
        }
        else if (indexPath.section == 1)
        {
            return (CYScreanH - 64) * 0.14;
        }else if(indexPath.section == 3)
        {
            return (CYScreanH - 64) * 0.15;
        }
        else if(indexPath.section == 4)
        {
            return (CYScreanH - 64) * 0.20;
        }else if(indexPath.section == 6)
        {
            return (CYScreanH - 64) * 0.25;
        }
        else if(indexPath.section == 5)
        {
            return (CYScreanH - 64) * 0.18;
        }
        else
        {
            return (CYScreanH - 64) * 0.2;
        }
    }
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (ishidden) {
        return 6;
    }else{
    return 7;
    }
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        HomeTopCell *cell = [HomeTopCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        cell.delegate = self;
        return cell;
    }else
    {
        static NSString *ID = @"cellSectionOneId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0)
        {
            //    广告展示
            if (self.ShufflingFigureView == nil && self.ShowImagesDict)
            {
                self.ShufflingFigureView = [[JXBAdPageView alloc] init];
                self.ShufflingFigureView.frame = CGRectMake( 0, 0, CYScreanW, (CYScreanH - 64) * 0.3);
                self.ShufflingFigureView.bWebImage = YES;//网络图片
                self.ShufflingFigureView.iDisplayTime = 4;//停留时间
                self.ShufflingFigureView.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:self.ShufflingFigureView];
                NSArray *imageArray = [NSArray arrayWithObjects:[self.ShowImagesDict objectForKey:@"carouselUrl1"],[self.ShowImagesDict objectForKey:@"carouselUrl2"],[self.ShowImagesDict objectForKey:@"carouselUrl3"],[self.ShowImagesDict objectForKey:@"carouselUrl4"], nil];
                [self.ShufflingFigureView startAdsWithBlock:imageArray block:^(NSInteger clickIndex)
                 {
                     NSLog(@"第%ld张",(long)clickIndex);
                 }];
            }
        }else if (indexPath.section == 1)
        {
            if (self.msgView == nil)
            {
                self.msgView = [[HomeMsgView alloc] initWithFrame:CGRectMake(0, 0, CYScreanW, (CYScreanH - 64) * 0.14)];
                self.msgView.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:self.msgView];
            }
        }
        else if (indexPath.section == 3)
        {
            if (ishidden) {
                if(_middleCell) {
                    
                }else{
                    _middleCell = [HomeMiddleCell cellWithTableView:tableView];
                    _middleCell.selectionStyle = UITableViewCellAccessoryNone;
                    _middleCell.delegate = self;
                    //                _middleCell.renzhengView.hidden = YES;
                }
                return _middleCell;
            }else{
            RenzhengCell *renzhengCell = [RenzhengCell cellWithTableView:tableView];
            renzhengCell.selectionStyle = UITableViewCellAccessoryNone;
//            _middleCell.delegate = self;
//                _middleCell.renzhengView.hidden = YES;
            return renzhengCell;
            }
        }
        else if (indexPath.section == 4)
        {
            if (ishidden) {
                HomeShopCell *cell = [HomeShopCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellAccessoryNone;
                cell.delegate = self;
                return cell;
            }else{
            if(_middleCell) {
                HomeShopCell *cell = [HomeShopCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellAccessoryNone;
                cell.delegate = self;
                return cell;
            }else{
                _middleCell = [HomeMiddleCell cellWithTableView:tableView];
                _middleCell.selectionStyle = UITableViewCellAccessoryNone;
                _middleCell.delegate = self;
                //                _middleCell.renzhengView.hidden = YES;
            }
            return _middleCell;
            }
        }
        else if (indexPath.section == 5)
        {
            if (ishidden) {
                HomeActivityCell *cell = [HomeActivityCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellAccessoryNone;
                cell.url = _paintUrl;
                cell.delegate = self;
                return cell;
            }else{
            HomeShopCell *cell = [HomeShopCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            cell.delegate = self;
            return cell;
            }
        }else if (indexPath.section == 6)
        {
            HomeActivityCell *cell = [HomeActivityCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            cell.url = @"http://orrvwi9v2.bkt.clouddn.com/intelCommunity/uploadImg/image/1509603417861.jpg";
            cell.delegate = self;
            return cell;
        }
        return cell;
    }
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    if (indexPath.section == 1)
    {
            MessagePlistViewController *ADController = [[MessagePlistViewController alloc] init];
//            ADController.ActivityIDmodel = self.activityModel.activityID;
            [self.navigationController pushViewController:ADController animated:YES];
        }
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 按钮代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//物业管家
- (void) propertyHousekeeper
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    PropertyViewController *PController = [[PropertyViewController alloc] init];
    [self.navigationController pushViewController:PController animated:YES];
}
//社区商城
- (void) communityMall
{
    NSURL *URL = [NSURL URLWithString:@"longjinguapp://"];//上面的配置就是在这里用，提供一个标识；longjinguapp
    //先判断是否能打开该url
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        //打开url
        [[UIApplication sharedApplication] openURL:URL];
    } else {
        //初始化提示框；
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示"
                                                      message:@"本机未安装智能家居APP,请安装后使用!" delegate:nil
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil, nil];
        [alert show];
    }
//    //切换标签页
//    UIView *fromView = [self.tabBarController.selectedViewController view];
//    UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:1] view];
//    [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionNone completion:^(BOOL finished) {
//        if (finished)
//        {
//            [self.tabBarController setSelectedIndex:1];
//        }
//    }];
}
//物业报修
- (void) propertyService
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    PropertyRepairViewController *PRController = [[PropertyRepairViewController alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
//社区公告
- (void) communityPAnnouncement
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    ComAnnouncementViewController *CAController = [[ComAnnouncementViewController alloc] init];
    [self.navigationController pushViewController:CAController animated:YES];
    
}
//投诉建议
- (void) complaintsSuggestions
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    ComplaintsSuggestionsViewController *suggesController = [[ComplaintsSuggestionsViewController alloc] init];
    [self.navigationController pushViewController:suggesController animated:YES];
}
//社区大小事
- (void) CommunityActiveBBS
{
    //切换标签页
    UIView *fromView = [self.tabBarController.selectedViewController view];
    UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:2] view];
    [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionNone completion:^(BOOL finished) {
        if (finished)
        {
            [self.tabBarController setSelectedIndex:2];
        }
    }];
}

//  - - - - -- - - -- - - - - - -- - - - - - - - -- - - - -- - - - - -- - - -- - - -- - - - - -
//业主签到请求
//- (void) ownerSignInRequest:(NSString *)state
//{
//    //数据请求   设置请求管理者
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    // 拼接请求参数
//    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
//    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
//    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
//    NSLog(@"parames = %@",parames);
//    //url
//    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/%@",POSTREQUESTURL,[state isEqualToString:@"doSign"] ? @"doSign" : @"checkTodaySign"];
//    NSLog(@"requestUrl = %@",requestUrl);
//    [CYRequestData postWithURLString:requestUrl parameters:parames success:^(id responseObject) {
//        [MBProgressHUD hideHUDForView:self.view];
//        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"是否/签到请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
//        if ([[JSON objectForKey:@"success"] integerValue] == 1)
//        {
//            if ([state isEqualToString:@"doSign"])//签到
//            {
//                self.signInBtn.selected = YES;
////                self.signInBtn.userInteractionEnabled = NO;
//                [self ownerSignInRequest:@"checkTodaySign"];
//                NSLog(@"签到");
//            }
//            else//查看签到记录
//            {
//                NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[JSON objectForKey:@"param"]];
//                NSLog(@"是否已签到");
//                [CYSmallTools saveDataString:[dict objectForKey:@"canSign"] withKey:WHETHERSIGNIN];
//                [CYSmallTools saveDataString:[dict objectForKey:@"score"] withKey:CURRENTINTEGRAL];
//                if ([[dict objectForKey:@"canSign"] integerValue] == 1)
//                {
////                    self.signInBtn.userInteractionEnabled = YES;
//                }
//                else
//                {
//                    self.whetherSignIn = YES;//表示已签到
////                    self.signInBtn.userInteractionEnabled = NO;
//                    self.signInBtn.selected = YES;
//                }
//            }
//        }
//        else
//        {
//            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.navigationController.view];
//            NSString *type = [JSON objectForKey:@"type"];
//            if ([type isEqualToString:@"1"]||[type isEqual:@"2"]) {
//                ReLogin *relogin = [[ReLogin alloc] init];
//                [self.navigationController presentViewController:relogin animated:YES completion:^{
//
//                }];
//            }
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUDForView:self.view];
//        [MBProgressHUD showError:@"加载出错" ToView:self.view];
//        NSLog(@"请求失败:%@", error.description);
//    }];
//}
//获取轮播图等图片
- (void) GetFirstShowImgs
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/activity/appFirstShowImgs",POSTREQUESTURL];
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"userdefaults= %@",userdefaults);
    NSString * name = [userdefaults objectForKey:@"username"];
    NSString * token = [userdefaults objectForKey:@"token"];
    if (![name isKindOfClass:[NSNull class]]) {
        name =[userdefaults objectForKey:@"username"];
    }
    if (![token isKindOfClass:[NSNull class]]) {
        token =[userdefaults objectForKey:@"token"];
    }
    NSLog(@"%@,%@",name,token);
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    //[parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
//    NSString * asd =[CYSmallTools getDataStringKey:ACCOUNT];
//    NSString * aad =[CYSmallTools getDataStringKey:TOKEN];
//    NSLog(@"%@,    %@",asd,aad);
    [parames setObject:name forKey:@"account"];
    [parames setObject:token forKey:@"token"];
    //[parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    NSLog(@"parames = %@",parames);
    // 拼接请求参数
    NSLog(@"requestUrl = %@",requestUrl);
    [CYRequestData postWithURLString:requestUrl parameters:parames success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON = %@,error = %@",JSON,[JSON objectForKey:@"error"]);
        
        if ([[JSON objectForKey:@"success"] integerValue] == 1  && ([JSON objectForKey:@"returnValue"] != [NSNull null]))
        {
            self.ShowImagesDict = [JSON objectForKey:@"returnValue"];
            _paintUrl = [_ShowImagesDict objectForKey:@"paintingUrl"];
            NSLog(@"获得的%@",_paintUrl);
            //刷新
//            NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:0];
//            NSIndexSet *indexSet2=[[NSIndexSet alloc] initWithIndex:2];
//            [self.RootSTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.RootSTableView reloadData];
        }
        else{
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"加载出错" ToView:self.view];
        NSLog(@"请求失败:%@", error.description);
    }];
}
//活动
- (void) getRootActivity
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/activity/appFirstShowActivity",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
//    [parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
//    [parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    NSString * name = [userdefaults objectForKey:@"username" ];
    NSString * token = [userdefaults objectForKey:@"token"];
    if (![name isKindOfClass:[NSNull class]]) {
        name =[userdefaults objectForKey:@"username"];
    }
    if (![token isKindOfClass:[NSNull class]]) {
        token =[userdefaults objectForKey:@"token"];
    }
    [parames setObject:name forKey:@"account"];
    [parames setObject:token forKey:@"token"];
    NSLog(@"parames = %@",parames);
    // 拼接请求参数
    NSLog(@"requestUrl = %@",requestUrl);
    [CYRequestData postWithURLString:requestUrl parameters:parames success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"活动请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
        if ([[JSON objectForKey:@"success"] integerValue] == 1 && ([JSON objectForKey:@"returnValue"] != [NSNull null]))
        {
            NSString *imgAddress = [NSString stringWithFormat:@"%@",[[JSON objectForKey:@"returnValue"] valueForKey:@"imgAddress"]];
            self.imgAddressArray = [imgAddress componentsSeparatedByString:@","];
            //刷新
            NSMutableDictionary *dict = [JSON objectForKey:@"returnValue"];
            self.activityModel = [ActivityRootModel bodyWithDict:dict];
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
            [self.RootSTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else{
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
            LoginViewController * relog = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:relog animated:YES];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"加载出错" ToView:self.view];
        NSLog(@"请求失败:%@", error.description);
    }];
}

- (void)goToIntelligent {
    [MBProgressHUD showError:@"苹果系统只能家居模块，正在努力开发中，敬请期待！" ToView:self.view];
}
- (void) goToRepair
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    PropertyRepairController *PRController = [[PropertyRepairController alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
- (void)goToComplaint
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    PropertyComplaint *PRController = [[PropertyComplaint alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
- (void)goToShangcheng {
    self.tabBarController.selectedIndex = 1;
}
-(void)gotoRenzheng
{
    PropertyAuthentication *authentication = [[PropertyAuthentication alloc] init];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    [self.navigationController pushViewController:authentication animated:YES];
}
- (void)gotoYuyue
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    Yuyue *PRController = [[Yuyue alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
-(void)gotoTiandan
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    FillForm *PRController = [[FillForm alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
-(void)goToJianshen
{
      [MBProgressHUD showError:@"敬请期待！" ToView:self.view];
//    tuanViewController * tuangou = [[tuanViewController alloc]init];
//    [self.navigationController pushViewController:tuangou animated:YES];
    
    
}
-(void)goToBiyouxin
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    BiyouxinVc *PRController = [[BiyouxinVc alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
-(void)shopCellGotoShangCheng{
    [MBProgressHUD showError:@"敬请期待！" ToView:self.view];
}
-(void)shopCellGotoRunCaiYuan
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    TakeOutViewController *TOController = [[TakeOutViewController alloc] init];
    TOController.ChooseClassificationString = [NSString stringWithFormat:@"%@",@"润菜园"];
    TOController.LabelCategoryId = @"05";
    [self.navigationController pushViewController:TOController animated:YES];
}
-(void)shopActivityAction
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    CZExhibitionViewController *exhibitionViewController = [[CZExhibitionViewController alloc] init];
    
    [self.navigationController pushViewController:exhibitionViewController animated:YES];
}
@end
