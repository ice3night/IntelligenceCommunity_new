//
//  SendPostViewController.m
//  WisdomCommunity
// 帖子控制器里面 -> 中下部一个发帖图标 -> 点击进入的一个发帖控制器
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "SendPostViewController.h"

@interface SendPostViewController ()

@end

@implementation SendPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setSPosetStyle];
    [self initSPosetController];
}
//设置样式
- (void) setSPosetStyle
{
    //样式
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"发帖";
    self.mTableView = [[UITableView alloc] init];
    self.mTableView.frame = CGRectMake(0, 0, CYScreanW, CYScreanH);
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}
//初始化控件
- (void) initSPosetController
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    //标题
    self.postTitleTextField = [[UITextField alloc] init];
    self.postTitleTextField.placeholder = @"#请输入主题名称#";
    self.postTitleTextField.delegate = self;
    self.postTitleTextField.returnKeyType = UIReturnKeyDone;
    self.postTitleTextField.textColor = [UIColor colorWithRed:0.376 green:0.376 blue:0.376 alpha:1.00];
    self.postTitleTextField.backgroundColor = [UIColor clearColor];
    self.postTitleTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.postTitleTextField];
    [self.postTitleTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.03);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.01);
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
         make.bottom.equalTo(self.postTitleTextField.mas_bottom).offset(0);
         make.height.mas_equalTo(1);
     }];
    //帖子内容
    self.postContentTextView = [[UITextView alloc] init];
    self.postContentTextView.textColor= [UIColor lightGrayColor];//设置提示内容颜色
    self.postContentTextView.text=NSLocalizedString(@"想说就说，写下这一刻所想", nil);//提示语
    self.postContentTextView.selectedRange = NSMakeRange(0,0) ;//光标起始位置
    self.postContentTextView.delegate = self;
    self.postContentTextView.font = [UIFont fontWithName:@"Arial" size:17];
    self.postContentTextView.backgroundColor = [UIColor clearColor];
