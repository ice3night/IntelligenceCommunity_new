//
//  MyComplaintsViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MyComplaintsViewController.h"
#import "ComplaintCell.h"
#import "ComplaintCellFrame.h"
#import "ComplaintModel.h"
#import "MJExtension.h"
#import "ReLogin.h"
@interface MyComplaintsViewController ()

@end

@implementation MyComplaintsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMyComplaintsStyle];
    [self initMyComplaintsControls];
    
    
    
}
- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"我的投诉";
    self.view.backgroundColor = CQColor(246,243,254, 1);
    self.MyCompTableView.backgroundColor = CQColor(246,243,254, 1);
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
    //投诉列表
    [self getMyComplaints];
}
//设置样式
- (void) setMyComplaintsStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的投诉";

    
    //数据源
    self.dataAllMCArray = [[NSMutableArray alloc] init];
    self.dataModelMCArray = [[NSMutableArray alloc] init];
    self.dataHeightMCArray = [[NSMutableArray alloc] init];
    self.currentCPage = 1;
}
////初始化数据
//- (void) initMyComplaintsModel:(NSArray *)array
//{
//    for (NSInteger i = array.count - 1; i >= 0; i --)
//    {
//        NSDictionary *complaintsDict = array[i];
//        NSString *time = [CYSmallTools timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",[complaintsDict objectForKey:@"callTime"]]];
//
//        NSString *stateString = [NSString stringWithFormat:@"%@",[complaintsDict objectForKey:@"status"]];
//        NSString *contentString = [NSString stringWithFormat:@"%@",[complaintsDict objectForKey:@"reason"]];
//        if ([stateString isEqualToString:@"1"])
//        {
//            stateString = @"投诉状态:处理中";
//        }
//        else if ([stateString isEqualToString:@"2"])
//        {
//            stateString = @"投诉状态:已处理";
//        }
//        else if ([stateString isEqualToString:@"3"])
//        {
//            stateString = @"投诉状态:拒绝处理";
//        }
//
//        else
//        {
//            stateString = @"投诉状态:等待处理";
//        }
//
//        NSDictionary *dict = @{
//                               @"promptImageString":@"icon_community_notice",
//                               @"timeString":[NSString stringWithFormat:@"物业办事处 %@",time],
//                               @"promptString":[NSString stringWithFormat:@"%@",contentString],
//                               @"resultString":[NSString stringWithFormat:@"%@",stateString],
//                               };
//        [self.dataAllMCArray addObject:dict];
//        com *model = [MyComplaintsModel bodyWithDict:dict];
//        ComplaintCellFrame *cellFrame = [[ComplaintCellFrame alloc] init];
//        cellFrame.complaintModel = model;
//        [self.dataModelMPArray addObject:cellFrame];
//        [self.dataModelMCArray addObject:model];
//
//        //内容高度
//        CGSize sizeP = CGSizeMake(CYScreanW * 0.8, CGFLOAT_MAX);
//        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:contentString.length > 0 ? contentString : @"未获取"]];
//        [self.dataHeightMCArray addObject:[NSString stringWithFormat:@"%.f",layout.textBoundingSize.height]];
//    }
//    //刷新
//    [self.MyCompTableView reloadData];
//}
//初始化首页控件
- (void) initMyComplaintsControls
{
    //显示
    self.MyCompTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH - 64)];
    self.MyCompTableView.delegate = self;
    self.MyCompTableView.dataSource = self;
    self.MyCompTableView.showsVerticalScrollIndicator = NO;
    self.MyCompTableView.backgroundColor = [UIColor whiteColor];
    self.MyCompTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.MyCompTableView];
    
    NSArray *array = [NSArray arrayWithArray:[CYSmallTools getArrData:LOADANIMATION]];
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerMyComRefresh)];
    //设置正在刷新状态的动画图片
    [header setImages:array forState:MJRefreshStateRefreshing];
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    header.stateLabel.hidden = YES;
    self.MyCompTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerMyComRefresh)];
    // 设置正在刷新状态的动画图片
    [footer setImages:array forState:MJRefreshStateRefreshing];
    footer.stateLabel.hidden = YES;
    // 设置尾部
    self.MyCompTableView.mj_footer = footer;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //提示模块
    UIImageView *PromptImageView = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.2, (CYScreanH - 64) * 0.25, CYScreanW * 0.6, (CYScreanH - 64) * 0.3)];
    PromptImageView.image = [UIImage imageNamed:@"missing_content_01"];
    [self.view addSubview:PromptImageView];
    PromptImageView.hidden = YES;
    self.MyComplaintsImage = PromptImageView;
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//下拉刷新
-(void) headerMyComRefresh
{
    //结束下拉刷新
    [self.MyCompTableView.mj_header endRefreshing];
}
//上拉刷新根据不同的排序调用不同的方法
- (void) footerMyComRefresh
{
    NSLog(@"self.currentPage = %ld",self.currentCPage);
    self.currentCPage += 1;
 
    
    [self getMyComplaints];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataModelMCArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ComplaintCell";
    self.complaintCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.complaintCell == nil)
    {
        self.complaintCell = [[ComplaintCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    self.complaintCell.complaintCellFrame = self.dataModelMCArray[indexPath.row];
    self.complaintCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return self.complaintCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComplaintCellFrame *frame = self.dataModelMCArray[indexPath.row];
    return frame.cellHeight;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void) getMyComplaints
{
    //第一次加载数据
    if (self.currentCPage == 1)
    {
        [MBProgressHUD showLoadToView:self.view];
    }
    self.MyComplaintsImage.hidden = YES;//默认隐藏
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"pageSize"]    =  @"15";//
    parames[@"currentPage"] =  [NSString stringWithFormat:@"%ld",self.currentCPage];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/complainList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (self.currentCPage == 1)
         {
             [MBProgressHUD hideHUDForView:self.view];
         }
         // 结束上拉刷新
         [self.MyCompTableView.mj_footer endRefreshing];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSArray *array = [[NSArray alloc] init];
             array = [ComplaintModel objectArrayWithKeyValuesArray:[JSON objectForKey:@"returnValue"]];
             if (array.count)
             {
                 for (int i = 0; i < array.count; i++) {
                     ComplaintModel *model = array[i];
                     ComplaintCellFrame *cellFrame = [[ComplaintCellFrame alloc] init];
                     cellFrame.complaintModel = model;
                     [self.dataModelMCArray addObject:cellFrame];
                     [self.MyCompTableView reloadData];
                 }
             }
             else
             {
                 if (!self.dataModelMCArray.count) {
                     self.MyComplaintsImage.hidden = NO;
                 }
                 [MBProgressHUD showError:@"没有数据了" ToView:self.view];
                 self.currentCPage -= 1;
             }
             NSLog(@"报修列表请求成功");
         }
         else
         {
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
            self.currentCPage -= 1;
             NSString *type = [JSON objectForKey:@"type"];
             if ([type isEqualToString:@"1"]||[type isEqual:@"2"]) {
                 ReLogin *relogin = [[ReLogin alloc] init];
                 [self.navigationController presentViewController:relogin animated:YES completion:^{
                     
                 }];
             }
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         if (!self.dataModelMCArray.count) {
             self.MyComplaintsImage.hidden = NO;
         }
         if (self.currentCPage == 1)
         {
             [MBProgressHUD hideHUDForView:self.view];
             [MBProgressHUD showError:@"加载出错" ToView:self.view];
         }
         // 结束上拉刷新
         [self.MyCompTableView.mj_footer endRefreshing];
         self.currentCPage -= 1;
         NSLog(@"报修列表请求失败:%@", error.description);
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
