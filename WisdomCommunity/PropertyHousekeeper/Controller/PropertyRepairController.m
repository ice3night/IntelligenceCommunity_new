//
//  PropertyRepairController.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/10/23.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "PropertyRepairController.h"
#import "PhotoCollectionCell.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoAssets.h"
#import "MJExtension.h"
#import "ComModel.h"
#import "BuildModel.h"
#import "ReturnImage.h"
#import "ReLogin.h"
@interface PropertyRepairController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, copy) NSMutableArray *photos;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeight;
@property (nonatomic, copy) NSString *imgUrl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;
@property (weak, nonatomic) IBOutlet UIView *contentBgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *ComBgView;
@property (weak, nonatomic) IBOutlet UIView *addressBgView;
@property (weak, nonatomic) IBOutlet UIView *comView;
@property (weak, nonatomic) IBOutlet UIView *typeBgView;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UIButton *comBtn;
@property (weak, nonatomic) IBOutlet UIView *typeView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextView *contentField;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (nonatomic, strong) UIView *pickerBg;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, copy) NSMutableArray *coms;
@property (nonatomic, copy) NSMutableArray *types;
@property (nonatomic, copy) NSMutableArray *array;
@property (nonatomic, copy) NSMutableArray *address;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *typeid;
@property (nonatomic, copy) NSString *comid;
@property (nonatomic, copy) NSString *addressid;
@property (nonatomic, copy) NSString *typeStr;
@property (nonatomic, copy) NSString *comStr;
@property (nonatomic, copy) NSString *addressStr;

@end

