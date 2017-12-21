//
//  MyRepairViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MyRepairViewController.h"
#import "MyComplaintsModel.h"
#import "ComplaintCellFrame.h"
#import "ComplaintCell.h"
#import "MJExtension.h"
#import "ReLogin.h"
@interface MyRepairViewController ()

@end

@implementation MyRepairViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMyComplaintsStyle];
    [self initMyComplaintsControls];
    
    
    
}
- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"我的报修";
    self.view.backgroundColor = CQColor(246,243,254, 1);
    self.MyRepairTableView.backgroundColor = CQColor(246,243,254, 1);
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
    //获取报修列表
    [self getMyRepair];
}
//设置样式
- (void) setMyComplaintsStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的报修";
    
    //标签
    self.currentRePage = 1;
    //数据源
    self.dataAllMRArray = [[NSMutableArray alloc] init];
    self.dataModelMRArray = [[NSMutableArray alloc] init];
    self.dataHeightMCArray = [[NSMutableArray alloc] init];
}
//初始化数据
- (void) initMyComplaintsModel:(NSArray *)array
{
   
    for (NSInteger i = array.count - 1; i >= 0; i --)
    {
        NSDictionary *complaintsDict = array[i];
        NSString *time = [CYSmallTools timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",[complaintsDict objectForKey:@"callTime"]]];
        NSString *stateString = [NSString stringWithFormat:@"%@",[complaintsDict objectForKey:@"status"]];
        NSString *contentString = [NSString stringWithFormat:@"%@",[complaintsDict objectForKey:@"reason"]];
        if ([stateString isEqualToString:@"1"])
        {
            stateString = @"报修状态:处理中";
        }
        else if ([stateString isEqualToString:@"2"])
        {
            stateString = @"报修状态:已处理";
        }
        else if ([stateString isEqualToString:@"3"])
        {
            stateString = @"报修状态:拒绝处理";
        }
        else
        {
            stateString = @"报修状态:等待处理";
        }
        NSDictionary *dict = @{
                               @"promptImageString":@"icon_community_notice",
                               @"timeString":[NSString stringWithFormat:@"物业办事处 %@",time],
                               @"promptString":[NSString stringWithFormat:@"%@",contentString],
                               @"resultString":stateString,
                               };
        [self.dataAllMRArray addObject:dict];
        MyComplaintsModel *model = [MyComplaintsModel bodyWithDict:dict];
        [self.dataModelMRArray addObject:model];
        
        CGSize sizeP = CGSizeMake(CYScreanW * 0.8, CGFLOAT_MAX);
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:contentString.length > 0 ? contentString : @"未获取"]];
        [self.dataHeightMCArray addObject:[NSString stringWithFormat:@"%.f",layout.textBoundingSize.height]];
    }
    //刷新
    [self.MyRepairTableView reloadData];
}
//初始化首页控件
- (void) initMyComplaintsControls
{
    //显示
    self.MyRepairTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH - 64)];
    self.MyRepairTableView.delegate = self;
    self.MyRepairTableView.dataSource = self;
    self.MyRepairTableView.showsVerticalScrollIndicator = NO;
    self.MyRepairTableView.backgroundColor = [UIColor whiteColor];
    self.MyRepairTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.MyRepairTableView];
    
    NSArray *array = [NSArray arrayWithArray:[CYSmallTools getArrData:LOADANIMATION]];
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerMRRefresh)];
    //设置正在刷新状态的动画图片
    [header setImages:array forState:MJRefreshStateRefreshing];
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    header.stateLabel.hidden = YES;
    self.MyRepairTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerMRRefresh)];
    // 设置正在刷新状态的动画图片
    [footer setImages:array forState:MJRefreshStateRefreshing];
    footer.stateLabel.hidden = YES;
    // 设置尾部
    self.MyRepairTableView.mj_footer = footer;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //提示模块
    UIImageView *PromptImageView = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.2, (CYScreanH - 64) * 0.25, CYScreanW * 0.6, (CYScreanH - 64) * 0.3)];
    PromptImageView.image = [UIImage imageNamed:@"missing_content_01"];
    [self.view addSubview:PromptImageView];
    PromptImageView.hidden = YES;
    self.MyRepairImage = PromptImageView;
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//下拉刷新
-(void) headerMRRefresh
{
    //结束下拉刷新
    [self.MyRepairTableView.mj_header endRefreshing];
}
//上拉刷新根据不同的排序调用不同的方法
- (void) footerMRRefresh
{
    self.currentRePage += 1;
    [self getMyRepair];
}

//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComplaintCellFrame *frame = _dataModelMRArray[indexPath.row];
    return frame.cellHeight;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataModelMRArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ComplaintCell";
    self.myCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.myCell == nil)
    {
        self.myCell = [[ComplaintCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    self.myCell.complaintCellFrame = self.dataModelMRArray[indexPath.row];
    self.myCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return self.myCell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//获取报修列表
- (void) getMyRepair
{
    //第一次加载数据
    if (self.currentRePage == 1)
    {
        [MBProgressHUD showLoadToView:self.view];
    }
    self.MyRepairImage.hidden = YES;//每次请求都默认隐藏
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"pageSize"]    =  @"15";//
    parames[@"currentPage"] =  [NSString stringWithFormat:@"%ld",self.currentRePage];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/repairList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (self.currentRePage == 1)
         {
             [MBProgressHUD hideHUDForView:self.view];
         }
         // 结束上拉刷新
         [self.MyRepairTableView.mj_footer endRefreshing];
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
                     [self.dataModelMRArray addObject:cellFrame];
                     [self.MyRepairTableView reloadData];
                 }
             }
         }
         else
         {
             self.currentRePage -= 1;
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
         if (!self.dataModelMRArray.count)
         {
             self.MyRepairImage.hidden = NO;
         }
         if (self.currentRePage == 1)
         {
             [MBProgressHUD hideHUDForView:self.view];
             [MBProgressHUD showError:@"加载出错" ToView:self.view];
         }
         // 结束上拉刷新
         [self.MyRepairTableView.mj_footer endRefreshing];
         self.currentRePage -= 1;
         NSLog(@"报修列表请求失败:%@", error.description);
     }];
}

@end
