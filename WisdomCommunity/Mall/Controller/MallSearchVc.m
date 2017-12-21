//
//  MallSearchVc.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "MallSearchVc.h"
#import "MallSearchResult.h"
#import "History.h"
#import "MJExtension.h"
@interface MallSearchVc ()
{
    UITextField *myTextField;
}
@end

@implementation MallSearchVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)initView
{
    UIView *view = [[UIView alloc] init];
    UIImage *bgImage = [UIImage imageNamed:@"bg_textfield"];
    UIImage *BtnImage = [UIImage imageNamed:@"icon_second_search"];
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(bgImage.size.width-BtnImage.size.width-5, (bgImage.size.height-BtnImage.size.height)/2, BtnImage.size.width, BtnImage.size.height)];
    [searchBtn setImage:BtnImage forState:UIControlStateNormal];
    view.frame = CGRectMake((CYScreanW-bgImage.size.width)/2, (self.navigationController.navigationBar.frame.size.height - bgImage.size.height)/2, bgImage.size.width, bgImage.size.height);
    UIImageView *viewBg = [[UIImageView alloc] initWithImage:bgImage];
    
    viewBg.frame = CGRectMake(0, 0, bgImage.size.width, bgImage.size.height);
    myTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, (bgImage.size.height -20)/2, bgImage.size.width-searchBtn.bounds.size.width-10, 20)];
    [myTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [myTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    myTextField.font = [UIFont boldSystemFontOfSize:15];
    myTextField.textColor = CQColor(102,102,102, 1);
    myTextField.returnKeyType = UIReturnKeySearch;
    [view addSubview:viewBg];
    [view addSubview:searchBtn];
    [view addSubview:myTextField];
    self.navigationItem.titleView = view;
    
    CGRect rightFrame= CGRectMake(0, 0, 50, 50);
    UIButton* rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = rightFrame;
    [rightButton setTitle:@"搜索" forState:UIControlStateNormal];
    [rightButton setTitleColor:CQColor(102,102,102, 1) forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightButton addTarget:self action:@selector(goSearch) forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的 UIBarButtonItem
    UIBarButtonItem* rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}
- (void)goSearch{
    NSString *key = myTextField.text;
    if (key.length > 0) {
        if (![self.sourceArr containsObject:key]) {
            [self.sourceArr addObject:key];
        }
        NSString *finalStr = @"";
        for (NSString *str in self.sourceArr) {
            if ([str isEqualToString:[self.sourceArr lastObject]]) {
                finalStr = [finalStr stringByAppendingString:str];
            }else{
                finalStr = [[finalStr stringByAppendingString:str] stringByAppendingString:@","];
            }
        }
        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        [userDef setObject:finalStr forKey:@"histroySearch"];
    }
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    MallSearchResult *searchVc = [[MallSearchResult alloc] init];
    searchVc.key = key;
    [self.navigationController pushViewController:searchVc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setHidden:NO];
}
- (void)initData
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *history = [userDef objectForKey:@"histroySearch"];
    self.sourceArr = [[NSMutableArray alloc] init];
    if (history.length >0) {
        NSArray *array =  [history componentsSeparatedByString:@","];
        [self.sourceArr addObjectsFromArray:array];
    }
    [self.tableView reloadData];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.sourceArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    static NSString *ID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSString *history = self.sourceArr[self.sourceArr.count -indexPath.row-1];
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.frame = CGRectMake(20, 0, CYScreanW-40, cell.bounds.size.height);
    nameLabel.font = font;
    NSLog(@"cell中的%@",history);
    nameLabel.text = history;
    [cell.contentView addSubview:nameLabel];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = self.sourceArr[indexPath.row];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    MallSearchResult *searchVc = [[MallSearchResult alloc] init];
    searchVc.key = key;
    [self.navigationController pushViewController:searchVc animated:YES];
}
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
