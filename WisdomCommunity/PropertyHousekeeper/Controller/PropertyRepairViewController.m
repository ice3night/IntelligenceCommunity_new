//
//  PropertyRepairViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "PropertyRepairViewController.h"
#import "ReLogin.h"
@interface PropertyRepairViewController ()

@end

@implementation PropertyRepairViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setRepairStyle];
    [self initRepairController];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}
//设置样式
- (void) setRepairStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"物业报修";

}
//初始化控件
- (void) initRepairController
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    NSArray *promptArray = @[@"报修人:",@"手  机:",@"楼宇号:",@"问题描述:"];
    NSArray *iconArray = @[@"pro_repair_person",@"56user",@"building_number",@"question_des"];
    //
    for (NSInteger i = 0; i < promptArray.count; i ++)
    {
        //图标
        UIImageView *showImmage = [[UIImageView alloc] init];
        showImmage.image = [UIImage imageNamed:iconArray[i]];
        [self.view addSubview:showImmage];
        [showImmage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.02);
             make.width.mas_equalTo(CYScreanW * 0.045);
             make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.045 + i * (CYScreanH - 64) * 0.08);
             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
         }];
        //提示文字
        UILabel *promptLabel = [[UILabel alloc] init];
        promptLabel.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
        promptLabel.textAlignment = NSTextAlignmentCenter;
        promptLabel.font = font;
        promptLabel.text = [NSString stringWithFormat:@"%@",promptArray[i]];
        [self.view addSubview:promptLabel];
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(showImmage.mas_right).offset(0);
             make.width.mas_equalTo(CYScreanW * 0.23);
             make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.03 + i * (CYScreanH - 64) * 0.08);
             make.height.mas_equalTo((CYScreanH - 64) * 0.06);
         }];
    }
    UIColor *graColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1.00];
    //报修人
    _nameTextField = [[UITextField alloc] init];
    _nameTextField.placeholder = @"请输入姓名";
    _nameTextField.delegate = self;
    _nameTextField.layer.cornerRadius = 5;
    _nameTextField.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
    _nameTextField.layer.borderWidth = 1;
    _nameTextField.font = font;
    _nameTextField.returnKeyType = UIReturnKeyDone;
    _nameTextField.textColor = graColor;
    _nameTextField.backgroundColor = [UIColor clearColor];
    _nameTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_nameTextField];
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.3);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.03);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
     }];
    //联系方式
    _phonePRTextField = [[UITextField alloc] init];
    _phonePRTextField.placeholder = @"请输入手机号";
    _phonePRTextField.delegate = self;
    _phonePRTextField.font = font;
    _phonePRTextField.returnKeyType = UIReturnKeyDone;
    _phonePRTextField.layer.cornerRadius = 5;
    _phonePRTextField.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
    _phonePRTextField.layer.borderWidth = 1;
    _phonePRTextField.textColor = graColor;
    _phonePRTextField.backgroundColor = [UIColor clearColor];
    _phonePRTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_phonePRTextField];
    [_phonePRTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.3);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
         make.top.equalTo(_nameTextField.mas_bottom).offset((CYScreanH - 64) * 0.02);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
     }];
    //楼宇号
    _addressPRTextField = [[UITextField alloc] init];
    _addressPRTextField.placeholder = @"1号楼1单元101室";
    _addressPRTextField.delegate = self;
    _addressPRTextField.font = font;
    _addressPRTextField.returnKeyType = UIReturnKeyDone;
    _addressPRTextField.layer.cornerRadius = 5;
    _addressPRTextField.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
    _addressPRTextField.layer.borderWidth = 1;
    _addressPRTextField.textColor = graColor;
    _addressPRTextField.backgroundColor = [UIColor clearColor];
    _addressPRTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_addressPRTextField];
    [_addressPRTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.3);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
         make.top.equalTo(_phonePRTextField.mas_bottom).offset((CYScreanH - 64) * 0.02);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
     }];
    //问题描述
    _proRepairTextView = [[UITextView alloc] init];
    _proRepairTextView.delegate = self;
    _proRepairTextView.layer.cornerRadius = 5;
    _proRepairTextView.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
    _proRepairTextView.layer.borderWidth = 1;
    _proRepairTextView.font = font;
