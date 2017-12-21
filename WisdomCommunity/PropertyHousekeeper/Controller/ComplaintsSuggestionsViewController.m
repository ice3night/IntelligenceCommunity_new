//
//  ComplaintsSuggestionsViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ComplaintsSuggestionsViewController.h"
#import "ReLogin.h"
@interface ComplaintsSuggestionsViewController ()
@end

@implementation ComplaintsSuggestionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setSuggestionStyle];
    [self initSuggestionController];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}
//设置样式
- (void) setSuggestionStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"投诉建议";
}
//初始化控件
- (void) initSuggestionController
{
//    UILabel *typeTip = [[UILabel alloc] init];
//    typeTip.textColor = [UIColor colorWithRed:7/255.0 green:12/255.0 blue:15/255.0 alpha:1.0];
//    typeTip.textAlignment = NSTextAlignmentCenter;
//    typeTip.font =  [UIFont systemFontOfSize:16];
//    typeTip.textAlignment = NSTextAlignmentLeft;
//    typeTip.text = @"请选择投诉建议的类型*";
//    [self.view addSubview:typeTip];
//    [typeTip mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.02);          make.width.mas_equalTo(CYScreanW);
//         make.top.equalTo(self.view.mas_top).offset(10);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.03);
//     }];
//
//    UILabel *contentTip = [[UILabel alloc] init];
//    contentTip.textColor = [UIColor colorWithRed:7/255.0 green:12/255.0 blue:15/255.0 alpha:1.0];
//    contentTip.textAlignment = NSTextAlignmentCenter;
//    contentTip.font =  [UIFont systemFontOfSize:16];
//    contentTip.textAlignment = NSTextAlignmentLeft;
//    contentTip.text = @"请选择投诉建议的类型*";
//    [self.view addSubview:contentTip];
//    [contentTip mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.02);          make.width.mas_equalTo(CYScreanW);
//         make.top.equalTo(dropdownMenu.mas_bottom).offset(10);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.03);
//     }];
//
//    _contentField = [[UITextField alloc] init];
//    _contentField.layer.borderColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1].CGColor;
//    _contentField.layer.cornerRadius = 5.0f;
//    _contentField.layer.borderWidth = 1;
//    [self.view addSubview:_contentField];
//    [_contentField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.02);          make.width.mas_equalTo(CYScreanW);
//        make.top.equalTo(contentTip.mas_bottom).offset(10);
//        make.height.mas_equalTo((CYScreanH - 64) * 0.06);
//    }];
//    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
//    NSArray *promptArray = @[@"投诉人:",@"手  机:",@"投诉类型:",@"问题描述:"];
//    NSArray *iconArray = @[@"pro_repair_person",@"45user",@"icon_complaints_kinds",@"question_des"];
//    //
//    for (NSInteger i = 0; i < promptArray.count; i ++)
//    {
//        //图标
//        UIImageView *showImmage = [[UIImageView alloc] init];
//        showImmage.image = [UIImage imageNamed:iconArray[i]];
//        [self.view addSubview:showImmage];
//        [showImmage mas_makeConstraints:^(MASConstraintMaker *make)
//         {
//             make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.02);
//             make.width.mas_equalTo(CYScreanW * 0.045);
//             make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.045 + i * (CYScreanH - 64) * 0.08);
//             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
//         }];
//        //提示文字
//        UILabel *promptLabel = [[UILabel alloc] init];
//        promptLabel.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
//        promptLabel.textAlignment = NSTextAlignmentCenter;
//        promptLabel.font = font;
//        promptLabel.text = [NSString stringWithFormat:@"%@",promptArray[i]];
//        [self.view addSubview:promptLabel];
//        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
//         {
//             make.left.equalTo(showImmage.mas_right).offset(0);
//             make.width.mas_equalTo(CYScreanW * 0.23);
//             make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.03 + i * (CYScreanH - 64) * 0.08);
//             make.height.mas_equalTo((CYScreanH - 64) * 0.06);
//         }];
//    }
    
//    UIColor *graColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1.00];
//    //投诉人
//    _complaintsTextField = [[UITextField alloc] init];
//    _complaintsTextField.placeholder = @"请输入姓名";
//    _complaintsTextField.delegate = self;
//    _complaintsTextField.layer.cornerRadius = 5;
//    _complaintsTextField.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
//    _complaintsTextField.layer.borderWidth = 1;
//    _complaintsTextField.font = font;
//    _complaintsTextField.returnKeyType = UIReturnKeyDone;
//    _complaintsTextField.textColor = graColor;
//    _complaintsTextField.backgroundColor = [UIColor clearColor];
//    _complaintsTextField.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:_complaintsTextField];
//    [_complaintsTextField mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.3);
//         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
//         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.03);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
//     }];
//    //联系方式
//    _phoneSTextField = [[UITextField alloc] init];
//    _phoneSTextField.placeholder = @"请输入手机号";
//    _phoneSTextField.delegate = self;
//    _phoneSTextField.font = font;
//    _phoneSTextField.returnKeyType = UIReturnKeyDone;
//    _phoneSTextField.layer.cornerRadius = 5;
//    _phoneSTextField.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
//    _phoneSTextField.layer.borderWidth = 1;
//    _phoneSTextField.textColor = graColor;
//    _phoneSTextField.backgroundColor = [UIColor clearColor];
//    _phoneSTextField.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:_phoneSTextField];
//    [_phoneSTextField mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.3);
//         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
//         make.top.equalTo(_complaintsTextField.mas_bottom).offset((CYScreanH - 64) * 0.02);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
//     }];
//    //投诉类型
//    CGSize sizeP = [@"房屋设施" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
//    CGSize sizePImage = [UIImage imageNamed:@"icon_title_heart"].size;
//    self.typeButton = [[UIButton alloc] init];
//    [self.typeButton setTitle:@"房屋设施" forState:UIControlStateNormal];
//    [self.typeButton setImage:[UIImage imageNamed:@"icon_drop_down"] forState:UIControlStateNormal];
//    [self.typeButton setTitleColor:[UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00] forState:UIControlStateNormal];
//    self.typeButton.layer.cornerRadius = 5;
//    self.typeButton.titleLabel.font = font;
//    self.typeButton.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
//    self.typeButton.layer.borderWidth = 1;
//    self.typeButton.imageEdgeInsets = UIEdgeInsetsMake(0, sizeP.width, 0, - sizeP.width);
//    self.typeButton.titleEdgeInsets = UIEdgeInsetsMake(0, - sizePImage.width, 0, sizePImage.width);
//    [_typeButton addTarget:self action:@selector(selectTypeButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_typeButton];
//    [_typeButton mas_makeConstraints:^(MASConstraintMaker *make)
//    {
//        make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.3);
//        make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
//        make.top.equalTo(_phoneSTextField.mas_bottom).offset((CYScreanH - 64) * 0.02);
//        make.height.mas_equalTo((CYScreanH - 64) * 0.06);
//    }];
//    //问题描述
//    self.typeId = @"1";
//    _problemDescriptionTextView = [[UITextView alloc] init];
//    _problemDescriptionTextView.delegate = self;
//    _problemDescriptionTextView.layer.cornerRadius = 5;
//    _problemDescriptionTextView.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
//    _problemDescriptionTextView.layer.borderWidth = 1;
//    _problemDescriptionTextView.font = font;
//    _problemDescriptionTextView.returnKeyType = UIReturnKeyDone;
//    _problemDescriptionTextView.textColor = graColor;
//    _problemDescriptionTextView.backgroundColor = [UIColor clearColor];
//    _problemDescriptionTextView.textAlignment = NSTextAlignmentLeft;
//    [self.view addSubview:_problemDescriptionTextView];
//    [_problemDescriptionTextView mas_makeConstraints:^(MASConstraintMaker *make)
//    {
//        make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.3);
//        make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
//        make.top.equalTo(_typeButton.mas_bottom).offset((CYScreanH - 64) * 0.02);
//        make.height.mas_equalTo((CYScreanH - 64) * 0.2);
//    }];
//
//
//
//    //拍照
//    UIImageView *showImmage = [[UIImageView alloc] init];
//    showImmage.image = [UIImage imageNamed:@"icon_camera"];
//    showImmage.userInteractionEnabled = YES;
//    [self.view addSubview:showImmage];
//    [showImmage mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.02);
//         make.top.equalTo(_problemDescriptionTextView.mas_bottom).offset((CYScreanH - 64) * 0.125);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.15);
//         make.width.mas_equalTo((CYScreanH - 64) * 0.15);
//     }];
//    //添加单击手势防范
//    UITapGestureRecognizer *showImmageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleShowTap:)];
//    showImmageTap.numberOfTapsRequired = 1;
//    [showImmage addGestureRecognizer:showImmageTap];
//    //展示
//    self.showPictureImmage = [[UIImageView alloc] init];
//    self.showPictureImmage.image = [UIImage imageNamed:@"que_recline"];
//    self.showPictureImmage.userInteractionEnabled = YES;
//    [self.view addSubview:self.showPictureImmage];
//    [self.showPictureImmage mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(showImmage.mas_right).offset(CYScreanW * 0.18);
//         make.top.equalTo(_problemDescriptionTextView.mas_bottom).offset((CYScreanH - 64) * 0.05);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.3);
//         make.width.mas_equalTo(CYScreanW * 0.45);
//     }];
//    //添加单击手势防范
//    UITapGestureRecognizer *showImmageSHTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleComplaintsShTap:)];
//    showImmageSHTap.numberOfTapsRequired = 1;
//    [self.showPictureImmage addGestureRecognizer:showImmageSHTap];
//
//
//    //投诉
//    UIButton *complaintsButton = [[UIButton alloc] init];
//    [complaintsButton setTitle:@"立即投诉" forState:UIControlStateNormal];
//    [complaintsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    complaintsButton.layer.cornerRadius = 5;
//    complaintsButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
//    [complaintsButton addTarget:self action:@selector(RequestComplaints) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:complaintsButton];
//    [complaintsButton mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.02);
//         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
//         make.bottom.equalTo(self.view.mas_bottom).offset(-(CYScreanH - 64) * 0.06);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
//     }];
//    //提示
//    UIButton *promptButton = [[UIButton alloc] init];
//    [promptButton setTitle:@"有疑问请致电物业管理部门" forState:UIControlStateNormal];
//    [promptButton setTitleColor:[UIColor colorWithRed:0.639 green:0.635 blue:0.639 alpha:1.00] forState:UIControlStateNormal];
//    [promptButton setImage:[UIImage imageNamed:@"icon_pro_tel"] forState:UIControlStateNormal];
//    promptButton.backgroundColor = [UIColor clearColor];
//    [promptButton addTarget:self action:@selector(callPropertyPhone) forControlEvents:UIControlEventTouchUpInside];
//    promptButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
//    promptButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [self.view addSubview:promptButton];
//    [promptButton mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.width.mas_equalTo(CYScreanW);
//         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
//         make.top.equalTo(complaintsButton.mas_bottom).offset((CYScreanH - 64) * 0.01);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
//     }];
//
//
//    //展示图片
//    self.fullScreenImmage = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH)];
//    self.fullScreenImmage.userInteractionEnabled = YES;
//    [self.navigationController.view addSubview:self.fullScreenImmage];
//    self.fullScreenImmage.hidden = YES;
//    //添加单击手势防范
//    UITapGestureRecognizer *fullScreenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fullSceenTap:)];
//    fullScreenTap.numberOfTapsRequired = 1;
//    [self.fullScreenImmage addGestureRecognizer:fullScreenTap];
//
//    self.typeConplabtsArray = @[@"房屋设施",@"公共设施",@"服务评价"];
//    //房屋列表
//    self.typeComplaintsTableView = [[UITableView alloc] init];
//    self.typeComplaintsTableView.delegate = self;
//    self.typeComplaintsTableView.dataSource = self;
//    self.typeComplaintsTableView.layer.cornerRadius = 5;
//    self.typeComplaintsTableView.showsVerticalScrollIndicator = NO;
//    self.typeComplaintsTableView.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
//    self.typeComplaintsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    [self.view addSubview:self.typeComplaintsTableView];
//    [self.typeComplaintsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.3);
//        make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
//        make.top.equalTo(self.typeButton.mas_bottom).offset(0);
//        make.height.mas_equalTo((CYScreanH - 64) * 0.18);
//    }];
//    self.typeComplaintsTableView.hidden = YES;
}
//拨打电话
- (void) callPropertyPhone
{
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@", [CYSmallTools getDataStringKey:PROPERTYCPHONE]];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (CYScreanH - 64) * 0.06;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.typeConplabtsArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.typeConplabtsArray[indexPath.row]];
    
    return cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.typeComplaintsTableView.hidden = YES;
    self.typeId = [NSString stringWithFormat:@"%ld",indexPath.row];
    [self.typeButton setTitle:self.typeConplabtsArray[indexPath.row] forState:UIControlStateNormal];
    NSLog(@"点击了%@",self.typeConplabtsArray[indexPath.row]);
}
//  -- - - - -- -  -- - - - -- - - - -- - - - -- - - - -- - - - -- - 函数  -- - - - -- - - - -- - - - --- -- - - - -- -  -- - - - -- - - - -- - - - -- -
//点击查看类型
- (void) selectTypeButton:(UIButton *)sender
{
    if (self.typeComplaintsTableView.hidden == YES) {
        self.typeComplaintsTableView.hidden = NO;
    }
    else
        self.typeComplaintsTableView.hidden = YES;
    //释放第一响应身份
    [_phoneSTextField resignFirstResponder];
    [_problemDescriptionTextView resignFirstResponder];
}
//商品点击手势
-(void)handleShowTap:(UITapGestureRecognizer *)sender
{
    [self tapOpertationSet];
    
}
-(void)handleComplaintsShTap:(UITapGestureRecognizer *)sender
{
    NSLog(@"self.showPictureImmage.image = %@",self.showPictureImmage.image);
    
//    if (![UIImagePNGRepresentation(self.showPictureImmage.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"物业广告.jpg"])])//NSData比较图片
    if (self.fullScreenImmage.image)
    {
        self.fullScreenImmage.hidden = NO;
    }
    
}
-(void)fullSceenTap:(UITapGestureRecognizer *)sender
{
    self.fullScreenImmage.hidden = YES;
}
//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//屏幕点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_phoneSTextField resignFirstResponder];
    [_problemDescriptionTextView resignFirstResponder];
    self.typeComplaintsTableView.hidden = YES;
}
//内容将要发生改变编辑,编辑完使用return退出
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
//  -- - - - -- -  -- - - - -- - - - -- - - - -- - - - -- - - - -- - 拍照  -- - - - -- - - - -- - - - --- -- - - - -- -  -- - - - -- - - - -- - - - -- -
//响应函数
-(void)tapOpertationSet
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
            [self presentViewController:imagePickerController animated:YES completion:^{}];
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
    //设置图片显示
    [self.showPictureImmage setImage:savedImage];
    [self.fullScreenImmage setImage:savedImage];
    //上传图片 //异步加载
    [MBProgressHUD showLoadToView:self.view];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.comImageUrl = [CYLRDataReuest uploadImage:savedImage withView:self.view];
        NSLog(@"self.imageUrl = %@",self.comImageUrl);
    });
}
//IOS7都要调用方法，按取消按钮用该方法
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//投诉
- (void) RequestComplaints
{
    if (self.phoneSTextField.text.length && self.problemDescriptionTextView.text.length)
    {
        if (![CYWhetherPhone isValidPhone:self.phoneSTextField.text])
        {
            [MBProgressHUD showError:@"手机号格式不正确" ToView:self.view];
            return;
        }
        [MBProgressHUD showLoadToView:self.view];
        NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
        //数据请求   设置请求管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 拼接请求参数
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
        parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
        parames[@"comNo"]       =  [NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]];
//        parames[@"user"]        =  [NSString stringWithFormat:@"%@",self.complaintsTextField.text];//
        parames[@"phone"]       =  [NSString stringWithFormat:@"%@",self.phoneSTextField.text];
        parames[@"category"]    =  [NSString stringWithFormat:@"%@",self.typeId];//
        parames[@"reason"]      =  [NSString stringWithFormat:@"%@",self.problemDescriptionTextView.text];
        parames[@"imgAddress"]  =  [NSString stringWithFormat:@"%@",self.comImageUrl];
        NSLog(@"parames = %@",parames);
        //url
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/addComplain",POSTREQUESTURL];
        NSLog(@"requestUrl = %@",requestUrl);
        [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view];
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
                 NSLog(@"投诉成功");
                 [MBProgressHUD showError:@"提交成功" ToView:self.navigationController.view];
                 [self.navigationController popViewControllerAnimated:YES];
             }else{
                 [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
                 NSString *type = [JSON objectForKey:@"type"];
                 if ([type isEqualToString:@"1"]||[type isEqual:@"2"]) {
                     ReLogin *relogin = [[ReLogin alloc] init];
                     [self.navigationController presentViewController:relogin animated:YES completion:^{
                         
                     }];
                 }
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [MBProgressHUD hideHUDForView:self.view];
             [MBProgressHUD showError:@"加载出错" ToView:self.view];
             NSLog(@"请求失败:%@", error.description);
         }];
    }
    else
    {
        [MBProgressHUD showError:@"信息不完整" ToView:self.view];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
