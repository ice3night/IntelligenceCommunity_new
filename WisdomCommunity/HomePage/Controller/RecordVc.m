//
//  RecordVc.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/25.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "RecordVc.h"
#import "MJExtension.h"
#import "WorkRecord.h"
@interface RecordVc ()
@property (nonatomic, copy) NSMutableArray *datas;

@end

@implementation RecordVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self initView];
    [self getData];
}
- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"电子填单";
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)initView
{
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}
- (void)getData
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"qrCodeContent"]       =  self.content;

    parames[@"profession"]       =  @"99";

    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/qrcode/scan",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"%@",responseObject);
        BOOL success = [responseObject objectForKey:@"success"];
        if (success) {
            NSDictionary *comlist = [[responseObject objectForKey:@"param"] objectForKey:@"qrCodeRecord"];
            _datas = [WorkRecord objectArrayWithKeyValuesArray:comlist];
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showSuccess:@"暂无该二维码的信息" ToView:self.view];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络错误" ToView:self.view];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"YuyueCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WorkRecord *record = _datas[indexPath.row];
    NSString *worker = @"";
    NSString *thing = @"";
    if ([record.profession intValue] == 2){
        worker = @"保安";
        thing = @"巡逻了";
    }else if([record.profession intValue] == 3){
        worker = @"保洁员";
        thing = @"打扫了";
    }
    cell.textLabel.text = [[[[[worker stringByAppendingString:record.scanName] stringByAppendingString:@"在"] stringByAppendingString:[CYSmallTools timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",record.createTime]]] stringByAppendingString:thing] stringByAppendingString:@"此处"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
@end

