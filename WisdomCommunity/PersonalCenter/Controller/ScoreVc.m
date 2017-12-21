//
//  ScoreVc.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/7.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ScoreVc.h"
#import "ScoreCell.h"
#import "ReLogin.h"
#import "MJExtension.h"
@interface ScoreVc ()
{
    UILabel *tipLabel;
}
@property (nonatomic, copy) NSMutableArray *scores;
@property (nonatomic,weak) UILabel *scoreLabel;
@property (nonatomic,weak) UILabel *frozeLabel;

@property (nonatomic,weak) UIView *headerView;
@property (nonatomic,weak) UIImage *image;
@end

@implementation ScoreVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.tableView.allowsSelection = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
-(void)initView
{
    _image = [UIImage imageNamed:@"bg_sing"];
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CYScreanW, CYScreanW*_image.size.height/_image.size.width)];
    bgImage.image = _image;
    [self.view addSubview:bgImage];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(CYScreanW*0.35, (CYScreanH - 64) * 0.07-0.02*CYScreanW, CYScreanW*0.30, CYScreanW*0.30)];
    bottomView.backgroundColor = CQColor(208, 207, 233, 1);
    bottomView.layer.cornerRadius = CYScreanW*0.15;
    bottomView.layer.masksToBounds = YES;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(CYScreanW*0.37, (CYScreanH - 64) * 0.07, CYScreanW*0.26, CYScreanW*0.26)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.cornerRadius = CYScreanW*0.13;
    topView.layer.masksToBounds = YES;
    topView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    topView.layer.borderWidth = 1;
    
    UIImage *singImage = [UIImage imageNamed:@"icon_sign"];
    UIImageView *signIcon = [[UIImageView alloc] initWithImage:singImage];
    signIcon.frame = CGRectMake(CYScreanW*0.50-singImage.size.width/2, (CYScreanH - 64) * 0.07+CYScreanW*0.065-singImage.size.height/4, singImage.size.width, singImage.size.height);
    tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(CYScreanW*0.37, signIcon.frame.size.height+signIcon.frame.origin.y, CYScreanW*0.26, CYScreanW*0.06)];
    tipLabel.text = @"每日签到+2";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textColor = CQColor(51, 133, 235, 1);
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(CYScreanW*0.37, tipLabel.frame.size.height+tipLabel.frame.origin.y, CYScreanW*0.26, CYScreanW*0.08)];
    scoreLabel.text = @"积分";
    scoreLabel.font = [UIFont systemFontOfSize:12];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.textColor = [UIColor whiteColor];
    scoreLabel.backgroundColor = CQColor(252,92,75, 1);
    scoreLabel.layer.cornerRadius = 5.0;
    scoreLabel.layer.masksToBounds = YES;
    _scoreLabel = scoreLabel;
    
    UILabel *frozeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CYScreanW*0.37, scoreLabel.frame.size.height+scoreLabel.frame.origin.y+10, CYScreanW*0.26, CYScreanW*0.08)];
    frozeLabel.text = @"积分";
    frozeLabel.textColor = CQColor(255,193,3, 1);
    frozeLabel.font = [UIFont systemFontOfSize:12];
    frozeLabel.textAlignment = NSTextAlignmentCenter;
    _frozeLabel = frozeLabel;
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, CYScreanW, CYScreanW*_image.size.height/_image.size.width);
    
    [headerView addSubview:bottomView];
    [headerView addSubview:topView];
    [headerView addSubview:signIcon];
    [headerView addSubview:tipLabel];
    [headerView addSubview:_frozeLabel];
    [headerView addSubview:_scoreLabel];
    _headerView = headerView;
    [self.tableView setTableHeaderView:_headerView];
    [self.tableView reloadData];
//    self.tableView.hidden = YES;
}
- (void)getScoreData
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
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/myScoreLog",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"%@",responseObject);
        NSNumber *success = [responseObject objectForKey:@"success"];
        if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
            NSDictionary *comlist = [responseObject objectForKey:@"returnValue"];
            NSNumber *tip = [[responseObject objectForKey:@"param"] objectForKey:@"sinScore"];
            tipLabel.text = [@"每日签到+" stringByAppendingString:[NSString stringWithFormat:@"%@",tip]];
            _scoreLabel.text = [@"总积分：" stringByAppendingString:[responseObject objectForKey:@"msg"]];
            NSNumber *froeScore = [[responseObject objectForKey:@"param"] objectForKey:@"freezeScore"];
                _frozeLabel.text = [@"已冻结积分：" stringByAppendingString:[NSString stringWithFormat:@"%@",froeScore]];
            _scores = [ScoreModel objectArrayWithKeyValuesArray:comlist];
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showSuccess:[responseObject objectForKey:@""] ToView:self.view];
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
    return _scores.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScoreCell *cell = [ScoreCell cellWithTableView:tableView];
    ScoreModel *model = _scores[indexPath.row];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"社区积分";
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
    [self getScoreData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
