//
//  BBSRootViewController.m
//  WisdomCommunity
// 社区大小事页面->点击"热门话题"->帖子控制器
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "BBSRootViewController.h"
#import "MJExtension.h"
#import "MessageView.h"
#import "ReplyInputView.h"
#import "IQKeyboardManager.h"
#import "ReLogin.h"
@interface BBSRootViewController ()
{
    NSString *type;
    ComBBSCellFrame *selectedCellFrame;
    FollowNoteCellFrame *selectedNoteCellFrame;
}
@property (nonatomic,weak)MessageView *messageView; //点击后弹出的评论按钮

@property (nonatomic,weak)ReplyInputView *replyInputView;
@property (nonatomic,assign)float replyViewDraw;
@property (nonatomic,assign)BOOL flag;  //用于键盘出现时函数调用多次的情况
@end

@implementation BBSRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBBSStyle];
    [self initBBSController];
}
- (void) viewWillAppear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].enable = NO;
    //只要不是从详情页返回的都要重新加载帖子数据
    if (![[CYSmallTools getDataStringKey:@"InputPostDetailsView"] isEqual:@"YES"])
    {
        if (!(self.comModelBBSarray.count)) {
            [MBProgressHUD showLoadToView:self.view];
        }
        [self initABBSRootData];
        [self getCBListRequest];
    }
    [self.tabBarController.tabBar setHidden:NO];
    if (self.ClickPRootCellData.count == 2)
    {
        //刷新位置和帖子数据
        [self getClickRootCellNewData:self.ClickPRootCellData[0] withDict:self.ClickPRootCellData[1]];
    }
    //每次都请求查看最多的帖子数据
}
#pragma mark - 页面消失
- (void) viewWillDisappear:(BOOL)animated
{
    //记录进入帖子详情页,每次页面消失都清空，防止记录
    [CYSmallTools saveDataString:nil withKey:@"InputPostDetailsView"];
    [IQKeyboardManager sharedManager].enable = YES;

}
//初始化数据
- (void) initDataBBSModel:(NSArray *)array
{
    
}
-(void)appendTableWithObject:(NSMutableArray *)data
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (int i = 0;i < [data count];i ++)
    {
        [dataArray addObject:[data objectAtIndex:i]];
    }
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];
    for (int ind = 0; ind < [data count]; ind++)
    {
        NSIndexPath *newPath =  [NSIndexPath indexPathForRow:[dataArray indexOfObject:[data objectAtIndex:ind]] inSection:0];
        [insertIndexPaths addObject:newPath];
    }
    [self.comBBSTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
}
//设置样式
- (void) setBBSStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"帖子";
    [self initABBSRootData];
}
//初始化数据源
- (void) initABBSRootData
{
    //数据源
    self.comModelBBSarray = [[NSMutableArray alloc] init];
    self.recordRequesPage = 1;//初始为1
}
//结束刷新
- (void) endCBBSHeadRefresh
{
    //结束下拉刷新
    [self.comBBSTableView.mj_header endRefreshing];
}
- (void) endCBBSFooterRefresh
{
    if (self.comModelBBSarray.count)
    {
        self.recordRequesPage += 1;
    }
    [self getCBListRequest];
}
#pragma mark -MJ刷新加载配置
- (void)RefreshAndUpload {
    NSArray *array = [NSArray arrayWithArray:[CYSmallTools getArrData:LOADANIMATION]];
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(endCBBSHeadRefresh)];
    //设置正在刷新状态的动画图片
    [header setImages:array forState:MJRefreshStateRefreshing];
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    header.stateLabel.hidden = YES;
    self.comBBSTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(endCBBSFooterRefresh)];
    // 设置正在刷新状态的动画图片
    [footer setImages:array forState:MJRefreshStateRefreshing];
    footer.stateLabel.hidden = YES;
    // 设置尾部
    self.comBBSTableView.mj_footer = footer;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
