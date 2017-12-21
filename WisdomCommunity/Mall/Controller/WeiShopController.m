//
//  WeiShopController.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/12/16.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "WeiShopController.h"
@interface WeiShopController ()

@end

@implementation WeiShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
//    [self initData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setHidden:NO];
}
-(void)initView{
    
}
//- (void)initData{
//    [MBProgressHUD showLoadToView:self.view];
//    //数据请求   设置请求管理者
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    // 拼接请求参数
//    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
//    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
//    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
//    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
//    parames[@"comNo"]       =  [NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]];
//    NSLog(@"parames = %@",parames);
//    //url
//    NSString *requestUrl = [NSString stringWithFormat:@"%@//api/seller/homePage",POSTREQUESTURL];
//    NSLog(@"requestUrl = %@",requestUrl);
//
//    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [MBProgressHUD hideHUDForView:self.view];
//        NSLog(@"%@",responseObject);
//        NSNumber *success = [responseObject objectForKey:@"success"];
//        NSDictionary *returnValue = [responseObject objectForKey:@"returnValue"];
//        if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
//            NSString *slideImage = [returnValue objectForKey:@"slideshow"];
//            self.showImagesArry = [slideImage componentsSeparatedByString:@","];
//            NSDictionary *hotPro = [returnValue objectForKey:@"hotPro"];
//            self.sourceArr = [TodayCMDModel objectArrayWithKeyValuesArray:hotPro];
//            self.shop = [MallRecShop objectWithKeyValues:[returnValue objectForKey:@"isVip"]];
//            [self.collectionView reloadData];
//        }else{
//            [MBProgressHUD showSuccess:[responseObject objectForKey:@"error"] ToView:self.view];
//            NSString *type = [responseObject objectForKey:@"type"];
//            if ([type isEqualToString:@"1"]||[type isEqual:@"2"]) {
//                ReLogin *relogin = [[ReLogin alloc] init];
//                [self.navigationController presentViewController:relogin animated:YES completion:^{
//
//                }];
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MBProgressHUD hideHUDForView:self.view];
//        [MBProgressHUD showError:@"网络错误" ToView:self.view];
//    }];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

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
