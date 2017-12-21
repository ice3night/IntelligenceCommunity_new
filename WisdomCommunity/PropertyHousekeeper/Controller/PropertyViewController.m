//
//  PropertyViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "PropertyViewController.h"

@interface PropertyViewController ()

@end

@implementation PropertyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setPropertyVCStyle];
    
    
}
//设置物业管家样式
- (void) setPropertyVCStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    //海报
    UIImageView *showImmage = [[UIImageView alloc] init];
    showImmage.image = [UIImage imageNamed:@"property_image"];
    [self.view addSubview:showImmage];
    [showImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.top.equalTo(self.view.mas_top).offset(0);
         make.height.mas_equalTo((CYScreanH - 64) * 0.263);
     }];
    //查看偶的房屋
    UIImageView *housingImmage = [[UIImageView alloc] init];
    housingImmage.image = [UIImage imageNamed:@"btn_my_house_word"];
    housingImmage.userInteractionEnabled = YES;
    [self.view addSubview:housingImmage];
    [housingImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(showImmage.mas_right).offset(-CYScreanW * 0.1);
         make.bottom.equalTo(showImmage.mas_bottom).offset(-(CYScreanH - 64) * 0.03);
     }];
    //添加单击手势防范
    UITapGestureRecognizer *housingImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleHousingTap:)];
    housingImageTap.numberOfTapsRequired = 1;
    [housingImmage addGestureRecognizer:housingImageTap];
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    segmentationImmage.backgroundColor = [UIColor grayColor];
    [self.view addSubview:segmentationImmage];
    [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.top.equalTo(showImmage.mas_bottom).offset((CYScreanH - 64) * 0.02);
         make.height.mas_equalTo(1);
     }];
    //图标
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW * 0.04, (CYScreanH - 64) * 0.266 + 1, CYScreanW * 0.4, (CYScreanH - 64) * 0.08)];
    btnLeft.backgroundColor = [UIColor clearColor];
    [btnLeft setTitle:@"服务内容" forState:UIControlStateNormal];
    [btnLeft setTitleColor:[UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00] forState:UIControlStateNormal];
    [btnLeft setImage:[UIImage imageNamed:@"icon_title_service"] forState:UIControlStateNormal];
    btnLeft.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    btnLeft.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:btnLeft];
    btnLeft.userInteractionEnabled = NO;//不可点击
    //按钮
    self.propertyView = [[PropertyCVCView alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.35 + 1, CYScreanW, CYScreanW * 0.24 + (CYScreanH - 64) * 0.12)];
    self.propertyView.PCVDelegate = self;
    self.propertyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.propertyView];
    
}
- (void) viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = @"物业管家";
    [self.tabBarController.tabBar setHidden:YES];
}
//商品点击手势
-(void)handleHousingTap:(UITapGestureRecognizer *)sender
{
    NSLog(@"handleHousingTap");
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    MyHousPlistViewController *MyHouseController = [[MyHousPlistViewController alloc] init];
    [self.navigationController pushViewController:MyHouseController animated:YES];
}
//物业缴费
- (void) propertyPayment
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    ProPayCostController *PPController = [[ProPayCostController alloc] init];
    [self.navigationController pushViewController:PPController animated:YES];
}
//物业报修
- (void) propertyManagementService
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    PropertyRepairViewController *PRController = [[PropertyRepairViewController alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
//周边
- (void) surrounding
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    PeripheralServicesViewController *PSController = [[PeripheralServicesViewController alloc] init];
    [self.navigationController pushViewController:PSController animated:YES];
}
//投诉建议
- (void) complaintsPCVSuggestions
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    ComplaintsSuggestionsViewController *suggesController = [[ComplaintsSuggestionsViewController alloc] init];
    [self.navigationController pushViewController:suggesController animated:YES];
}
//生活服务
- (void) lifeService
{
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
//    [self.navigationItem setBackBarButtonItem:backItem];
//    LifeServiceViewController *lifeController = [[LifeServiceViewController alloc] init];
//    [self.navigationController pushViewController:lifeController animated:YES];
}
//缴费服务
- (void) billPayment
{
    
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