@implementation PropertyRepairController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
}
- (void)getComData
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
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/community/comList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager GET:requestUrl parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"%@",responseObject);
        NSNumber *success = [responseObject objectForKey:@"success"];
        if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
            NSDictionary *comlist = [[responseObject objectForKey:@"param"] objectForKey:@"comList"];
            _coms = [ComModel objectArrayWithKeyValuesArray:comlist];
            if (_coms.count >= 1) {
                ComModel *com = _coms[0];
                _comid = [NSString stringWithFormat:@"%@",com.id];
                _comStr = com.comName;
            }
            
            NSLog(@"小区数据长度%lu",(unsigned long)_coms.count);
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
- (void)getAddressData
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    parames[@"comNo"]       =  [getDict objectForKey:@"id"];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/findMyBuild",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager GET:requestUrl parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"%@",responseObject);
        NSNumber *success = [responseObject objectForKey:@"success"];
        if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
            NSDictionary *comlist = [[responseObject objectForKey:@"param"] objectForKey:@"myBuilds"];
            _address = [BuildModel objectArrayWithKeyValuesArray:comlist];
            if (_address.count >= 1) {
                BuildModel *build = _address[0];
                _addressid = [NSString stringWithFormat:@"%@",build.id];
                _addressStr = build.build;
            }
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
- (void)initView
{
    _imgUrl = @"";
    self.category = @"1";
    _typeid = @"1";
    _typeStr = [NSString stringWithFormat:@"水电报修"];
    _coms = [[NSMutableArray alloc] init];
    _types = [[NSMutableArray alloc] init];
    _address = [[NSMutableArray alloc] init];
    self.types = [[NSMutableArray alloc] initWithObjects:@"水电报修",@"门窗报修",@"其他报修", nil];
    self.collectionHeight.constant = (CYScreanW-16-20)/3.0;
    self.phoneLabel.text = [@"电话：" stringByAppendingString:[CYSmallTools getDataStringKey:ACCOUNT]];//
    self.nameLabel.text = [@"姓名：" stringByAppendingString:[CYSmallTools getDataStringKey:@"trueName"]];//
    _okBtn.backgroundColor = CQColor(77,156,249, 1);
    [_okBtn setTitleColor:CQColor(246, 246, 246, 1) forState:UIControlStateNormal];
    _okBtn.layer.cornerRadius = _okBtn.bounds.size.height/2;
    
    _bgView.backgroundColor = CQColor(246, 246, 246, 1);
    _ComBgView.backgroundColor = CQColor(246, 246, 246, 1);
    _comView.layer.borderColor = CQColor(219, 219, 219, 1).CGColor;
    _comView.layer.borderWidth = 1;
    _comView.layer.cornerRadius = 5;
    
    _addressBgView.backgroundColor = CQColor(246, 246, 246, 1);
    _addressView.layer.borderColor = CQColor(219, 219, 219, 1).CGColor;
    _addressView.layer.borderWidth = 1;
    _addressView.layer.cornerRadius = 5;
    
    _typeBgView.backgroundColor = CQColor(246, 246, 246, 1);
    _typeView.layer.borderColor = CQColor(219, 219, 219, 1).CGColor;
    _typeView.layer.borderWidth = 1;
    _typeView.layer.cornerRadius = 5;
    
    _contentBgView.backgroundColor = CQColor(246, 246, 246, 1);
    _contentField.layer.borderColor = CQColor(219, 219, 219, 1).CGColor;
    _contentField.layer.borderWidth = 1;
    _contentField.layer.cornerRadius = 5;
    
    _infoView.layer.borderColor = CQColor(219, 219, 219, 1).CGColor;
    _infoView.layer.borderWidth = 1;
    _infoView.layer.cornerRadius = 5;
    
    _mCollectionView.delegate = self;
    _mCollectionView.dataSource = self;
    [self.mCollectionView registerClass:[PhotoCollectionCell class] forCellWithReuseIdentifier:@"PhotoCollectionCell"];
}
- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"物业报修";
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
    [self getComData];
}
//- (UIView *)pickerBg
//{
//    if (!_pickerBg) {
//        _pickerBg = [[UIView alloc] initWithFrame:CGRectMake(0,CYScreanH-64-200, CYScreanW, 200)];
//        _pickerBg.backgroundColor = [UIColor colorWithRed:246/255.0 green:243/255.0 blue:254/255.0 alpha:1];
//
//        self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,0, CYScreanW, 100)];
//        self.picker.backgroundColor = [UIColor colorWithRed:246/255.0 green:243/255.0 blue:254/255.0 alpha:1];
//        self.picker.dataSource = self;
//        self.picker.delegate = self;
//        [_pickerBg addSubview:self.picker];
//
//        UIButton *ensureBtn = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW/4,130,CYScreanW/2,40)];
//        ensureBtn.layer.cornerRadius = ensureBtn.bounds.size.height/2;
//        ensureBtn.backgroundColor = CQColor(77,156,249, 1);
//        [ensureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
//        [ensureBtn addTarget:self action:@selector(selectType) forControlEvents:UIControlEventTouchUpInside];
//        [_pickerBg addSubview:ensureBtn];
//    }
//    return _pickerBg;
//}
- (IBAction)comAction:(id)sender {
    self.category = @"1";
    if (!_pickerBg) {
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
    }else{
        _pickerBg.hidden = NO;
    }
    
}
- (void) selectType
{
    if([_category isEqualToString:@"1"]){
        [_comBtn setTitle:_comStr forState:UIControlStateNormal];
        [self getAddressData];
    }else if([_category isEqualToString:@"2"]){
    [_addressBtn setTitle:_addressStr forState:UIControlStateNormal];
    }else if([_category isEqualToString:@"3"]){
        [_typeBtn setTitle:_typeStr forState:UIControlStateNormal];
    }
    _pickerBg.hidden = YES;
}
- (IBAction)addressAction:(id)sender {
    self.category = @"2";
    [self.picker reloadAllComponents];
    if (!_pickerBg) {
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
    }else{
        _pickerBg.hidden = NO;
    }
}
- (IBAction)typeAction:(id)sender {
    self.category = @"3";
    [self.picker reloadAllComponents];
    if (!_pickerBg) {
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
    }else{
        _pickerBg.hidden = NO;
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([_category isEqualToString:@"1"]) {
        return _coms.count;
    }else if([_category isEqualToString:@"2"]){
        return [_address count];
    }else{
    return [_types count];
    }
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([_category isEqualToString:@"1"]) {
        ComModel *com = _coms[row];
        return com.comName;
    }else if([_category isEqualToString:@"2"]){
        BuildModel *build = _address[row];
        return build.build;
    }else{
        return _types[row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([_category isEqualToString:@"1"]) {
        ComModel *com = _coms[row];
        _comid = [NSString stringWithFormat:@"%@",com.id];
        _comStr = com.comName;
    }else if([_category isEqualToString:@"2"]){
        BuildModel *build = _address[row];
        _addressid = [NSString stringWithFormat:@"%@",build.id];
        _addressStr = build.build;
    }else{
        _typeid = [NSString stringWithFormat:@"%ld",row+1];
        _typeStr = _types[row];
    }
}
#pragma uicollection delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photos.count+1;
}
- (IBAction)commitRepair:(id)sender {
    if (_typeid.length == 0) {
        [MBProgressHUD showError:@"请选择报修类型" ToView:self.view];
        return;
    }
    if (_contentField.text.length == 0) {
        [MBProgressHUD showError:@"请输入报修内容" ToView:self.view];
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
    parames[@"build"] = _addressid;
    parames[@"category"] = _typeid;
    parames[@"phone"] = [CYSmallTools getDataStringKey:ACCOUNT];
    parames[@"reason"] = _contentField.text;
    parames[@"imgAddress"] = [self array2String];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/buildRepair",POSTREQUESTURL];
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
        NSLog(@"图片字符串%@",_imgUrl);
    }
    return _imgUrl;
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
            self.collectionHeight.constant = 2*(CYScreanW-16-20)/3.0+10;
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
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
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
