//
//  OrderMViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "OrderMViewController.h"
#import "MJExtension.h"
#import "OrderCellFrame.h"
#import "ReLogin.h"
@interface OrderMViewController ()
@property (nonatomic, weak) UIButton *PaiedBtn;
@property (nonatomic, weak) UIButton *UnPaiedBtn;
@property (nonatomic, weak) UIButton *DoneBtn;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) NSString *process;
@end

@implementation OrderMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setOrderMStyle];
    [self initOrderMControls];
    
}
//设置样式
- (void) setOrderMStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的订单";

}
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
    //获取订单数据:每次都重新加载
    [self getAllOrderData];
}
////初始化数据源
//- (void) initOrderMModelData:(NSArray *)array
//{
//    //数据源
//    self.MyOrderModelArray = [[NSMutableArray alloc] init];
//    self.MyOrderAllDataArray = [NSArray arrayWithArray:array];
//    for (NSInteger i = array.count - 1; i >= 0; i --)
//    {
//        NSDictionary *orderDict = [NSDictionary dictionaryWithDictionary:array[i]];
//        NSDictionary *dict = @{
//                               @"orderIdString":[NSString stringWithFormat:@"%@",[orderDict objectForKey:@"id"]],
//                               @"headImageString":[NSString stringWithFormat:@"%@",[orderDict objectForKey:@"shopImg"]],
//                               @"nameString":[NSString stringWithFormat:@"%@",[orderDict objectForKey:@"shopName"]],
//                               @"timeString":[NSString stringWithFormat:@"%@",[orderDict objectForKey:@"gmtCreate"]],
//                               @"moneyString":[NSString stringWithFormat:@"%@",[orderDict objectForKey:@"nowMoney"]],
//                               @"satateString":[NSString stringWithFormat:@"%@",[orderDict objectForKey:@"process"]]
//                               };
//        OrderMModel *model = [OrderMModel bodyWithDict:dict];
//        [self.MyOrderModelArray addObject:model];
//    }
//    [self.OrderMTableView reloadData];
//}

