//
//  SendActivityViewController.m
//  WisdomCommunity
//  邻里活动控制器里面 -> 中下部一个发布活动图标 -> 点击进入的一个发布活动控制器
//  Created by bridge on 16/12/15.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "SendActivityViewController.h"

@interface SendActivityViewController ()

@property (nonatomic, copy)NSString *nameEvent;//活动名称
@property (nonatomic, copy)NSString *dateTimer;//存储活动时间
@property (nonatomic, copy)NSString *address;//存储活动地址
@property (nonatomic, copy)NSString *activityCenter;//存储活动内容
@property (nonatomic, copy)NSString *imageAddress;//图片地址
@property (nonatomic, copy)NSString *comNo;
@property (nonatomic, strong)UIButton *launchedButton;
@property (nonatomic, strong)UIButton *endButton;
@property (nonatomic, strong)UIButton *beginButton;
@property (nonatomic, assign)BOOL isFirst;

@end

@implementation SendActivityViewController

- (void)viewDidLoad
{
    self.isFirst = YES;
    [super viewDidLoad];
    
    [self setSendAStyle];
    [self initSendAController];
    [self initPictureControllers];
    
}
//设置样式
- (void) setSendAStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"发布活动";

}
//初始化控件
- (void) initSendAController
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:13];
    //标题
    self.activityTitleTextField = [[UITextField alloc] init];
    self.activityTitleTextField.placeholder = @"#请输入活动名称#";
    self.activityTitleTextField.delegate = self;
    self.activityTitleTextField.returnKeyType = UIReturnKeyDone;
    self.activityTitleTextField.textColor = [UIColor colorWithRed:0.376 green:0.376 blue:0.376 alpha:1.00];
    self.activityTitleTextField.backgroundColor = [UIColor clearColor];
    self.activityTitleTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.activityTitleTextField];
    [self.activityTitleTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.03);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.02);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
     }];
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    segmentationImmage.backgroundColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
    [self.view addSubview:segmentationImmage];
    [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.bottom.equalTo(self.activityTitleTextField.mas_bottom).offset(0);
         make.height.mas_equalTo(1);
     }];
    //活动时间
    UIButton *timeButton = [[UIButton alloc] init];
    timeButton.titleLabel.font = font;
    [timeButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_bg"] forState:UIControlStateNormal];
    [timeButton setTitle:@"活动时间" forState:UIControlStateNormal];
    [timeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:timeButton];
    [timeButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.03);
         make.width.mas_equalTo(CYScreanW * 0.2);
         make.top.equalTo(segmentationImmage.mas_bottom).offset((CYScreanH - 64) * 0.02);
         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         
     }];
    //开始时间
    UIButton *beginButton = [[UIButton alloc] init];
    beginButton.titleLabel.font = font;
    [beginButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_bg_yellow"] forState:UIControlStateNormal];
    [beginButton setTitle:@"开始日期" forState:UIControlStateNormal];
    [beginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [beginButton addTarget:self action:@selector(selectTimeData) forControlEvents:UIControlEventTouchUpInside];
    self.beginButton = beginButton;
    [self.view addSubview:self.beginButton];
    [self.beginButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(timeButton.mas_right).offset(CYScreanW * 0.03);
         make.width.mas_equalTo(CYScreanW * 0.25);
         make.top.equalTo(segmentationImmage.mas_bottom).offset((CYScreanH - 64) * 0.02);
         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
     }];
    //结束日期
    UIButton *endButton = [[UIButton alloc] init];
    endButton.titleLabel.font = font;
    [endButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_bg"] forState:UIControlStateNormal];
    [endButton setTitle:@"结束日期" forState:UIControlStateNormal];
    [endButton addTarget:self action:@selector(endButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [endButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    endButton.userInteractionEnabled = NO;
    self.endButton = endButton;
    [self.view addSubview:self.endButton];
    [self.endButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(beginButton.mas_right).offset(CYScreanW * 0.05);
         make.width.mas_equalTo(CYScreanW * 0.25);
         make.top.equalTo(segmentationImmage.mas_bottom).offset((CYScreanH - 64) * 0.02);
         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
     }];
    //横线
    UIImageView *horizontalLineImmage = [[UIImageView alloc] init];
    horizontalLineImmage.image = [UIImage imageNamed:@"btn_activity_bg_yellow"];
    [self.view addSubview:horizontalLineImmage];
    [horizontalLineImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(beginButton.mas_right).offset(CYScreanW * 0.01);
         make.width.mas_equalTo(CYScreanW * 0.03);
         make.top.equalTo(segmentationImmage.mas_bottom).offset((CYScreanH - 64) * 0.04 - 1);
         make.height.mas_equalTo(2);
     }];
    //活动地点
    UIButton *adressButton = [[UIButton alloc] init];
    adressButton.titleLabel.font = font;
    [adressButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_bg"] forState:UIControlStateNormal];
    [adressButton setTitle:@"活动地点" forState:UIControlStateNormal];
    [adressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:adressButton];
    [adressButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.03);
         make.width.mas_equalTo(CYScreanW * 0.2);
         make.top.equalTo(beginButton.mas_bottom).offset((CYScreanH - 64) * 0.01);
         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
     }];
    //活动地点
    self.addressTextField = [[UITextField alloc] init];
    self.addressTextField.placeholder = @"请输入活动地点";
    self.addressTextField.delegate = self;
    self.addressTextField.font = [UIFont fontWithName:@"Arial" size:15];
    self.addressTextField.returnKeyType = UIReturnKeyDone;
    self.addressTextField.textColor = [UIColor colorWithRed:0.376 green:0.376 blue:0.376 alpha:1.00];
    self.addressTextField.backgroundColor = [UIColor clearColor];
    self.addressTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.addressTextField];
    [self.addressTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(timeButton.mas_right).offset(CYScreanW * 0.03);
         make.width.mas_equalTo(CYScreanW * 0.7);
         make.top.equalTo(beginButton.mas_bottom).offset((CYScreanH - 64) * 0.01);
         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
     }];
    //分割线
    UIImageView *segmentationTImmage = [[UIImageView alloc] init];
    segmentationTImmage.backgroundColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
    [self.view addSubview:segmentationTImmage];
    [segmentationTImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.top.equalTo(adressButton.mas_bottom).offset((CYScreanH - 64) * 0.02);
         make.height.mas_equalTo(1);
     }];
    self.uploadImageVArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 6; i ++) {
        [self.uploadImageVArray addObject:@""];
    }
    //活动内容
    self.activityTextView = [[UITextView alloc] init];
    self.activityTextView.textColor= [UIColor lightGrayColor];//设置提示内容颜色
    self.activityTextView.text=NSLocalizedString(@"请在这里输入活动内容~", nil);//提示语
    self.activityTextView.selectedRange = NSMakeRange(0,0) ;//光标起始位置
    self.activityTextView.delegate = self;
    self.activityTextView.font = [UIFont fontWithName:@"Arial" size:15];
    self.activityTextView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.activityTextView];
    [self.activityTextView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.03);
         make.right.equalTo(self.view.mas_right).offset(- CYScreanW * 0.03);
         make.top.equalTo(segmentationTImmage.mas_bottom).offset((CYScreanH - 64) * 0.01);
         make.height.mas_equalTo((CYScreanH - 64) /4);
     }];
    //分割线
    UIImageView *segmentationThImmage = [[UIImageView alloc] init];
    segmentationThImmage.backgroundColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
    [self.view addSubview:segmentationThImmage];
    [segmentationThImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.bottom.equalTo(self.activityTextView.mas_bottom).offset(0);
         make.height.mas_equalTo(1);
     }];
    
    self.launchedButton = [[UIButton alloc] init];
    self.launchedButton.alpha = 0.9;
    self.launchedButton.backgroundColor = TheMass_toneAttune;
    [self.launchedButton setTitle:@"发布" forState:UIControlStateNormal];
    [self.launchedButton addTarget:self action:@selector(launchedDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.launchedButton];
    [self.launchedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_offset(44);
    }];
    
    
}

