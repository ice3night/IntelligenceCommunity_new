//
//  AboutUsViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/17.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setAboutStyle];
    [self initAboutController];
    
    
}
//设置样式
- (void) setAboutStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"关于我们";

}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}

//初始化控件
- (void) initAboutController
{
    //登录图标
    UIImageView *headImmage = [[UIImageView alloc] init];
    headImmage.image = [UIImage imageNamed:@"icon_logo_withbg"];
    [self.view addSubview:headImmage];
    [headImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.mas_equalTo((CYScreanH - 64) * 0.16);
         make.left.equalTo(self.view.mas_left).offset((CYScreanW - (CYScreanH - 64) * 0.15) / 2);
         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.03);
         make.height.mas_equalTo((CYScreanH - 64) * 0.17);
     }];
    //关于我们描述
    UILabel *label = [[UILabel alloc] init];
    label.text = @"瀧璟智慧社区:\n\n项目采用互联网思维，利用互联网、物联网、大数据、移动终端、智能楼宇以及微信、O2O、APP等技术，线上线下结合的综合一站式物业管理、社区采购、社区家政、社区医疗、社区理财、社区教育等服务，足不出户，尽享便捷生活。\n\n社区邻里：社区在线+圈层活动；社区商城：社区超市+社区微店+社区集市+社区团购\n\n社区理财：众筹凭条+理财产品；社区医疗：在线医疗+社区保健；\n\n社区家政：订餐+家政/陪护+洗衣/洗车+叫车/代驾/租车+装修/维修；\n\n社区教育：早教+补习+兴趣+手工；社区公益：义工活动+公益项目；\n\n社区赚钱：物业出租+社区创业/就业/兼职；物业服务：缴费+保修+通告";
    label.textColor = [UIColor colorWithRed:0.475 green:0.475 blue:0.475 alpha:1.00];
    label.font = [UIFont fontWithName:@"Arial" size:13];
    label.numberOfLines = 0;
    [label sizeToFit];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.03);
        make.right.equalTo(self.view.mas_right).offset(- CYScreanW * 0.03);
        make.top.equalTo(headImmage.mas_bottom).offset((CYScreanH - 64) * 0.02);
        
    }];
    //显示
    UILabel *showLabel = [[UILabel alloc] init];
    showLabel.text = @"Copyright ©2006-2016\n临沂盈彩物业管理有限公司";
    showLabel.textColor = [UIColor colorWithRed:0.475 green:0.475 blue:0.475 alpha:1.00];
    showLabel.font = [UIFont fontWithName:@"Arial" size:13];
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.numberOfLines = 0;
    [showLabel sizeToFit];
    [self.view addSubview:showLabel];
    [showLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.top.equalTo(label.mas_bottom).offset((CYScreanH - 64) * 0.05);
     }];
    
    
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
