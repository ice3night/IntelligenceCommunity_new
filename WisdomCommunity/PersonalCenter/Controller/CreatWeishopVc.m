//
//  CreatWeishopVc.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/8.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "CreatWeishopVc.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoAssets.h"
#import "ReLogin.h"
#import "ReturnImage.h"
#import "MJExtension.h"
@interface CreatWeishopVc ()
{
    ReturnImage *returnImage;
}
@property (weak, nonatomic) IBOutlet UITextView *desc;
@property (weak, nonatomic) IBOutlet UITextField *shopName;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (nonatomic, copy) NSMutableArray *photos;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@end

@implementation CreatWeishopVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
}
- (void)initView
{

    _headImg.layer.cornerRadius = _headImg.bounds.size.height/2;
    _headImg.layer.masksToBounds = YES;
    _bgView.backgroundColor = CQColor(246,243,254, 1);
    _mScrollView.backgroundColor = CQColor(246,243,254, 1);
    _okBtn.backgroundColor = CQColor(77,156,249, 1);
    _okBtn.layer.cornerRadius = _okBtn.bounds.size.height/2;
}
- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"我要开店";
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}
#pragma mark - 选择图片
- (IBAction)selectPhoto:(id)sender {
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
        // MaxCount, Default = 9
    pickerVc.maxCount = 1;
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
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/upload/uploadImages",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    
    [manager POST:requestUrl parameters:parames constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            UIImage *image;
            if ([[self.photos objectAtIndex:0] isKindOfClass:[ZLPhotoAssets class]]) {
                image = [self.photos[0] thumbImage];
            }else if ([[self.photos objectAtIndex:0] isKindOfClass:[UIImage class]]){
                image = self.photos[0];
            }
        NSData *picData = UIImageJPEGRepresentation(image, 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *fileName = [NSString stringWithFormat:@"%@.png", [formatter stringFromDate:[NSDate date]]];
            [formData appendPartWithFileData:picData name:@"files" fileName:fileName mimeType:@"jpeg/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showSuccess:@"上传成功" ToView:self.view];
        NSLog(@"返回值%@",responseObject);
        NSMutableArray *array = [[NSMutableArray alloc] init];
        array = [ReturnImage objectArrayWithKeyValuesArray:responseObject];
        returnImage = array[0];
        if ([[self.photos objectAtIndex:0] isKindOfClass:[ZLPhotoAssets class]]) {
            [_headImg setImage:[self.photos[0] thumbImage]];
        }else if ([[self.photos objectAtIndex:0] isKindOfClass:[UIImage class]]){
            [_headImg setImage:self.photos[0]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络错误" ToView:self.view];
    }];
}
- (IBAction)commit:(id)sender {
    if (_photos.count == 0) {
        [MBProgressHUD showError:@"请选择照片" ToView:self.view];
            return;
    }
    if (_name.text.length == 0) {
        [MBProgressHUD showError:@"请输入店主姓名" ToView:self.view];
        return;
    }
    if(_phone.text == 0){
        [MBProgressHUD showError:@"请输入手机号" ToView:self.view];
        return;
    }
    if(_shopName.text == 0){
        [MBProgressHUD showError:@"请输入店铺名称" ToView:self.view];
        return;
    }
    if(_desc.text == 0){
        [MBProgressHUD showError:@"请输入店铺描述" ToView:self.view];
        return;
    }
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"master"] =  _name.text;
    parames[@"phone"] = _phone.text;
    parames[@"shopName"] = _shopName.text;
    parames[@"intro"] = _desc.text;
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    parames[@"comNo"] = [getDict objectForKey:@"id"];
    
    NSLog(@"parames = %@",parames);
        //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/applySeller",POSTREQUESTURL];
        NSLog(@"requestUrl = %@",requestUrl);
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
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