- (void)endButtonDidClicked
{
    self.isFirst = NO;
    //隐藏键盘
    [self.activityTitleTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.activityTextView resignFirstResponder];
    //切换状态
    if (self.shadowView.hidden == YES)
    {
        self.shadowView.hidden = NO;
    }
    else
        self.shadowView.hidden = YES;
    
}

- (void) selectTimeData
{
    self.isFirst = YES;
    //隐藏键盘
    [self.activityTitleTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.activityTextView resignFirstResponder];
    //切换状态
    if (self.shadowView.hidden == YES)
    {
        self.shadowView.hidden = NO;
    }
    else
        self.shadowView.hidden = YES;
}
//图片控件
- (void) initPictureControllers
{
    
    //拍照
    self.showSPictureImage1 = [[UIImageView alloc] init];
    self.showSPictureImage1.image = [UIImage imageNamed:@"icon_insert_pic"];
    self.showSPictureImage1.backgroundColor = [UIColor clearColor];
    self.showSPictureImage1.userInteractionEnabled = YES;
    self.showSPictureImage1.tag = 1001;
    [self.view addSubview:self.showSPictureImage1];
    [self.showSPictureImage1 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.mas_equalTo(CYScreanW * 0.27);
         make.height.mas_equalTo((CYScreanH - 64) * 0.18);
         make.top.equalTo(self.activityTextView.mas_bottom).offset((CYScreanH - 64) * 0.05);
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
     }];
    //添加单击手势防范
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postPictureTap:)];
    leftTap.numberOfTapsRequired = 1;
    [self.showSPictureImage1 addGestureRecognizer:leftTap];
    //
    self.showSPictureImage2 = [[UIImageView alloc] init];
    self.showSPictureImage2.image = [UIImage imageNamed:@"icon_insert_pic"];
    self.showSPictureImage2.backgroundColor = [UIColor clearColor];
    self.showSPictureImage2.userInteractionEnabled = YES;
    self.showSPictureImage2.tag = 1002;
    [self.view addSubview:self.showSPictureImage2];
    [self.showSPictureImage2 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.and.height.top.equalTo(self.showSPictureImage1);
         make.left.equalTo(self.showSPictureImage1.mas_right).offset(CYScreanW * 0.045);
     }];
    //添加单击手势防范
    UITapGestureRecognizer *leftTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postPictureTap:)];
    leftTap2.numberOfTapsRequired = 1;
    [self.showSPictureImage2 addGestureRecognizer:leftTap2];
    //
    self.showSPictureImage3 = [[UIImageView alloc] init];
    self.showSPictureImage3.image = [UIImage imageNamed:@"icon_insert_pic"];
    self.showSPictureImage3.backgroundColor = [UIColor clearColor];
    self.showSPictureImage3.userInteractionEnabled = YES;
    self.showSPictureImage3.tag = 1003;
    [self.view addSubview:self.showSPictureImage3];
    [self.showSPictureImage3 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.and.height.top.equalTo(self.showSPictureImage1);
         make.left.equalTo(self.showSPictureImage2.mas_right).offset(CYScreanW * 0.045);
     }];
    //添加单击手势防范
    UITapGestureRecognizer *leftTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postPictureTap:)];
    leftTap3.numberOfTapsRequired = 1;
    [self.showSPictureImage3 addGestureRecognizer:leftTap3];
    //
    self.showSPictureImage4 = [[UIImageView alloc] init];
    self.showSPictureImage4.image = [UIImage imageNamed:@"icon_insert_pic"];
    self.showSPictureImage4.backgroundColor = [UIColor clearColor];
    self.showSPictureImage4.userInteractionEnabled = YES;
    self.showSPictureImage4.tag = 1004;
    [self.view addSubview:self.showSPictureImage4];
    [self.showSPictureImage4 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.mas_equalTo(CYScreanW * 0.27);
         make.height.mas_equalTo((CYScreanH - 64) * 0.18);
         make.top.equalTo(self.showSPictureImage1.mas_bottom).offset((CYScreanH - 64) * 0.01);
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
     }];
    //添加单击手势防范
    UITapGestureRecognizer *leftTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postPictureTap:)];
    leftTap4.numberOfTapsRequired = 1;
    [self.showSPictureImage4 addGestureRecognizer:leftTap4];
    //
    self.showSPictureImage5 = [[UIImageView alloc] init];
    self.showSPictureImage5.image = [UIImage imageNamed:@"icon_insert_pic"];
    self.showSPictureImage5.backgroundColor = [UIColor clearColor];
    self.showSPictureImage5.userInteractionEnabled = YES;
    self.showSPictureImage5.tag = 1005;
    [self.view addSubview:self.showSPictureImage5];
    [self.showSPictureImage5 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.and.height.top.equalTo(self.showSPictureImage4);
         make.left.equalTo(self.showSPictureImage4.mas_right).offset(CYScreanW * 0.045);
     }];
    //添加单击手势防范
    UITapGestureRecognizer *leftTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postPictureTap:)];
    leftTap5.numberOfTapsRequired = 1;
    [self.showSPictureImage5 addGestureRecognizer:leftTap5];
    
    self.showSPictureImage6 = [[UIImageView alloc] init];
    self.showSPictureImage6.image = [UIImage imageNamed:@"icon_insert_pic"];
    self.showSPictureImage6.backgroundColor = [UIColor clearColor];
    self.showSPictureImage6.userInteractionEnabled = YES;
    self.showSPictureImage6.tag = 1006;
    [self.view addSubview:self.showSPictureImage6];
    [self.showSPictureImage6 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.and.height.top.equalTo(self.showSPictureImage4);
         make.left.equalTo(self.showSPictureImage5.mas_right).offset(CYScreanW * 0.045);     }];
    //添加单击手势防范
    UITapGestureRecognizer *leftTap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postPictureTap:)];
    leftTap6.numberOfTapsRequired = 1;
    [self.showSPictureImage6 addGestureRecognizer:leftTap6];
    
    //背景
    self.shadowView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH)];
    self.shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.shadowView.userInteractionEnabled = YES;
    [self.view addSubview:self.shadowView];
    self.shadowView.hidden = YES;
    //日历
    self.dataSendView = [[CYDataView alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.21, CYScreanW * 0.9, (CYScreanH - 64) * 0.65)];
    self.dataSendView.layer.borderColor = [UIColor colorWithRed:0.812 green:0.812 blue:0.812 alpha:1.00].CGColor;
    self.dataSendView.layer.borderWidth = 1;
    self.dataSendView.backgroundColor = [UIColor colorWithRed:0.294 green:0.533 blue:0.871 alpha:1.00];
    __weak typeof(self)weakSelf = self;
    self.dataSendView.dateBlock = ^(NSString *date){
        if (weakSelf.isFirst == YES) {
            NSDate *dateda = [NSDate date]; // 获得时间对象
            NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
            [forMatter setDateFormat:@"yyyy-MM-dd"];
            
            NSString *nowdata = [forMatter stringFromDate:dateda];
            NSLog(@"dateStr = %@,date = %@",weakSelf.begindata,date);
            if ([[CYSmallTools compareOneDay:nowdata withAnotherDay:date] isEqualToString:@"1"]) {
                [MBProgressHUD showError:@"开始日期不能小于今天" ToView:weakSelf.view];
            }else{
                weakSelf.begindata = date;
                weakSelf.dateTimer = date;
                weakSelf.shadowView.hidden = YES;
                [weakSelf.beginButton setTitle:date forState:UIControlStateNormal];
                weakSelf.endButton.userInteractionEnabled = YES;
            }
        }else{
            if ([[CYSmallTools compareOneDay:weakSelf.begindata withAnotherDay:date] isEqualToString:@"1"]) {
                [MBProgressHUD showError:@"结束日期不能小于开始日期" ToView:weakSelf.view];
            }else{
                weakSelf.dateTimer = [NSString stringWithFormat:@"%@~%@",weakSelf.dateTimer,date];
                weakSelf.shadowView.hidden = YES;
                [weakSelf.endButton setTitle:date forState:UIControlStateNormal];
            }
            
        
        }
    };
    [self.shadowView addSubview:self.dataSendView];

}
//背景隐藏
-(void) postShadowTap:(UITapGestureRecognizer *)sender
{
    self.shadowView.hidden = YES;
}
//拍照
-(void) postPictureTap:(UITapGestureRecognizer *)sender
{
    if (sender.view == self.showSPictureImage1)
    {
        self.sendAClickPictureInt = 1101;
    }
    else if (sender.view == self.showSPictureImage2)
    {
        self.sendAClickPictureInt = 1102;
    }
    else if (sender.view == self.showSPictureImage3)
    {
        self.sendAClickPictureInt = 1103;
    }
    else if (sender.view == self.showSPictureImage4)
    {
        self.sendAClickPictureInt = 1104;
    }
    else if (sender.view == self.showSPictureImage5)
    {
        self.sendAClickPictureInt = 1105;
    }
    else if (sender.view == self.showSPictureImage6)
    {
        self.sendAClickPictureInt = 1106;
    }
    [self tapSOpertationSet];
}
// - - -- - -- -  -- - - - - -- - - -textField或者textView代理 - -- - - - -- - - -- - - -- - - -- - - -- -
//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    self.shadowView.hidden = YES;
    return YES;
}
//屏幕点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.activityTitleTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.activityTextView resignFirstResponder];
    self.shadowView.hidden = YES;
}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.textColor==[UIColor lightGrayColor]
        &&[textView.text isEqualToString:NSLocalizedString(@"请在这里输入活动内容~", nil)]
        )//如果是提示内容，光标放置开始位置
    {
        NSRange range;
        range.location = 0;
        range.length = 0;
        textView.selectedRange = range;
    }else if(textView.textColor==[UIColor lightGrayColor])//中文输入键盘
    {
        NSString *placeholder=NSLocalizedString(@"请在这里输入活动内容~", nil);
        textView.textColor=[UIColor blackColor];
        textView.text=[textView.text substringWithRange:NSMakeRange(0, textView.text.length- placeholder.length)];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if (![text isEqualToString:@""]&&textView.textColor==[UIColor lightGrayColor])//如果不是delete响应,当前是提示信息，修改其属性
    {
        textView.text=@"";//置空
        textView.textColor=[UIColor blackColor];
    }
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.textColor=[UIColor lightGrayColor];
        textView.text=NSLocalizedString(@"请在这里输入活动内容~", nil);
    }
}
//开始编辑
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.shadowView.hidden = YES;
    NSLog(@"textViewShouldBeginEditing");
    return YES;
}
//  -- - - - -- -  -- - - - -- - - - -- - - - -- - - - -- - - - -- - 拍照  -- - - - -- - - - -- - - - --- -- - - - -- -  -- - - - -- - - - -- - - - -- -
//响应函数
-(void)tapSOpertationSet
{
    if (IOS7)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        //判断是否支持相机，模拟器没有相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                            {
                                                //相机
                                                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                                                imagePickerController.delegate = self;
                                                imagePickerController.allowsEditing = YES;
                                                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                [self presentViewController:imagePickerController animated:YES completion:^{}];
                                            }];
            [alertController addAction:defaultAction];
        }
        UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相册
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerController animated:YES completion:^{
                imagePickerController.delegate = self;
            }];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                                       {
                                           
                                       }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:defaultAction1];
        //弹出试图，使用UIViewController的方法
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        UIActionSheet *sheet;
        //判断是否支持相机，模拟器没有相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            sheet = [[UIActionSheet alloc] initWithTitle:@"获取图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        }
        else
        {
            sheet = [[UIActionSheet alloc] initWithTitle:@"获取图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        }
        [sheet showInView:self.view];
    }
    
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger sourctType = 0;
    //判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        switch (buttonIndex) {
            case 1:
                sourctType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 2:
                sourctType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            default:
                break;
        }
    }
    else
    {
        if (buttonIndex == 1)
        {
            sourctType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    //跳转到相机或者相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourctType;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
    
}
//保存图片
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1);//1为不缩放保存,取值（0.0-1.0）
    //获取沙沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    //将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}
