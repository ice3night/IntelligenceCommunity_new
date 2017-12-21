//
//  FillFormDetail.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/20.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "FillFormDetail.h"
#import "YuyueDetailModel.h"
#import "MJExtension.h"
#import "YuyueTextFieldCell.h"
#import "YuyueSelectCell.h"
#import "YuyueRadioVc.h"
#import "ReLogin.h"
#import "ConfirmObject.h"
@interface FillFormDetail ()
@property (nonatomic, copy) NSMutableArray *datas;

@end

@implementation FillFormDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self initView];
}
- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"服务预约";
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
    [self getData];
}

- (void)initView
{
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW*0.1, (CYScreanH-64)*0.85, CYScreanW*0.8, (CYScreanH-64)*0.06)];
    okBtn.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    okBtn.layer.cornerRadius = (CYScreanH-64)*0.06/2;
    okBtn.layer.masksToBounds = YES;
    okBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [okBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:okBtn];
}
- (void)confirm
{
    NSString *string;
    for (NSInteger i = 0; i < self.datas.count; i ++)
    {
        YuyueDetailModel *model = self.datas[i];
        NSString *str = [NSString stringWithFormat:@"{\"categoryId\":\"%@\",\"content\":\"%@\"}",model.id,model.yueYueValue];
        NSLog(@"str = %@",str);
        string = string.length > 0 ? [NSString stringWithFormat:@"%@,%@",string,str] : [NSString stringWithFormat:@"%@",str];
    }
    string = [[@"[" stringByAppendingString:string] stringByAppendingString:@"]"];
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"themeId"] = self.themeId;
    parames[@"customs"] = string;
    parames[@"personName"] = @"咸国强";
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/custom/addCustom",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"%@",responseObject);
        NSNumber *success = [responseObject objectForKey:@"success"];
        if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
            [MBProgressHUD showSuccess:@"预约成功" ToView:self.view];
            [self.navigationController popViewControllerAnimated:YES];
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
- (void)getData
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"themeId"] = _themeId;
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/custom/newCustom",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"%@",responseObject);
        NSNumber *success = [responseObject objectForKey:@"success"];
        if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
            NSDictionary *comlist = [[[responseObject objectForKey:@"param"] objectForKey:@"customPage"] objectForKey:@"categoryList"];
            _datas = [YuyueDetailModel objectArrayWithKeyValuesArray:comlist];
            [self.tableView reloadData];
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
    YuyueDetailModel *model = _datas[indexPath.row];
    if ([model.type isEqualToString:@"text"]||[model.type isEqualToString:@"number"]) {
        YuyueTextFieldCell *cell = [YuyueTextFieldCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailModel = model;
        cell.delegate = self;
        cell.category = model.type;
        cell.index = [NSString stringWithFormat:@"%lu",(unsigned long)[_datas indexOfObject:model]];
        return cell;
    }else{
        NSLog(@"外边的%@",model.yueYueValue);
        YuyueSelectCell *cell = [YuyueSelectCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.detailModel = model;
        return cell;
    }
    
}
-(void)touchAndselect:(YuyueDetailModel *)model
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    YuyueRadioVc *radioVc = [[YuyueRadioVc alloc] init];
    radioVc.vcName = model.categoryName;
    radioVc.option = model.option;
    radioVc.delegate = self;
    radioVc.index = [NSString stringWithFormat:@"%ld",(long)[self.datas indexOfObject:model]];
    [self.navigationController pushViewController:radioVc animated:YES];
}
-(void)contentEndEdit:(NSString *)str index:(NSString *)index
{
    YuyueDetailModel *model = _datas[[index intValue]];
    NSLog(@"啦啦啦%@",str);
    model.yueYueValue = str;
    [_datas replaceObjectAtIndex:[index intValue] withObject:model];
    YuyueDetailModel *newmodel = _datas[[index intValue]];
    NSLog(@"哈哈哈%@",newmodel.yueYueValue);
    //    [self.tableView reloadData];
}
-(void)selected:(NSString *)name index:(NSString *)index
{
    YuyueDetailModel *model = _datas[[index intValue]];
    NSLog(@"啦啦啦%@",name);
    model.yueYueValue = name;
    [_datas replaceObjectAtIndex:[index intValue] withObject:model];
    YuyueDetailModel *newmodel = _datas[[index intValue]];
    NSLog(@"哈哈哈%@",newmodel.yueYueValue);
    [self.tableView clearsContextBeforeDrawing];
    [self.tableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end

