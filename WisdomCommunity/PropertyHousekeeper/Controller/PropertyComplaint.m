//
//  PropertyComplaint.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/10/29.
//  Copyright © 2017年 bridge. All rights reserved.
//
#import "PropertyComplaint.h"
#import "PhotoCollectionCell.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoAssets.h"
#import "MBProgressHUD+MP.h"
#import "ReturnImage.h"
#import "MJExtension.h"
#import "ReLogin.h"
@interface PropertyComplaint ()<UIPickerViewDelegate,UIPickerViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    CGFloat orginalHeight;
}
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) UIView *pickerBg;
@property (weak, nonatomic) IBOutlet UIView *typeBgView;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextView *contentField;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIView *typeView;
@property (nonatomic, copy) NSMutableArray *citis;
@property (nonatomic, copy) NSMutableArray *photos;
@property (nonatomic, copy) NSMutableArray *array;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *typeid;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;
@property (nonatomic, strong) UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;

@end

@implementation PropertyComplaint

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)initView
{
    _imgUrl = @"";
    self.title = @"公共投诉";
    self.phoneLabel.text = [@"电话：" stringByAppendingString:[CYSmallTools getDataStringKey:ACCOUNT]];//
    self.nameLabel.text = [@"姓名：" stringByAppendingString:[CYSmallTools getDataStringKey:@"trueName"]];//
    _typeid = @"1";
    _citis = [[NSMutableArray alloc] initWithObjects:@"房屋设施",@"公共设施",@"服务评价", nil];
    self.collectionViewHeight.constant = (CYScreanW-16-20)/3.0;
    self.photos = [[NSMutableArray alloc] init];
    _bgView.backgroundColor = CQColor(246, 246, 246, 1);
    _typeView.backgroundColor = CQColor(246, 246, 246, 1);
    _contentView.backgroundColor = CQColor(246, 246, 246, 1);
    
    _okBtn.backgroundColor = CQColor(77,156,249, 1);
    [_okBtn setTitleColor:CQColor(246, 246, 246, 1) forState:UIControlStateNormal];
    _okBtn.layer.cornerRadius = _okBtn.bounds.size.height/2;
    
    _typeBtn.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"公共投诉";
    _contentField.layer.borderColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1].CGColor;
    _contentField.layer.borderWidth = 1;
    _contentField.layer.cornerRadius = 5;
    
    _infoView.layer.borderColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1].CGColor;
    _infoView.layer.borderWidth = 1;
    _infoView.layer.cornerRadius = 5;
    
    _typeBgView.layer.borderColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1].CGColor;
    _typeBgView.layer.borderWidth = 1;
    _typeBgView.layer.cornerRadius = 5;
    
    #pragma collectionView相关
    _mCollectionView.delegate = self;
    _mCollectionView.dataSource = self;
    //注册Cell，必须要有
    [self.mCollectionView registerClass:[PhotoCollectionCell class] forCellWithReuseIdentifier:@"PhotoCollectionCell"];
}
- (IBAction)typeAction:(id)sender {
    _pickerBg = [[UIView alloc] initWithFrame:CGRectMake(0,CYScreanH-64-200, CYScreanW, 200)];
    _pickerBg.backgroundColor = [UIColor colorWithRed:246/255.0 green:243/255.0 blue:254/255.0 alpha:1];

    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,0, CYScreanW, 100)];
    self.picker.backgroundColor = [UIColor colorWithRed:246/255.0 green:243/255.0 blue:254/255.0 alpha:1];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    [_pickerBg addSubview:self.picker];
    
    UIButton *ensureBtn = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW/4,130,CYScreanW/2,40)];
    ensureBtn.layer.cornerRadius = ensureBtn.bounds.size.height/2;
    ensureBtn.backgroundColor = CQColor(77,156,249, 1);
    [ensureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [ensureBtn addTarget:self action:@selector(selectType) forControlEvents:UIControlEventTouchUpInside];
    [_pickerBg addSubview:ensureBtn];
    [self.view addSubview:_pickerBg];
}
- (void) selectType
{
    [_typeBtn setTitle:_citis[[_typeid integerValue]-1] forState:UIControlStateNormal];
    _pickerBg.hidden = YES;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
        return [_citis count];
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
        return _citis[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _typeid = [NSString stringWithFormat:@"%ld",row+1];
}
#pragma uicollection delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"photos的count%lu",(unsigned long)_photos.count);
    return _photos.count+1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionCell *cell = (PhotoCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionCell" forIndexPath:indexPath];
    if(self.photos.count == 0){
        cell.img = [UIImage imageNamed:@"icon_repair_camera"];
    }else{
    if (indexPath.row == self.photos.count) {
        cell.img = [UIImage imageNamed:@"icon_repair_camera"];
    }else{
        if ([[self.photos objectAtIndex:indexPath.row] isKindOfClass:[ZLPhotoAssets class]]) {
            cell.img = [self.photos[indexPath.row] thumbImage];
        }else if ([[self.photos objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]]){
            cell.img = self.photos[indexPath.row];
        }
    }
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((CYScreanW-16-20)/3.0, (CYScreanW-16-20)/3.0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.photos.count||self.photos.count == 0) {
        if(self.photos.count == 6){
            [MBProgressHUD showError:@"最多只能上传六张图片" ToView:self.view];
        }else{
            [self photoSelectet];
        }
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}
#pragma mark - 选择图片
- (void)photoSelectet{
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // MaxCount, Default = 9
    pickerVc.maxCount = 6;
    // Jump AssetsVc
    pickerVc.status = PickerViewShowStatusCameraRoll;
    // Filter: PickerPhotoStatusAllVideoAndPhotos, PickerPhotoStatusVideos, PickerPhotoStatusPhotos.
    pickerVc.photoStatus = PickerPhotoStatusPhotos;
    // Recoder Select Assets
    pickerVc.selectPickers = self.photos;
    // Desc Show Photos, And Suppor Camera
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.isShowCamera = YES;
    // CallBack
    pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
        self.photos = status.mutableCopy;
        [self.mCollectionView reloadData];
        if (self.photos.count >= 3) {
            self.collectionViewHeight.constant = 2*(CYScreanW-16-20)/3.0+10;
        }
        [self uploadImage];
    };
    [pickerVc showPickerVc:self];
}
#pragma 上传图片
- (void)uploadImage
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
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/upload/uploadImages",POSTREQUESTURL];
        NSLog(@"requestUrl = %@",requestUrl);
        
    [manager POST:requestUrl parameters:parames constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //多图片上传
        for (NSInteger i = 0; i < self.photos.count; i ++) {
            UIImage *images;
            if ([[self.photos objectAtIndex:i] isKindOfClass:[ZLPhotoAssets class]]) {
                images = [self.photos[i] thumbImage];
            }else if ([[self.photos objectAtIndex:i] isKindOfClass:[UIImage class]]){
                images = self.photos[i];
            }
            NSData *picData = UIImageJPEGRepresentation(images, 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *fileName = [NSString stringWithFormat:@"%@%ld.png", [formatter stringFromDate:[NSDate date]], (long)i];
            [formData appendPartWithFileData:picData name:@"files" fileName:fileName mimeType:@"jpeg/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showSuccess:@"上传成功" ToView:self.view];
        NSLog(@"返回值%@",responseObject);
        _array = [[NSMutableArray alloc] init];
        _array = [ReturnImage objectArrayWithKeyValuesArray:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络错误" ToView:self.view];
    }];
}
- (void)commiteAdvice
{
    if (_typeid.length == 0) {
        [MBProgressHUD showError:@"请选择投诉类型" ToView:self.view];
        return;
    }
    if (_contentField.text.length == 0) {
        [MBProgressHUD showError:@"请输入投诉内容" ToView:self.view];
        return;
    }
    if(self.photos.count == 0){
        [MBProgressHUD showError:@"请上传图片" ToView:self.view];
        return;
    }
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"user"]       =  [CYSmallTools getDataStringKey:ACCOUNT];
    parames[@"category"] = _typeid;
    parames[@"phone"] = [CYSmallTools getDataStringKey:ACCOUNT];
    parames[@"reason"] = _contentField.text;
    parames[@"imgAddress"] = [self array2String];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/addComplain",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
//        [MBProgressHUD showError:@"网络错误" ToView:self.view];
        NSLog(@"%@",responseObject);
        NSNumber *success = [responseObject objectForKey:@"success"];
        if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
            [MBProgressHUD showSuccess:@"提交成功" ToView:self.view];
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
- (NSString *)array2String
{
    for (int i = 0;i < _array.count;i++) {
        ReturnImage *image = _array[i];
        if (i == _array.count-1) {
            _imgUrl = [_imgUrl stringByAppendingString:[image.param objectForKey:@"url"]];
        }else{
            _imgUrl = [_imgUrl stringByAppendingString:[[image.param objectForKey:@"url"] stringByAppendingString:@","]];
        }
    }
    return _imgUrl;
}
- (IBAction)confirmAdvice:(id)sender {
    [self commiteAdvice];
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