//IOS7以上的都要调用方法，选择完成后调用该方法
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //保存图片至本地，上传图片到服务器需要使用
    [self saveImage:image withName:@"avatar.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"avatar.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //    //设置图片显示
    //    [self.showPictureImmage setImage:savedImage];
    //    [self.fullScreenImmage setImage:savedImage];
    if (self.sendAClickPictureInt == 1101 )
    {
        [self.showSPictureImage1 setImage:savedImage];
    }
    else if (self.sendAClickPictureInt == 1102)
    {
        [self.showSPictureImage2 setImage:savedImage];
    }
    else if (self.sendAClickPictureInt == 1103)
    {
        [self.showSPictureImage3 setImage:savedImage];
    }
    else if (self.sendAClickPictureInt == 1104)
    {
        [self.showSPictureImage4 setImage:savedImage];
    }
    else if (self.sendAClickPictureInt == 1105)
    {
        [self.showSPictureImage5 setImage:savedImage];
    }
    else if (self.sendAClickPictureInt == 1106)
    {
        [self.showSPictureImage6 setImage:savedImage];
    }
    //上传图片 //异步加载
    [MBProgressHUD showLoadToView:self.view];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self uploadImage:savedImage withInt:(self.sendAClickPictureInt - 1101)];
    });
    
    
}
//IOS7都要调用方法，按取消按钮用该方法
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 点击发布按钮
- (void)launchedDidClicked:(UIButton *)sender
{
    self.nameEvent = self.activityTitleTextField.text;
    self.address = self.addressTextField.text;
    self.activityCenter = self.activityTextView.text;
    
    
    if ([self.dateTimer isEqualToString:@""] || self.dateTimer == nil) {
        [MBProgressHUD showError:@"活动日期不能为空" ToView:self.view];
        return;
    }
    if (self.dateTimer.length < 10) {
        [MBProgressHUD showError:@"正确选择开始日期,结束日期" ToView:self.view];
        return;
    }
    
    if ([self.nameEvent isEqualToString:@""] || self.nameEvent == nil ) {
        [MBProgressHUD showError:@"活动名称不能为空" ToView:self.view];
        return;
    }
    if ([self.address isEqualToString:@""] || self.address == nil) {
        [MBProgressHUD showError:@"活动地址不能为空" ToView:self.view];
        return;
    }
    if ([self.activityCenter isEqualToString:@""] || self.activityCenter == nil) {
        [MBProgressHUD showError:@"活动内容不能为空" ToView:self.view];
        return;
    }
    for (NSString *str in self.uploadImageVArray) {
        if (str.length > 6) {
            if (self.imageAddress.length <= 6) {
                self.imageAddress = [NSString stringWithFormat:@"%@",str];
            }else{
                self.imageAddress = [NSString stringWithFormat:@"%@,%@",self.imageAddress,str];
            }
        }
    }
    
    [self LaunchedCampaignRequest];
    
}


