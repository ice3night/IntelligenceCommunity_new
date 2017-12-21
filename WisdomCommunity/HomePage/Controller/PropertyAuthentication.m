//
//  PropertyAuthentication.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/3.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "PropertyAuthentication.h"
#import "SelectComVc.h"
#import "ReLogin.h"
@interface PropertyAuthentication ()<ComDelegate>
@property (weak, nonatomic) IBOutlet UITextField *roomField;
@property (weak, nonatomic) IBOutlet UILabel *roomTip;
@property (weak, nonatomic) IBOutlet UITextField *danyuanField;
@property (weak, nonatomic) IBOutlet UILabel *danyuanTip;
@property (weak, nonatomic) IBOutlet UITextField *buildField;
@property (weak, nonatomic) IBOutlet UILabel *buildTip;
@property (weak, nonatomic) IBOutlet UIButton *comBtn;
@property (weak, nonatomic) IBOutlet UILabel *comTip;
@property (weak, nonatomic) IBOutlet UITextField *telField;
@property (weak, nonatomic) IBOutlet UILabel *telTip;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *nameTip;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (nonatomic, copy) NSString *comId;

@end

@implementation PropertyAuthentication

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
}
- (void)initView
{
    _nameTip.textColor = CQColor(3, 3, 3, 1);
    _nameField.textColor = CQColor(199,205,209, 1);
    [_nameField setValue:CQColor(199,205,209, 1)
              forKeyPath:@"_placeholderLabel.textColor"];
    _telTip.textColor = CQColor(3, 3, 3, 1);
    _telField.textColor = CQColor(199,205,209, 1);
    [_telField setValue:CQColor(199,205,209, 1)
              forKeyPath:@"_placeholderLabel.textColor"];
    _comTip.textColor = CQColor(3, 3, 3, 1);
    [_comBtn setTitleColor:CQColor(199,205,209, 1) forState:UIControlStateNormal];
    _buildTip.textColor = CQColor(3, 3, 3, 1);
    _buildField.textColor = CQColor(199,205,209, 1);
    [_buildField setValue:CQColor(199,205,209, 1)
             forKeyPath:@"_placeholderLabel.textColor"];
    _danyuanTip.textColor = CQColor(3, 3, 3, 1);
    _danyuanField.textColor = CQColor(199,205,209, 1);
    [_danyuanField setValue:CQColor(199,205,209, 1)
             forKeyPath:@"_placeholderLabel.textColor"];
    
    _roomTip.textColor = CQColor(3, 3, 3, 1);
    _roomField.textColor = CQColor(199,205,209, 1);
    [_roomField setValue:CQColor(199,205,209, 1)
             forKeyPath:@"_placeholderLabel.textColor"];
    
    _bgView.backgroundColor = CQColor(246,243,254, 1);
    _okBtn.backgroundColor = CQColor(77,156,249, 1);
    [_okBtn setTitleColor:CQColor(246, 246, 246, 1) forState:UIControlStateNormal];
    _okBtn.layer.cornerRadius = _okBtn.bounds.size.height/2;
}
- (IBAction)selectCom:(id)sender {
    SelectComVc *com = [[SelectComVc alloc] init];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    com.delegate = self;
    [self.navigationController pushViewController:com animated:YES];
}
-(void)getCom:(ComModel *)model
{
    _comId = [NSString stringWithFormat:@"%@",model.id];
    [_comBtn setTitle:model.comName forState:UIControlStateNormal];
}
- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"物业认证";
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}
- (IBAction)commitHouse:(id)sender {
    if (_comId.length == 0) {
        [MBProgressHUD showError:@"请选择小区" ToView:self.view];
        return;
    }
    if (_nameField.text.length == 0) {
        [MBProgressHUD showError:@"请输入姓名" ToView:self.view];
        return;
    }
    if (_telField.text.length == 0) {
        [MBProgressHUD showError:@"请输入电话" ToView:self.view];
        return;
    }
    if (_buildField.text.length == 0) {
        [MBProgressHUD showError:@"请输入楼号" ToView:self.view];
        return;
    }
    if (_danyuanField.text.length == 0) {
        [MBProgressHUD showError:@"请输入单元号" ToView:self.view];
        return;
    }
    if (_roomField.text.length == 0) {
        [MBProgressHUD showError:@"请输入房间号" ToView:self.view];
        return;
    }
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"comNo"]       =  _comId;
    parames[@"build"] = [[[_buildField.text stringByAppendingString:@"#"] stringByAppendingString:[_danyuanField.text stringByAppendingString:@"#"]] stringByAppendingString:_roomField.text];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/addMyBuild",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"%@",responseObject);
        NSNumber *success = [responseObject objectForKey:@"success"];
        if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
            [MBProgressHUD showSuccess:@"提交成功,请等待审核" ToView:self.view];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showSuccess:@"提交失败" ToView:self.view];
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
