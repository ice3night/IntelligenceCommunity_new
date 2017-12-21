//
//  PropertyRepairViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//  物业报修页面

#import <UIKit/UIKit.h>

@interface PropertyRepairViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) UITextField *phonePRTextField;
@property (nonatomic,strong) UITextField *addressPRTextField;
@property (nonatomic,strong) UITextView *proRepairTextView;

@property (nonatomic,strong) UIImageView *showPicRepImmage;//展示
@property (nonatomic,strong) UIImageView *fullScreenRepImmage;

@property (nonatomic,strong) NSString *imgageUrl;//图片URL

@end