#pragma mark 发起活动网络请求(先上传图片)
- (void)LaunchedCampaignRequest
{
    if ([ActivityDetailsTools stringContainsEmoji:_address]) {
        [MBProgressHUD showError:@"活动地点输入不合法" ToView:self.view];
        return;
    }
    //个人数据
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
    [parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    [parames setObject:[ActivityDetailsTools StrTurnToUTF:self.nameEvent] forKey:@"title"];
    [parames setObject:_dateTimer forKey:@"acTime"];
    [parames setObject:_address forKey:@"address"];
    [parames setObject:@"1" forKey:@"flag"];
    [parames setObject:[ActivityDetailsTools StrTurnToUTF:_activityCenter] forKey:@"content"];
    if (![self.imageAddress isEqualToString:@""] && self.imageAddress != nil) {
        [parames setObject:_imageAddress forKey:@"imgAddress"];
    }
    [parames setObject:[NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]] forKey:@"comNo"];
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/activity/addActivity",POSTREQUESTURL];
    NSLog(@"parames = %@",parames);
    [MBProgressHUD showLoadToView:self.view];
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@", JSON);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSLog(@"请求成功");
             [MBProgressHUD showError:@"发布成功" ToView:self.navigationController.view];
             [self.navigationController popViewControllerAnimated:YES];
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
    
}


#pragma mark 图片上传请求
//上传图片
- (void) uploadImage:(UIImage *)image withInt:(NSInteger)index
{
    NSString *postUrl = [NSString stringWithFormat:@"%@/api/upload/uploadImg",POSTREQUESTURL];
    NSLog(@"postUrl = %@",postUrl);
    NSData *imageData;
    imageData = UIImageJPEGRepresentation(image, 0.1);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"account" forKey:@"12345678912"];
    [manager POST:postUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //使用日期生成图片名称
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        //二进制文件，接口key值，文件路径，图片格式
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"请求成功:%@", responseObject);
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            [self.uploadImageVArray replaceObjectAtIndex:index withObject:[[JSON objectForKey:@"param"] objectForKey:@"url"]];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"加载出错" ToView:self.view];
        NSLog(@"请求失败:%@", error.description);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
