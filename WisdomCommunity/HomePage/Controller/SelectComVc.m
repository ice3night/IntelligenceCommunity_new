//
//  SelectComVc.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/3.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "SelectComVc.h"
#import "ReLogin.h"
#import "ComModel.h"
#import "MJExtension.h"
#import "NormalCell.h"
@interface SelectComVc ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (nonatomic, copy) NSMutableArray *coms;
@property (nonatomic, copy) NSString *comId;
@property (nonatomic, copy) NSString *comStr;
@end

@implementation SelectComVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
}
- (void)initView
{
    self.mTableView.rowHeight = 44;
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.separatorStyle = UITableViewStylePlain;
}
- (void)getComData
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/community/comList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager GET:requestUrl parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"%@",responseObject);
        NSNumber *success = [responseObject objectForKey:@"success"];
        if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
            NSDictionary *comlist = [[responseObject objectForKey:@"param"] objectForKey:@"comList"];
            _coms = [ComModel objectArrayWithKeyValuesArray:comlist];
            NSLog(@"返回值长度%lu",(unsigned long)_coms.count);
            [self.mTableView reloadData];
            }else{
            [MBProgressHUD showSuccess:[responseObject objectForKey:@"error"] ToView:self.view];
                NSString *type = [responseObject objectForKey:@"type"];
                if ([type isEqualToString:@"1"]||[type isEqual:@"2"]) {
                    ReLogin *relogin = [[ReLogin alloc] init];
                    [self.navigationController presentViewController:relogin animated:YES completion:^{
                        
                    }];
                }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络错误" ToView:self.view];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _coms.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NormalCell *cell = [NormalCell cellWithTableView:tableView];
    ComModel *model = _coms[indexPath.row];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComModel *model = _coms[indexPath.row];
    [self.delegate getCom:model];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"选择小区";
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
    [self getComData];
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