//初始化首页控件
- (void) initOrderMControls
{
    self.process = @"1";
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYScreanW, (CYScreanH - 64)*0.1)];
    topView.backgroundColor = [UIColor whiteColor];
    
    UIButton *PaiedBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CYScreanW/3, (CYScreanH - 64)*0.1)];
    PaiedBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [PaiedBtn setTitle:@"已支付" forState:UIControlStateNormal];
    [PaiedBtn setTitleColor:CQColor(153,153,153, 1) forState:UIControlStateNormal];
    [PaiedBtn setTitleColor:CQColor(97,191,255, 1) forState:UIControlStateSelected];
    
    UIButton *UnPaiedBtn = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW/3, 0, CYScreanW/3, (CYScreanH - 64)*0.1)];
    UnPaiedBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [UnPaiedBtn setTitle:@"未支付" forState:UIControlStateNormal];
    [UnPaiedBtn setTitleColor:CQColor(153,153,153, 1) forState:UIControlStateNormal];
    [UnPaiedBtn setTitleColor:CQColor(97,191,255, 1) forState:UIControlStateSelected];
    
    UIButton *DoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW*2/3, 0, CYScreanW/3, (CYScreanH - 64)*0.1)];
    [DoneBtn setTitle:@"已完成" forState:UIControlStateNormal];
    [DoneBtn setTitleColor:CQColor(153,153,153, 1) forState:UIControlStateNormal];
    DoneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [DoneBtn setTitleColor:CQColor(97,191,255, 1) forState:UIControlStateSelected];
    
    [PaiedBtn addTarget:self action:@selector(paiedButton) forControlEvents:UIControlEventTouchUpInside];  
    [UnPaiedBtn addTarget:self action:@selector(unpaiedButton) forControlEvents:UIControlEventTouchUpInside];
    [DoneBtn addTarget:self action:@selector(doneButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, (CYScreanW - 64)*0.18, CYScreanW/3, (CYScreanW - 64)*0.02)];
    lineView.backgroundColor = CQColor(97,191,255, 1);
    _UnPaiedBtn = UnPaiedBtn;
    _PaiedBtn = PaiedBtn;
    _DoneBtn = DoneBtn;
    _lineView = lineView;
    [topView addSubview:_UnPaiedBtn];
    [topView addSubview:_PaiedBtn];
    [topView addSubview:_DoneBtn];
    [topView addSubview:_lineView];
    [_PaiedBtn setSelected:YES];
    //显示
    self.view.backgroundColor = CQColor(246,243,254, 1);
    self.OrderMTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, (CYScreanH-64)*0.1, CYScreanW, (CYScreanH - 64)*0.9)];
    self.OrderMTableView.delegate = self;
    self.OrderMTableView.dataSource = self;
    self.OrderMTableView.backgroundColor = CQColor(249, 249, 249, 1);
    self.OrderMTableView.showsVerticalScrollIndicator = NO;
    self.OrderMTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:topView];
    [self.view addSubview:self.OrderMTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)paiedButton
{
    [_PaiedBtn setSelected:YES];
    [_UnPaiedBtn setSelected:NO];
    [_DoneBtn setSelected:NO];
    _lineView.frame = CGRectMake(0, (CYScreanW - 64)*0.18, CYScreanW/3, (CYScreanW - 64)*0.02);
    if(![self.process isEqualToString:@"1"]){
        self.process = @"1";
        [self getAllOrderData];
    }
}
-(void)unpaiedButton
{
    [_PaiedBtn setSelected:NO];
    [_UnPaiedBtn setSelected:YES];
    [_DoneBtn setSelected:NO];
    _lineView.frame = CGRectMake(CYScreanW/3, (CYScreanW - 64)*0.18, CYScreanW/3, (CYScreanW - 64)*0.02);
    if(![self.process isEqualToString:@"6"]){
        self.process = @"6";
        [self getAllOrderData];
    }
}
-(void)doneButton
{
    [_PaiedBtn setSelected:NO];
    [_UnPaiedBtn setSelected:NO];
    [_DoneBtn setSelected:YES];
    _lineView.frame = CGRectMake(CYScreanW*2/3, (CYScreanW - 64)*0.18, CYScreanW/3, (CYScreanW - 64)*0.02);
    if(![self.process isEqualToString:@"4"]){
        self.process = @"4";
        [self getAllOrderData];
    }
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCellFrame *frame = _MyOrderAllDataArray[indexPath.row];
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
    return self.MyOrderAllDataArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"OrderMTableViewCell";
    self.OrderCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.OrderCell == nil)
    {
        self.OrderCell = [[OrderMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    self.OrderCell.orderCellFrame = self.MyOrderAllDataArray[indexPath.row];
    self.OrderCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return self.OrderCell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    OrderCellFrame *model = self.MyOrderAllDataArray[indexPath.row];
    OrderDetailsViewController *ODController = [[OrderDetailsViewController alloc] init];
    NSLog(@"订单id%@",model.orderModel.id);
    ODController.selectOrderId = [NSString stringWithFormat:@"%@",model.orderModel.id];
    [self.navigationController pushViewController:ODController animated:YES];
    
}
//获取订单数
- (void) getAllOrderData
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"process"]     =  self.process;
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/myOrderList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"获取订单数请求成功JSON = %@",JSON);
//         [self.MyOrderAllDataArray removeAllObjects];
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             self.MyOrderAllDataArray = [[NSMutableArray alloc] init];

        NSArray *array = [[NSArray alloc] init];
         array = [OrderMModel objectArrayWithKeyValuesArray:[JSON objectForKey:@"returnValue"]];
             self.MyOrderAllDataArray = [[NSMutableArray alloc] init];
         if (array.count)
         {
             NSLog(@"数组长度%lu",(unsigned long)array.count);
             for (int i = 0; i < array.count; i++) {
                 OrderMModel *model = array[i];
                 OrderCellFrame *cellFrame = [[OrderCellFrame alloc] init];
                 cellFrame.orderModel = model;
                 [self.MyOrderAllDataArray addObject:cellFrame];
             }
             NSLog(@"正是数组长度%lu",(unsigned long)self.MyOrderAllDataArray.count);
         }
             [self.OrderMTableView reloadData];

     }
         else{
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
         }
//         NSString *type = [JSON objectForKey:@"type"];
//         if ([type isEqualToString:@"1"]||[type isEqual:@"2"]) {
//             ReLogin *relogin = [[ReLogin alloc] init];
//             [self.navigationController presentViewController:relogin animated:YES completion:^{
//
//             }];
//         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