//初始化控件
- (void) initBBSController
{
    //显示tableView
    self.comBBSTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH - 113)];
    self.comBBSTableView.delegate = self;
    self.comBBSTableView.dataSource = self;
    self.comBBSTableView.showsVerticalScrollIndicator = NO;
    self.comBBSTableView.backgroundColor = [UIColor whiteColor];
    self.comBBSTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.comBBSTableView];
    //刷新加载
    [self RefreshAndUpload];
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        ComBBSCellFrame *frame = _comModelBBSarray[indexPath.row];
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
    return self.comModelBBSarray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComBBSCell *cell = [ComBBSCell cellWithTableView:tableView];
    ComBBSCellFrame *model = _comModelBBSarray[indexPath.row];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.comBBSCellFrame = model;
    [cell.popView addTarget:self action:@selector(replyAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.popView.tag = indexPath.row;   //评论时可以知道加到第几行
    cell.delegate = self;
    return cell;
}
-(void)deleteNote:(NSString *)noteId{
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"id"]     =  noteId;
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    NSLog(@"昵称%@", [ActivityDetailsTools UTFTurnToStr:selectedCellFrame.comBBSModel.content]);
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@//api/note/noteDel",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"返回值%@",responseObject);
         BOOL success = [responseObject objectForKey:@"success"];
         if (success) {
             [self getCBListRequest];
         }else{
             [MBProgressHUD showSuccess:[responseObject objectForKey:@"error"] ToView:self.view];
             NSString *type = [responseObject objectForKey:@"type"];
             if ([type isEqualToString:@"1"]||[type isEqual:@"2"]) {
                 ReLogin *relogin = [[ReLogin alloc] init];
                 [self.navigationController presentViewController:relogin animated:YES completion:^{
                     
                 }];
             }
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"请求失败:%@", error.description);
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
     }];
}
-(void)responseToNote:(FollowNoteCellFrame *)cellFrame
{
    selectedNoteCellFrame = cellFrame;
    type = @"2";
    NSLog(@"type值当%@",type);
    [self initReplyInputView];
}
-(void)replyAction:(UIButton *)sender
{
    type = @"1";
    ComBBSCell *cell = (ComBBSCell *)sender.superview.superview;
    selectedCellFrame = cell.comBBSCellFrame;
    self.replyViewDraw = [cell convertRect:cell.bounds toView:self.view.window].origin.y + cell.frame.size.height;
    
    NSIndexPath *indexPath = [self.comBBSTableView indexPathForCell:cell];
    CGRect rectInTableView = [self.comBBSTableView rectForRowAtIndexPath:indexPath];
    //NSLog(@"%f",rectInTableView.origin.y);
    CGRect replyButtonF = CGRectMake(sender.frame.origin.x , rectInTableView.origin.y+sender.frame.origin.y - 2, 0,20);
    CGRect messageViewF = CGRectMake(sender.frame.origin.x , rectInTableView.origin.y+sender.frame.origin.y - 2, 0,20);
    if (self.messageView && self.messageView.frame.origin.y != (rectInTableView.origin.y+sender.frame.origin.y - 2-padding)) {
        [self.messageView removeFromSuperview];      //以防用户按了一个评论又按另一个
        self.messageView = nil;
    }
    [self initReplyButton:messageViewF];
    if (self.messageView) {
        self.messageView.tag = sender.tag;
    }
}

