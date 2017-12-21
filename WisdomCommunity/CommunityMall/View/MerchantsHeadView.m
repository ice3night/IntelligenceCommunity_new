//
//  MerchantsHeadView.m
//  WisdomCommunity
//
//  Created by bridge on 17/1/7.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "MerchantsHeadView.h"

@implementation MerchantsHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0.294 green:0.533 blue:0.871 alpha:1.00];
    }
    return self;
}
- (void) initMHVUI:(NSDictionary *)dict withJsonStr:(NSString *)JsonString
{
    NSString *merchantsHead;//商家头像
    NSString *merchantsBg;//背景
    NSString *merchantsName;//商家名字
    NSString *merchantsPFen;//评分
    NSNumber *merchantsNumber;//销售量
    NSString *minMoney;//起送费
    NSString *sendMoney;//配送费
    NSString *activityStr;//活动
    NSString *isManJian;//活动类型
    NSString *isNUJianMian;//活动类型
    NSLog(@"jsonstring%@",dict);
    if (JsonString.length > 20)//有数据
    {
        merchantsHead = [NSString stringWithFormat:@"%@",[dict objectForKey:@"imgBiao"]];
        merchantsBg = [NSString stringWithFormat:@"%@",[dict objectForKey:@"imgBack"]];
        merchantsName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"shopName"]];
        merchantsPFen = [NSString stringWithFormat:@"%@",[dict objectForKey:@"zongHePingFen"]];
        merchantsNumber = [dict objectForKey:@"successNum"];
        minMoney = [NSString stringWithFormat:@"%@",[dict objectForKey:@"minAmount"]];
        sendMoney = [NSString stringWithFormat:@"%@",[dict objectForKey:@"busFee"]];
        activityStr = [NSString stringWithFormat:@"%@",[dict objectForKey:@"youHuiInfo"]];
        isManJian = [NSString stringWithFormat:@"%@",[dict objectForKey:@"isManJian"]];
        isNUJianMian = [NSString stringWithFormat:@"%@",[dict objectForKey:@"isNUJianMian"]];
    }
    
    
    UIFont *font = [UIFont fontWithName:@"Arial" size:11];
    //背景图
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH * 0.27)];
    if (!([merchantsBg isEqual:[NSNull class]])&&merchantsBg.length>6) {
        NSLog(@"图片不为空%@",merchantsBg);
        [backImage sd_setImageWithURL:[NSURL URLWithString:merchantsBg]];
    }
    else{
        NSLog(@"图片为空");
        backImage.backgroundColor = CQColor(44, 58, 165, 1);
    }
    [self addSubview:backImage];
    //商家头像
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, CYScreanH * 0.10, CYScreanH * 0.16, CYScreanH * 0.16)];
    headImage.image = [UIImage imageNamed:@"icon_rec_bg"];
    [self addSubview:headImage];
    UIImageView *headImaget = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, CYScreanH * 0.10, CYScreanH * 0.16, CYScreanH * 0.16)];
    [headImaget sd_setImageWithURL:[NSURL URLWithString:merchantsHead.length ? merchantsHead : DefaultHeadImage]];
    [self addSubview:headImaget];
    //商家名
    UILabel *brandLabel = [[UILabel alloc] init];
    brandLabel.backgroundColor = [UIColor clearColor];
    brandLabel.textColor = [UIColor whiteColor];
    brandLabel.font = [UIFont fontWithName:@"Arial" size:18];
    brandLabel.text = merchantsName.length ? merchantsName : @"";
    [self addSubview:brandLabel];
    [brandLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.02);
         make.height.mas_equalTo(CYScreanH * 0.025);
         make.width.mas_equalTo(CYScreanW * 0.4);
         make.top.equalTo(headImage.mas_top);
     }];
    //评价
    //黑色星星
    UIView *blackStart = [[UIView alloc] init];
    blackStart.backgroundColor = [UIColor clearColor];
    [self addSubview:blackStart];
    [blackStart mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.02);
        make.top.equalTo(brandLabel.mas_bottom).offset(CYScreanW * 0.01);
         make.width.mas_equalTo(CYScreanW * 0.15);
         make.height.mas_equalTo((CYScreanH - 64) * 0.02);
     }];
    for (NSInteger i = 0; i < 5; i ++)
    {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.03 * i, 0, CYScreanW * 0.03, CYScreanH * 0.02)];
        image.image = [UIImage imageNamed:@"star_blank"];
        image.userInteractionEnabled = YES;
        [blackStart addSubview:image];
    }
    //金色星星
    UIView *_redStart = [[UIView alloc] init];
    _redStart.backgroundColor = [UIColor clearColor];
    _redStart.clipsToBounds = YES;//超出部分不显示
    [self addSubview:_redStart];
    [_redStart mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.height.and.left.and.top.equalTo(blackStart);
         make.width.equalTo(blackStart.mas_width).multipliedBy([merchantsPFen integerValue] / 100.0);
     }];
    for (NSInteger i = 0; i < 5; i ++)
    {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(  CYScreanW * 0.03 * i, 0, CYScreanW * 0.03, CYScreanH * 0.02)];
        image.image = [UIImage imageNamed:@"star"];
        [_redStart addSubview:image];
    }
    //销售数量
    UILabel *numberLabel = [[UILabel alloc] init];
    numberLabel.backgroundColor = [UIColor clearColor];
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.text = [NSString stringWithFormat:@"已成交%@单",merchantsNumber];
    numberLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(blackStart.mas_right).offset(CYScreanW * 0.02);
         make.height.mas_equalTo(CYScreanH * 0.025);
         make.width.mas_equalTo(CYScreanW * 0.4);
         make.top.equalTo(brandLabel.mas_bottom).offset(CYScreanW * 0.01);
     }];
    //起送、配送
    UILabel *sendPriceLabel = [[UILabel alloc] init];
    sendPriceLabel.backgroundColor = [UIColor clearColor];
    sendPriceLabel.textColor = [UIColor whiteColor];
    sendPriceLabel.text = [NSString stringWithFormat:@"最低%@起送/配送费%@元",minMoney.length ? minMoney : @"",sendMoney.length ? sendMoney : @""];
    sendPriceLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:sendPriceLabel];
    [sendPriceLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.02);
         make.height.mas_equalTo(CYScreanH * 0.025);
         make.width.mas_equalTo(CYScreanW * 0.4);
         make.top.equalTo(numberLabel.mas_bottom).offset(CYScreanW * 0.01);
     }];
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    segmentationImmage.backgroundColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
    [self addSubview:segmentationImmage];
    [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.02);
         make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.1);
         make.top.equalTo(sendPriceLabel.mas_bottom).offset(CYScreanW * 0.01);
         make.height.mas_equalTo(1);
     }];
    //在线立减
    UIImageView *onlineImageView = [[UIImageView alloc] init];
    if ([isNUJianMian integerValue] == 1)
    {
        onlineImageView.image = [UIImage imageNamed:@"icon_new"];
    }
    else if ([isManJian integerValue] == 1)
    {
        onlineImageView.image = [UIImage imageNamed:@"icon_blue_de"];
    }
    else
    {
        onlineImageView.image = [UIImage imageNamed:@""];
    }
    [self addSubview:onlineImageView];
    [onlineImageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.02);
         make.width.mas_equalTo (CYScreanW * 0.0375);
         make.top.equalTo(segmentationImmage.mas_bottom).offset(CYScreanW * 0.01);
         make.height.mas_equalTo((CYScreanH - 64) * 0.025);
     }];
    UITextView *onlineLabel = [[UITextView alloc] init];
    onlineLabel.backgroundColor = [UIColor clearColor];
    onlineLabel.textColor = [UIColor whiteColor];
    onlineLabel.font = font;
    onlineLabel.scrollEnabled = NO;
    onlineLabel.editable = NO;
    onlineLabel.text = [activityStr stringByReplacingOccurrencesOfString: @"\n" withString:@""];
    onlineLabel.textContainer.lineFragmentPadding = 0;
    onlineLabel.textContainerInset = UIEdgeInsetsZero;
    [self addSubview:onlineLabel];
    [onlineLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(onlineImageView.mas_right).offset(CYScreanW * 0.02);
         make.width.mas_equalTo (CYScreanW * 0.6);
         make.top.equalTo(segmentationImmage.mas_bottom).offset(CYScreanW * 0.01);
         make.height.mas_equalTo((CYScreanH - 64) * 0.1);
     }];
}

@end