//    self.postContentTextView.textColor = [UIColor colorWithRed:0.769 green:0.769 blue:0.769 alpha:1.00];
    [self.view addSubview:self.postContentTextView];
    [self.postContentTextView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.and.right.equalTo(self.postTitleTextField);
         make.top.equalTo(segmentationImmage.mas_bottom).offset((CYScreanH - 64) * 0.02);
         make.height.mas_equalTo((CYScreanH - 64) * 0.25);
     }];
    //分割线
    UIImageView *segmentationImmage2 = [[UIImageView alloc] init];
    segmentationImmage2.backgroundColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
    [self.view addSubview:segmentationImmage2];
    [segmentationImmage2 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.bottom.equalTo(self.postContentTextView.mas_bottom).offset(0);
         make.height.mas_equalTo(1);
     }];
    //图片数组
    self.uploadImageVArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 6; i ++) {
        [self.uploadImageVArray addObject:@""];
    }
    //拍照
    self.showPictureImage1 = [[UIImageView alloc] init];
    self.showPictureImage1.image = [UIImage imageNamed:@"icon_insert_pic"];
    self.showPictureImage1.backgroundColor = [UIColor clearColor];
    self.showPictureImage1.userInteractionEnabled = YES;
    self.showPictureImage1.tag = 1001;
    [self.view addSubview:self.showPictureImage1];
    [self.showPictureImage1 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.mas_equalTo(CYScreanW * 0.27);
         make.height.mas_equalTo((CYScreanH - 64) * 0.18);
         make.top.equalTo(segmentationImmage2.mas_bottom).offset((CYScreanH - 64) * 0.01);
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
     }];
    //添加单击手势防范
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postPictureTap:)];
    leftTap.numberOfTapsRequired = 1;
    [self.showPictureImage1 addGestureRecognizer:leftTap];
    //
    self.showPictureImage2 = [[UIImageView alloc] init];
    self.showPictureImage2.image = [UIImage imageNamed:@"icon_insert_pic"];
    self.showPictureImage2.backgroundColor = [UIColor clearColor];
    self.showPictureImage2.userInteractionEnabled = YES;
    self.showPictureImage2.tag = 1002;
    [self.view addSubview:self.showPictureImage2];
    [self.showPictureImage2 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.and.height.top.equalTo(self.showPictureImage1);
         make.left.equalTo(self.showPictureImage1.mas_right).offset(CYScreanW * 0.045);
     }];
    //添加单击手势防范
    UITapGestureRecognizer *leftTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postPictureTap:)];
    leftTap2.numberOfTapsRequired = 1;
    [self.showPictureImage2 addGestureRecognizer:leftTap2];
    //
    self.showPictureImage3 = [[UIImageView alloc] init];
    self.showPictureImage3.image = [UIImage imageNamed:@"icon_insert_pic"];
    self.showPictureImage3.backgroundColor = [UIColor clearColor];
    self.showPictureImage3.userInteractionEnabled = YES;
    self.showPictureImage3.tag = 1003;
    [self.view addSubview:self.showPictureImage3];
    [self.showPictureImage3 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.and.height.top.equalTo(self.showPictureImage1);
         make.left.equalTo(self.showPictureImage2.mas_right).offset(CYScreanW * 0.045);
     }];
    //添加单击手势防范
    UITapGestureRecognizer *leftTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postPictureTap:)];
    leftTap3.numberOfTapsRequired = 1;
    [self.showPictureImage3 addGestureRecognizer:leftTap3];
    //
    self.showPictureImage4 = [[UIImageView alloc] init];
    self.showPictureImage4.image = [UIImage imageNamed:@"icon_insert_pic"];
    self.showPictureImage4.backgroundColor = [UIColor clearColor];
    self.showPictureImage4.userInteractionEnabled = YES;
    self.showPictureImage4.tag = 1004;
    [self.view addSubview:self.showPictureImage4];
    [self.showPictureImage4 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.mas_equalTo(CYScreanW * 0.27);
         make.height.mas_equalTo((CYScreanH - 64) * 0.18);
         make.top.equalTo(self.showPictureImage1.mas_bottom).offset((CYScreanH - 64) * 0.01);
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
     }];
    //添加单击手势防范
    UITapGestureRecognizer *leftTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postPictureTap:)];
    leftTap4.numberOfTapsRequired = 1;
    [self.showPictureImage4 addGestureRecognizer:leftTap4];
    //
    self.showPictureImage5 = [[UIImageView alloc] init];
    self.showPictureImage5.image = [UIImage imageNamed:@"icon_insert_pic"];
    self.showPictureImage5.backgroundColor = [UIColor clearColor];
    self.showPictureImage5.userInteractionEnabled = YES;
    self.showPictureImage5.tag = 1005;
    [self.view addSubview:self.showPictureImage5];
    [self.showPictureImage5 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.and.height.top.equalTo(self.showPictureImage4);
         make.left.equalTo(self.showPictureImage4.mas_right).offset(CYScreanW * 0.045);
     }];
    //添加单击手势防范
    UITapGestureRecognizer *leftTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postPictureTap:)];
    leftTap5.numberOfTapsRequired = 1;
    [self.showPictureImage5 addGestureRecognizer:leftTap5];
    
    self.showPictureImage6 = [[UIImageView alloc] init];
    self.showPictureImage6.image = [UIImage imageNamed:@"icon_insert_pic"];
    self.showPictureImage6.backgroundColor = [UIColor clearColor];
    self.showPictureImage6.userInteractionEnabled = YES;
    self.showPictureImage6.tag = 1006;
    [self.view addSubview:self.showPictureImage6];
    [self.showPictureImage6 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.and.height.top.equalTo(self.showPictureImage4);
         make.left.equalTo(self.showPictureImage5.mas_right).offset(CYScreanW * 0.045);     }];
    //添加单击手势防范
    UITapGestureRecognizer *leftTap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postPictureTap:)];
    leftTap6.numberOfTapsRequired = 1;
    [self.showPictureImage6 addGestureRecognizer:leftTap6];
    //发布
    UIButton *sendButton = [[UIButton alloc] init];
    [sendButton setTitle:@"发布" forState:UIControlStateNormal];
    sendButton.alpha = 0.9;
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendButton.backgroundColor = TheMass_toneAttune;
    [sendButton addTarget:self action:@selector(sendPostButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.mas_equalTo(CYScreanW);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.bottom.equalTo(self.view.mas_bottom).offset(0);
         make.height.mas_equalTo((CYScreanH - 64) * 0.08);
     }];
    //集市
    self.bazaarButton = [[UIButton alloc] init];
    [self.bazaarButton setTitle:@"热点" forState:UIControlStateNormal];
    self.bazaarButton.titleLabel.font = font;
    [self.bazaarButton setTitleColor:[UIColor colorWithRed:0.416 green:0.416 blue:0.416 alpha:1.00] forState:UIControlStateNormal];
    [self.bazaarButton setTitleColor:[UIColor colorWithRed:0.00 green:0.333 blue:0.741 alpha:1.00] forState:UIControlStateSelected];
    self.bazaarButton.backgroundColor = [UIColor clearColor];
    [self.bazaarButton addTarget:self action:@selector(LabelSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bazaarButton];
    [self.bazaarButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.mas_equalTo(CYScreanW * 0.15);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.bottom.equalTo(sendButton.mas_top).offset(-(CYScreanH - 64) * 0.02);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
     }];
    self.bazaarButton.selected = NO;
    //分享
    self.shareButton = [[UIButton alloc] init];
    [self.shareButton setTitle:@"分享" forState:UIControlStateNormal];
    self.shareButton.titleLabel.font = font;
    [self.shareButton setTitleColor:[UIColor colorWithRed:0.416 green:0.416 blue:0.416 alpha:1.00] forState:UIControlStateNormal];
    [self.shareButton setTitleColor:[UIColor colorWithRed:0.00 green:0.333 blue:0.741 alpha:1.00] forState:UIControlStateSelected];
    self.shareButton.backgroundColor = [UIColor clearColor];
    [self.shareButton addTarget:self action:@selector(LabelSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shareButton];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.and.height.and.bottom.equalTo(self.bazaarButton);
         make.right.equalTo(self.bazaarButton.mas_left).offset(0);
     }];
    self.shareButton.selected = NO;
    //最新
    self.hotButton = [[UIButton alloc] init];
    self.hotButton.titleLabel.font = font;
    [self.hotButton setTitle:@"最新" forState:UIControlStateNormal];
    [self.hotButton setTitleColor:[UIColor colorWithRed:0.416 green:0.416 blue:0.416 alpha:1.00] forState:UIControlStateNormal];
    [self.hotButton setTitleColor:[UIColor colorWithRed:0.00 green:0.333 blue:0.741 alpha:1.00] forState:UIControlStateSelected];
    self.hotButton.backgroundColor = [UIColor clearColor];
    [self.hotButton addTarget:self action:@selector(LabelSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.hotButton];
    [self.hotButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.and.height.and.bottom.equalTo(self.bazaarButton);
         make.right.equalTo(self.shareButton.mas_left).offset(0);
     }];
    self.hotButton.selected = YES;
    self.PostLabelStr = @"1";
    
    //标签图标
    UIImageView *labelImmage = [[UIImageView alloc] init];
    labelImmage.image = [UIImage imageNamed:@"icon_post_label"];
    labelImmage.userInteractionEnabled = YES;
    [self.view addSubview:labelImmage];
    [labelImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(self.hotButton.mas_left).offset(0);
         make.bottom.equalTo(sendButton.mas_top).offset(-(CYScreanH - 64) * 0.035);
         make.height.mas_equalTo((CYScreanH - 64) * 0.03);
         make.width.mas_equalTo((CYScreanH - 64) * 0.03);
     }];
}
//标签按钮
- (void) LabelSelectButton:(UIButton *)sender
{
    if (sender == self.hotButton)
    {
        self.hotButton.selected    = YES;
        self.shareButton.selected  = NO;
        self.bazaarButton.selected = NO;
        self.PostLabelStr = @"1";
    }
    else if (sender == self.shareButton)
    {
        self.hotButton.selected    = NO;
        self.shareButton.selected  = YES;
        self.bazaarButton.selected = NO;
        self.PostLabelStr = @"2";
    }
    else
    {
        self.hotButton.selected    = NO;
        self.shareButton.selected  = NO;
        self.bazaarButton.selected = YES;
        self.PostLabelStr = @"3";
    }
}