-(void)initReplyButton:(CGRect)replyButtonF
{
    if (!self.messageView) {
        MessageView *messageView = [MessageView instanceView];
        messageView.layer.cornerRadius = 5;
        messageView.backgroundColor = [UIColor colorWithRed:33/255.0 green:37/255.0 blue:38/255.0 alpha:1.0];
        messageView.frame = replyButtonF;
        [messageView.MessageBtn addTarget:self action:@selector(replyMessage:) forControlEvents:UIControlEventTouchUpInside];
        [messageView.priseBtn addTarget:self action:@selector(prise:) forControlEvents:UIControlEventTouchUpInside];
        [self.comBBSTableView addSubview:messageView];
        self.messageView = messageView;
        
        [UIView animateWithDuration:0.25f animations:^{
            CGRect replyButtonDurF;
            replyButtonDurF.size.height = replyButtonF.size.height + 2*padding;
            replyButtonDurF.origin.y = replyButtonF.origin.y - padding;
            replyButtonDurF.origin.x = replyButtonF.origin.x - 120;
            replyButtonDurF.size.width = 120;
            messageView.frame = replyButtonDurF;
        } completion:^(BOOL finished) {
            //            [replyButton setTitle:@"评论" forState:0];
        }];
        
    }
    else
    {
        self.messageView.MessageBtn.tag = self.messageView.tag;
        self.messageView.priseBtn.tag = self.messageView.tag;
        [UIView animateWithDuration:0.25f animations:^{
            self.messageView.frame = replyButtonF;    //只是为了有收缩的动画效果
        } completion:^(BOOL finished) {
            [self.messageView removeFromSuperview];
            self.messageView = nil;
        }];
        
    }
}
-(void)replyMessage:(UIButton *)sender
{
    if (self.messageView) {
        [self initReplyInputView];
        [self.messageView removeFromSuperview];
        self.messageView = nil;
    }
}
-(void)prise:(UIButton *)sender
{
    [self prise];
    ComBBSCell *cell = (ComBBSCell *)sender.superview.superview;
    
    NSIndexPath *indexPath = [self.comBBSTableView indexPathForCell:cell];
    CGRect rectInTableView = [self.comBBSTableView rectForRowAtIndexPath:indexPath];
    CGRect messageViewF = CGRectMake(sender.frame.origin.x , rectInTableView.origin.y+sender.frame.origin.y - 2, 0,20);
    if (self.messageView && self.messageView.frame.origin.y != (rectInTableView.origin.y+sender.frame.origin.y - 2-padding)) {
        [self.messageView removeFromSuperview];      //以防用户按了一个评论又按另一个
        self.messageView = nil;
    }
    [self initReplyButton:messageViewF];
    if (self.messageView) {
        self.messageView.tag = sender.tag;
    }
}
-(void)prise
{
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"noteId"]     =  [NSString stringWithFormat:@"%@", selectedCellFrame.comBBSModel.id];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    NSLog(@"昵称%@", [ActivityDetailsTools UTFTurnToStr:selectedCellFrame.comBBSModel.content]);
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/notePraise",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"返回值%@",responseObject);
         BOOL success = [responseObject objectForKey:@"success"];
         if (success) {
             self.inputView.hidden = YES;
             [self getCBListRequest];
         }else{
             [MBProgressHUD showSuccess:[responseObject objectForKey:@"error"] ToView:self.view];
             NSString *type = [responseObject objectForKey:@"type"];
             if ([type isEqualToString:@"1"]||[type isEqual:@"2"]) {
                 ReLogin *relogin = [[ReLogin alloc] init];
                 [self.navigationController presentViewController:relogin animated:YES completion:^{
                     
                 }];
             }
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"请求失败:%@", error.description);
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
     }];
}
-(void)initReplyInputView
{
    if(!self.inputView){
        //    //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        //增加监听，当键退出时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        ReplyInputView *replyInputView = [[ReplyInputView alloc]initWithFrame:CGRectMake(0, CYScreanH, CYScreanH-64-50, 54) andAboveView:self.view];
        
        self.flag = YES;
        //回调输入框的contentSize,改变工具栏的高度
        [replyInputView setContentSizeBlock:^(CGSize contentSize) {
            [self updateHeight:contentSize];
        }];
        self.replyInputView = replyInputView;
        [self.view addSubview:_replyInputView];
        self.replyInputView.delegate = self;
    }else{
        self.inputView.hidden = NO;
    }
}
//更新replyView的高度约束
-(void)updateHeight:(CGSize)contentSize
{
    float height = contentSize.height + 20;
    CGRect frame = self.replyInputView.frame;
    frame.origin.y -= height - frame.size.height;  //高度往上拉伸
    frame.size.height = height;
    self.replyInputView.frame = frame;
}
-(void)response:(NSString *)content
{
    if ([type isEqualToString:@"1"]) {
        [self responseToFirst:content type:type requesterNoteId:@"" requesterAccount:@"" noteid:[NSString stringWithFormat:@"%@",selectedCellFrame.comBBSModel.id]];
    }else{
        [self responseToFirst:content type:type requesterNoteId:selectedNoteCellFrame.followNoteDO.id requesterAccount:selectedNoteCellFrame.followNoteDO.account noteid:selectedNoteCellFrame.followNoteDO.noteId];
    }
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    self.replyInputView.frame = CGRectMake(0, CYScreanH-54-height-64, screenWidth, 54);
    self.replyInputView.hidden = NO;
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSLog(@"键盘将要小时");
    self.replyInputView.hidden = YES;
}
-(void)responseToFirst:(NSString *)content type:(NSString *)type requesterNoteId:(NSString *)requesterNoteId requesterAccount:(NSString *)requesterAccount noteid:(NSString *)noteId
{
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"content"]     =  content;//
    parames[@"state"]  =  type;
    parames[@"requesterAccount"]     =  requesterAccount;
    parames[@"requesterNoteId"]     =  requesterNoteId;
    parames[@"noteId"]     =  noteId;
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    NSLog(@"昵称%@", [ActivityDetailsTools UTFTurnToStr:selectedCellFrame.comBBSModel.content]);
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/followNote",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"返回值%@",responseObject);
         BOOL success = [responseObject objectForKey:@"success"];
         if (success) {
             [MBProgressHUD showSuccess:@"跟帖成功" ToView:self.view];
             self.inputView.hidden = YES;
             [self getCBListRequest];
         }else{
             [MBProgressHUD showSuccess:[responseObject objectForKey:@"error"] ToView:self.view];
             NSString *type = [responseObject objectForKey:@"type"];
             if ([type isEqualToString:@"1"]||[type isEqual:@"2"]) {
                 ReLogin *relogin = [[ReLogin alloc] init];
                 [self.navigationController presentViewController:relogin animated:YES completion:^{
                     
                 }];
             }
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"请求失败:%@", error.description);
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
     }];
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取帖子列表
- (void) getCBListRequest
{
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"category"]     =  @"2";//
    parames[@"currentPage"]  =  [NSString stringWithFormat:@"%ld",self.recordRequesPage];
    parames[@"pageSize"]     =  @"15";
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/noteList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"返回数据%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [responseObject objectForKey:@"returnValue"];
         // 结束上拉刷新
         [self.comBBSTableView.mj_footer endRefreshing];
         _comModelBBSarray = [[NSMutableArray alloc] init];
         if ([[responseObject objectForKey:@"success"] integerValue] == 1)
         {
             NSArray *array = [comBBSModel objectArrayWithKeyValuesArray:JSON];
             for (comBBSModel *model in array) {
                 ComBBSCellFrame *cellFrame = [[ComBBSCellFrame alloc] init];
                 cellFrame.comBBSModel = model;
                 [_comModelBBSarray addObject:cellFrame];
             }
             [self.comBBSTableView reloadData];
             //如果没请求到数据
             if (_comModelBBSarray.count <= 0)
             {
                 [MBProgressHUD showError:@"没有数据了" ToView:self.view];
                 [self ReductionInt];
             }
             //更新数据
             //             [self initDataBBSModel:array];
         }
         else
         {
             //更新数据
             [self initDataBBSModel:nil];
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
             [self ReductionInt];
             NSString *type = [responseObject objectForKey:@"type"];
             if ([type isEqualToString:@"1"]||[type isEqual:@"2"]) {
                 ReLogin *relogin = [[ReLogin alloc] init];
                 [self.navigationController presentViewController:relogin animated:YES completion:^{
                     
                 }];
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"请求失败:%@", error.description);
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         // 结束上拉刷新
         [self.comBBSTableView.mj_footer endRefreshing];
         [self ReductionInt];
     }];
}
//减计数
- (void) ReductionInt
{
    if (self.comModelBBSarray.count)
    {
        self.recordRequesPage -= 1;
    }
}
//获取点击cell的下标
- (void) getClickRootCellNewData:(NSString *)ClickRow withDict:(NSDictionary *)dict
{
//    [MBProgressHUD showLoadToView:self.view];
//    //数据请求   设置请求管理者
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    // 拼接请求参数
//    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
//    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
//    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
//    parames[@"noteId"]  =  [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
//    NSLog(@"parames = %@",parames);
//    //url
//    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/viewNote",POSTREQUESTURL];
//    NSLog(@"requestUrl = %@",requestUrl);
//    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
//     {
//         [MBProgressHUD hideHUDForView:self.view];
//         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//         NSLog(@"点击帖子请求成功JSON = %@",JSON);
//         if ([[JSON objectForKey:@"success"] integerValue] == 1)
//         {
//             NSArray *array = @[[JSON objectForKey:@"returnValue"]];
//             [self uploadClickCell:[NSArray arrayWithArray:[NNSRootModelData initBBSRootModel:array]] withPostDict:[JSON objectForKey:@"returnValue"] withRow:ClickRow];
//         }
//         else
//             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
//     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
//     {
//         [MBProgressHUD hideHUDForView:self.view];
//         [MBProgressHUD showError:@"加载出错" ToView:self.view];
//     }];
//    //初始化
//    self.ClickPRootCellData = [[NSArray alloc] init];
}
//刷新点击的cell
- (void) uploadClickCell:(NSArray *)array withPostDict:(NSDictionary *)dict withRow:(NSString *)ClickRow
{
    //        [self.comAllBBSarray   replaceObjectAtIndex:[ClickRow integerValue] withObject:dict];
    //
    //        NSArray *BBSArray = [NSArray arrayWithArray:array[1]];
    //        [self.comTBHeightarray    replaceObjectAtIndex:[ClickRow integerValue] withObject:BBSArray[0]];
    //
    //        BBSArray = [NSArray arrayWithArray:array[2]];
    //        [self.comModelBBSarray replaceObjectAtIndex:[ClickRow integerValue] withObject:BBSArray[0]];
    //
    //        //刷新
    //        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[ClickRow integerValue] inSection:1];
    //        [self.comBBSTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)refresh:(FollowNoteCellFrame *)cellFrame
{
    //    [self.comBBSTableView reloadData];
}

@end
