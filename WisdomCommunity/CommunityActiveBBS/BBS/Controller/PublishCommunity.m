//
//  PublishCommunity.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/19.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "PublishCommunity.h"
#import "PhotoCollectionCell.h"
#import "ZLPhotoAssets.h"
#import "ReturnImage.h"
#import "MJExtension.h"
#import "ReLogin.h"
#import "ZLPhotoPickerViewController.h"
@interface PublishCommunity ()
@property (nonatomic, copy) NSMutableArray *photos;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeight;
@property (nonatomic, copy) NSMutableArray *array;
@property (nonatomic, copy) NSString *imgUrl;
@property (weak, nonatomic) IBOutlet UIButton *hot;
@property (weak, nonatomic) IBOutlet UIButton *market;
@property (weak, nonatomic) IBOutlet UITextView *mTextView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *typeView;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@end

@implementation PublishCommunity

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
}
- (void)initView
{
    _imgUrl = @"";
    self.bgView.backgroundColor = CQColor(243,246,248, 1);
    self.typeView.backgroundColor = CQColor(243,246,248, 1);
    
    [_hot setTitleColor:CQColor(77,156,249, 1) forState:UIControlStateNormal];
    [_market setTitleColor:CQColor(153,153,153, 1) forState:UIControlStateNormal];

    _hot.selected = YES;
    _market.selected = NO;
    _category = @"1";
    _okBtn.backgroundColor = CQColor(77,156,249, 1);
    _okBtn.layer.cornerRadius = _okBtn.bounds.size.height/2;
    
    _mCollectionView.delegate = self;
    _mCollectionView.dataSource = self;
    [self.mCollectionView registerClass:[PhotoCollectionCell class] forCellWithReuseIdentifier:@"PhotoCollectionCell"];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"发帖";
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}
- (IBAction)marketAction:(id)sender {
    if (!_market.selected) {
        [_market setTitleColor:CQColor(77,156,249, 1) forState:UIControlStateNormal];
        [_hot setTitleColor:CQColor(153,153,153, 1) forState:UIControlStateNormal];
        _market.selected = YES;
        _hot.selected = NO;
        _category = @"2";
    }
}
- (IBAction)hotAction:(id)sender {
    if(!_hot.selected){
        [_hot setTitleColor:CQColor(77,156,249, 1) forState:UIControlStateNormal];
        [_market setTitleColor:CQColor(153,153,153, 1) forState:UIControlStateNormal];
        _market.selected = NO;
        _hot.selected = YES;
        _category = @"1";
    }
}
- (IBAction)confirm:(id)sender {
    if (_mTextView.text.length == 0) {
        [MBProgressHUD showError:@"请输入文字内容" ToView:self.view];
        return;
    }
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"] = [CYSmallTools getDataStringKey:TOKEN];
    parames[@"title"] = @"";
    parames[@"content"] = _mTextView.text;
    parames[@"category"] = _category;
    parames[@"imgAddress"] = [self array2String];
    NSLog(@"拼出来的字符串%@",[self array2String]);
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    parames[@"comNo"] = [getDict objectForKey:@"id"];
    
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/addNote",POSTREQUESTURL];
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
        NSLog(@"图片模型%@",[image.param objectForKey:@"url"]);
        if (i == _array.count-1) {
            _imgUrl = [_imgUrl stringByAppendingString:[image.param objectForKey:@"url"]];
        }else{
            _imgUrl = [_imgUrl stringByAppendingString:[[image.param objectForKey:@"url"] stringByAppendingString:@","]];
        }
        NSLog(@"图片字符串%@",_imgUrl);
    }
    return _imgUrl;
}
#pragma uicollection delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
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
        NSLog(@"图片数组长度%lu",_array.count);

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
