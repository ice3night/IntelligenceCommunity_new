//
//  BindViewController.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/26.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ViewController.h"
#import "CYWhetherPhone.h"
@interface BindViewController : ViewController<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UITextField *codeTextField;
@property (nonatomic,strong) UITextField *pwdTextField;
@property (nonatomic,strong) UITextField *UserNameTextField;
@property (nonatomic,strong) UIButton *getCodeButton;
@property (nonatomic,strong) UIButton *selectAgreementButton;
@property (nonatomic,weak) UIButton *registeredButton;//注册按钮
//倒计时
@property (nonatomic,assign) NSInteger secondsCountDownInput;//倒计时总时间
@property (nonatomic,strong) NSTimer *counTDownTimerInput;//定时器
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,copy) NSString *iconUrl;
@property (nonatomic,copy) NSString *userid;


@property (nonatomic,strong) NSDictionary *requestCodeDict;

@end