//拍照
-(void) postPictureTap:(UITapGestureRecognizer *)sender
{
    //放弃第一响应身份
    [self.postTitleTextField resignFirstResponder];
    [self.postContentTextView resignFirstResponder];
    
    if (sender.view == self.showPictureImage1)
    {
        self.ClickPictureInt = 1001;
    }
    else if (sender.view == self.showPictureImage2)
    {
        self.ClickPictureInt = 1002;
    }
    else if (sender.view == self.showPictureImage3)
    {
        self.ClickPictureInt = 1003;
    }
    else if (sender.view == self.showPictureImage4)
    {
        self.ClickPictureInt = 1004;
    }
    else if (sender.view == self.showPictureImage5)
    {
        self.ClickPictureInt = 1005;
    }
    else if (sender.view == self.showPictureImage6)
    {
        self.ClickPictureInt = 1006;
    }
    [self tapOpertationSet];
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
    [self.postTitleTextField resignFirstResponder];
}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.textColor==[UIColor lightGrayColor]
        &&[textView.text isEqualToString:NSLocalizedString(@"想说就说，写下这一刻所想", nil)]
        )//如果是提示内容，光标放置开始位置
    {
        NSRange range;
        range.location = 0;
        range.length = 0;
        textView.selectedRange = range;
    }else if(textView.textColor==[UIColor lightGrayColor])//中文输入键盘
    {
        NSString *placeholder=NSLocalizedString(@"想说就说，写下这一刻所想", nil);
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
        textView.text=NSLocalizedString(@"想说就说，写下这一刻所想", nil);
    }
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
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
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
//    //设置图片显示
//    [self.showPictureImmage setImage:savedImage];
//    [self.fullScreenImmage setImage:savedImage];
    if (self.ClickPictureInt == 1001 )
    {
        [self.showPictureImage1 setImage:savedImage];
    }
    else if (self.ClickPictureInt == 1002)
    {
        [self.showPictureImage2 setImage:savedImage];
    }
    else if (self.ClickPictureInt == 1003)
    {
        [self.showPictureImage3 setImage:savedImage];
    }
    else if (self.ClickPictureInt == 1004)
    {
        [self.showPictureImage4 setImage:savedImage];
    }
    else if (self.ClickPictureInt == 1005)
    {
        [self.showPictureImage5 setImage:savedImage];
    }
    else if (self.ClickPictureInt == 1006)
    {
        [self.showPictureImage6 setImage:savedImage];
    }
    NSLog(@"self.ClickPictureInt = %ld",self.ClickPictureInt);
    //上传图片 //异步加载
    [MBProgressHUD showLoadToView:self.view];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self uploadImage:savedImage withInt:(self.ClickPictureInt - 1001)];
    });
    
}
//上传图片
- (void) uploadImage:(UIImage *)image withInt:(NSInteger)index
{
    NSString *postUrl = [NSString stringWithFormat:@"%@/api/upload/uploadImg",POSTREQUESTURL];
    NSData *imageData;
    imageData = UIImageJPEGRepresentation(image, 0.1);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"account" forKey:@"12345678912"];
    [manager POST:postUrl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
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
//IOS7都要调用方法，按取消按钮用该方法
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//发布帖子
- (void) sendPostButton
{
    if (self.postTitleTextField.text.length && self.postContentTextView.text.length)
    {
        [MBProgressHUD showLoadToView:self.view];
        NSLog(@"self.uploadImageVArray = %@",self.uploadImageVArray);
        NSString *imageString;
        for (NSString *string in self.uploadImageVArray)
        {
            if (string.length > 6)//不为空
            {
                if (imageString.length) {
                    imageString = [NSString stringWithFormat:@"%@,%@",imageString,string];
                }
                else
                    imageString = [NSString stringWithFormat:@"%@",string];
            }
        }
        //个人数据
        NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
        //数据请求   设置请求管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 拼接请求参数
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
        parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
        parames[@"title"]       =  [NSString stringWithFormat:@"%@",[ActivityDetailsTools StrTurnToUTF:self.postTitleTextField.text]];
        parames[@"content"]     =  [NSString stringWithFormat:@"%@",[ActivityDetailsTools StrTurnToUTF:self.postContentTextView.text]];
        parames[@"category"]    =  [NSString stringWithFormat:@"%@",self.PostLabelStr];
        parames[@"imgAddress"]  =  imageString;
        parames[@"comNo"]       =  [NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]];
        NSLog(@"parames = %@",parames);
        //url
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/addNote",POSTREQUESTURL];
        NSLog(@"requestUrl = %@",requestUrl);
        [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view];
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
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
    else
        [MBProgressHUD showError:@"信息不完整" ToView:self.view];
}


@end