//    _proRepairTextView.keyboardType = UIKeyboardTypeDefault;
    _proRepairTextView.returnKeyType = UIReturnKeyDone;
    _proRepairTextView.textColor = graColor;
    _proRepairTextView.backgroundColor = [UIColor clearColor];
    _proRepairTextView.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_proRepairTextView];
    [_proRepairTextView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.3);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
         make.top.equalTo(_addressPRTextField.mas_bottom).offset((CYScreanH - 64) * 0.02);
         make.height.mas_equalTo((CYScreanH - 64) * 0.2);
     }];
    //拍照
    UIImageView *showImmage = [[UIImageView alloc] init];
    showImmage.image = [UIImage imageNamed:@"icon_camera"];
    showImmage.userInteractionEnabled = YES;
    [self.view addSubview:showImmage];
    [showImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.02);
         make.top.equalTo(_proRepairTextView.mas_bottom).offset((CYScreanH - 64) * 0.125);
         make.height.mas_equalTo((CYScreanH - 64) * 0.15);
         make.width.mas_equalTo((CYScreanH - 64) * 0.15);
     }];
    //添加单击手势防范
    UITapGestureRecognizer *showImmageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOpertationSet)];
    showImmageTap.numberOfTapsRequired = 1;
    [showImmage addGestureRecognizer:showImmageTap];
    //展示
    self.showPicRepImmage = [[UIImageView alloc] init];
    self.showPicRepImmage.image = [UIImage imageNamed:@"que_recline"];
    self.showPicRepImmage.userInteractionEnabled = YES;
    [self.view addSubview:self.showPicRepImmage];
    [self.showPicRepImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(showImmage.mas_right).offset(CYScreanW * 0.18);
         make.top.equalTo(_proRepairTextView.mas_bottom).offset((CYScreanH - 64) * 0.05);
         make.height.mas_equalTo((CYScreanH - 64) * 0.3);
         make.width.mas_equalTo(CYScreanW * 0.45);
     }];
    //添加单击手势防范
    UITapGestureRecognizer *showImmageSHTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePRTap:)];
    showImmageSHTap.numberOfTapsRequired = 1;
    [self.showPicRepImmage addGestureRecognizer:showImmageSHTap];
    //报修
    UIButton *complaintsButton = [[UIButton alloc] init];
    [complaintsButton setTitle:@"立即报修" forState:UIControlStateNormal];
    [complaintsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    complaintsButton.layer.cornerRadius = 5;
    complaintsButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    [complaintsButton addTarget:self action:@selector(RequestRepair) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:complaintsButton];
    [complaintsButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.02);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
         make.bottom.equalTo(self.view.mas_bottom).offset(-(CYScreanH - 64) * 0.06);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
     }];
    //提示
    UIButton *promptButton = [[UIButton alloc] init];
    [promptButton setTitle:@"有疑问请致电物业管理部门" forState:UIControlStateNormal];
    [promptButton setTitleColor:[UIColor colorWithRed:0.639 green:0.635 blue:0.639 alpha:1.00] forState:UIControlStateNormal];
    [promptButton setImage:[UIImage imageNamed:@"icon_pro_tel"] forState:UIControlStateNormal];
    promptButton.backgroundColor = [UIColor clearColor];
    [promptButton addTarget:self action:@selector(callPropertyPhone) forControlEvents:UIControlEventTouchUpInside];
    promptButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    promptButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:promptButton];
    [promptButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.mas_equalTo(CYScreanW);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
         make.top.equalTo(complaintsButton.mas_bottom).offset((CYScreanH - 64) * 0.01);
         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
     }];
    //展示图片
    self.fullScreenRepImmage = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH)];
    self.fullScreenRepImmage.userInteractionEnabled = YES;
    [self.navigationController.view addSubview:self.fullScreenRepImmage];
    self.fullScreenRepImmage.hidden = YES;
    //添加单击手势防范
    UITapGestureRecognizer *fullScreenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fullSceenRTap:)];
    fullScreenTap.numberOfTapsRequired = 1;
    [self.fullScreenRepImmage addGestureRecognizer:fullScreenTap];
}
//拨打电话
- (void) callPropertyPhone
{
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@", [CYSmallTools getDataStringKey:PROPERTYCPHONE]];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}
// -- - - -- - - -- - - -- - - - -- - - - -- - - -- - - 函数 -- - - -- - - -- - - -- - - - -- - - - -- - - -- -
//商品点击手势
-(void)handlePRTap:(UITapGestureRecognizer *)sender
{
    if (self.fullScreenRepImmage.image)
    {
        self.fullScreenRepImmage.hidden = NO;
    }
}
-(void)fullSceenRTap:(UITapGestureRecognizer *)sender
{
    self.fullScreenRepImmage.hidden = YES;
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
    [_phonePRTextField resignFirstResponder];
    [_proRepairTextView resignFirstResponder];
    [_addressPRTextField resignFirstResponder];
    [_nameTextField resignFirstResponder];
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
- (void) savePRImage:(UIImage *)currentImage withName:(NSString *)imageName
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
    [self savePRImage:image withName:@"avatar.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"avatar.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //设置图片显示
    [self.showPicRepImmage setImage:savedImage];
    [self.fullScreenRepImmage setImage:savedImage];
    //上传图片 //异步加载
    [MBProgressHUD showLoadToView:self.view];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.imgageUrl = [CYLRDataReuest uploadImage:savedImage withView:self.view];
        NSLog(@"self.imageUrl = %@",self.imgageUrl);
    });
//    [self uploadImage:savedImage];
}
//IOS7都要调用方法，按取消按钮用该方法
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//报修
- (void) RequestRepair
{
    if (self.phonePRTextField.text.length && self.proRepairTextView.text.length && self.nameTextField.text.length && self.addressPRTextField.text.length)
    {
        if (![CYWhetherPhone isValidPhone:self.phonePRTextField.text])
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
        parames[@"user"]        =  self.nameTextField.text;//
        parames[@"phone"]       =  self.phonePRTextField.text;
        parames[@"build"]       =  self.addressPRTextField.text;//
        parames[@"reason"]      =  self.proRepairTextView.text;
        parames[@"imgAddress"]  = self.imgageUrl;
        NSLog(@"parames = %@",parames);
        //url
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/buildRepair",POSTREQUESTURL];
        NSLog(@"requestUrl = %@",requestUrl);
        [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view];
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
                 NSLog(@"报修成功");
                 [MBProgressHUD showError:@"提交成功" ToView:self.navigationController.view];
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else{
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


@end
