//
//  ActivityDetailsTopView.m
//  WisdomCommunity
//
//  Created by mac on 2016/12/30.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ActivityDetailsTopView.h"

@interface ActivityDetailsTopView()




@end

@implementation ActivityDetailsTopView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initActivityDetailsView];
    }
    return self;
}


- (void)initActivityDetailsView
{

    //初始化
    self.headImage         = [[UIImageView alloc] init];
    self.faceImage         = [[UIImageView alloc] init];
    self.participateButton = [[UIButton alloc]    init];
    self.titlelabel        = [[UILabel alloc]     init];
    self.participateLabel  = [[UILabel alloc]     init];
    self.nameLabel         = [[UILabel alloc]     init];
    self.timeLabel         = [[UILabel alloc]     init];
    self.acTimeLabel       = [[UILabel alloc]     init];
    self.addressLabel      = [[UILabel alloc]     init];
    self.comeLabel         = [[UILabel alloc]     init];
    UIView *transparent    = [[UIView alloc]      init];
    
    //颜色
    transparent.backgroundColor            = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.titlelabel.textColor              = [UIColor whiteColor];
    self.participateLabel.textColor        = [UIColor whiteColor];
    self.participateLabel.backgroundColor  = TheMass_toneAttune;
    self.nameLabel.textColor               = [UIColor blackColor];
    self.timeLabel.textColor               = [UIColor lightGrayColor];
    self.acTimeLabel.textColor             = TheMass_toneAttune;
    self.addressLabel.textColor            = TheMass_toneAttune;
    self.participateButton.backgroundColor = TheMass_toneAttune;
    [self.participateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //字体居中
    self.titlelabel.textAlignment       = NSTextAlignmentCenter;
    self.participateLabel.textAlignment = NSTextAlignmentCenter;
    //居中
    self.comeLabel.textAlignment = NSTextAlignmentCenter;
    
    //字体
    self.titlelabel.font       = [UIFont fontWithName:@"Arial" size:20];
    self.participateLabel.font = [UIFont systemFontOfSize:16.0f];
    self.nameLabel.font        = [UIFont systemFontOfSize:16.0f];
    self.timeLabel.font        = [UIFont systemFontOfSize:14.0f];
    self.comeLabel.font        = [UIFont systemFontOfSize:14.0f];
    self.acTimeLabel.font      = [UIFont systemFontOfSize:13.0f];
    self.addressLabel.font     = [UIFont systemFontOfSize:13.0f];
    self.participateButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    
    //形状
    self.participateLabel.layer.masksToBounds  = YES;
    self.participateLabel.layer.cornerRadius   = 5.0f;
    self.faceImage.layer.masksToBounds         = YES;
    self.faceImage.layer.cornerRadius          = 20.0f;
    self.participateButton.layer.masksToBounds = YES;
    self.participateButton.layer.cornerRadius  = 5.0f;
    
    //事件
    
    [self.participateButton addTarget:self action:@selector(participateDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //装载
    [self           addSubview:self.headImage];
    [self           addSubview:transparent];
    [transparent    addSubview:self.titlelabel];
    [transparent    addSubview:self.participateLabel];
    [self           addSubview:self.faceImage];
    [self           addSubview:self.nameLabel];
    [self           addSubview:self.timeLabel];
    [self           addSubview:self.comeLabel];
    [self           addSubview:self.acTimeLabel];
    [self           addSubview:self.addressLabel];
    [self           addSubview:self.participateButton];
    
    
    //约束
    
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_offset(170);
    }];
    
    [transparent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_offset(170);
    }];
    
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(transparent);
        make.centerX.equalTo(transparent);
        make.left.equalTo(transparent).offset(20);
        make.height.mas_offset(25);
    }];
    [self.participateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(transparent);
        make.top.equalTo(self.titlelabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    [self.faceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_bottom).offset(10);
        make.left.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.faceImage.mas_right).offset(5);
        make.right.equalTo(self.comeLabel.mas_left).offset(CYScreanW * 0.03);
        make.bottom.equalTo(self.faceImage.mas_centerY);
        make.height.mas_offset(20);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.faceImage.mas_right).offset(5);
        make.right.equalTo(self.comeLabel.mas_left).offset(-5);
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.height.mas_offset(20);
    }];
    [self.comeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_bottom).offset((CYScreanH - 64) * 0.01);
        make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
        make.height.mas_offset(20);
        make.width.mas_offset(CYScreanW * 0.3);
    }];
//
    [self.acTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.faceImage.mas_bottom).offset(10);
        make.right.equalTo(self.participateButton.mas_left).offset(10);
        make.height.mas_offset(20);
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.acTimeLabel.mas_bottom);
        make.right.equalTo(self.participateButton.mas_left).offset(10);
        make.height.mas_offset(20);
    }];
//
    [self.participateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
        make.top.equalTo(self.acTimeLabel.mas_bottom);
        make.height.mas_offset(30);
        make.width.mas_equalTo(CYScreanW * 0.3);
    }];
    //默认数据
    self.headImage.image = [UIImage imageNamed:@"01"];
    self.faceImage.image = [UIImage imageNamed:@"icon_posting_bg"];
    self.titlelabel.text = @"# 活动标题 #";
    self.participateLabel.text = @"X人参加";
    self.nameLabel.text = @"璟智生活";
    self.timeLabel.text = @"03-18 12:23:09";
    self.acTimeLabel.text = @"活动时间:2017.01.01 - 03.06";
    self.addressLabel.text = @"活动地址:发布地址";
    self.comeLabel.text = @"来自 发布小区";
    [self textColorChangeWith:self.comeLabel];
    [self.participateButton setTitle:@"" forState:UIControlStateNormal];
}
- (void)setTopViewWithModel:(ActivityDetailsModel *)model
{
    self.titlelabel.text = [NSString stringWithFormat:@"# %@ #",[ActivityDetailsTools UTFTurnToStr:model.title.length ? model.title : @""]];
    self.participateLabel.text = [NSString stringWithFormat:@"%@人参与",model.playCount];
    NSDictionary *dict = model.accountDO;
    NSString *imgAddress = [self objectOrNilForKey:@"imgAddress" fromDictionary:dict];
    
    NSString *nickName = [self objectOrNilForKey:@"nickName" fromDictionary:dict];
    //获取数组图片
    NSArray *imageArray = [model.imgAddress componentsSeparatedByString:@","];
    NSMutableArray *imageList = [NSMutableArray array];
    for (int i = 0; i<imageArray.count; i++) {
        if (![imageArray[i] isEqualToString:@""]) {
            [imageList addObject:imageArray[i]];
        }
    }
    NSString *imageUrl = [NSString stringWithFormat:@"%@",[imageList firstObject]];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:imageUrl.length > 6 ? imageUrl : BackGroundImage]];//@"http://7xwtb9.com2.z0.glb.qiniucdn.com/01.jpg"
    
    [self.faceImage sd_setImageWithURL:[NSURL URLWithString:imgAddress == nil ? DefaultHeadImage:imgAddress]];
    self.nameLabel.text = [ActivityDetailsTools UTFTurnToStr:(nickName == nil || [nickName isEqualToString:@"<null>"]) ? @"未获取":nickName];
    NSLog(@"model.communityName = %@",model.communityName);
    self.comeLabel.text = [NSString stringWithFormat:@"来自:%@",model.communityName == nil?@"":model.communityName];
    self.timeLabel.text = model.gmtCreate;
    self.acTimeLabel.text = [NSString stringWithFormat:@"活动时间:%@",model.acTime];
    self.addressLabel.text = [NSString stringWithFormat:@"活动地址:%@",model.address == nil?@"":model.address];
    NSLog(@"model.acTime = %@",model.acTime);
    
    if ([[ActivityDetailsTools returnStateString:model.acTime] isEqualToString:@"Not"])
    {
        [self.participateButton setTitle:@"等待开始" forState:UIControlStateNormal];
        self.participateButton.userInteractionEnabled = NO;
    }
    else if ([[ActivityDetailsTools returnStateString:model.acTime] isEqualToString:@"start"])
    {
        [self.participateButton setTitle:@"报名参加" forState:UIControlStateNormal];
    }
    else
    {
        self.participateButton.userInteractionEnabled = NO;
        [self.participateButton setTitle:@"已结束" forState:UIControlStateNormal];
    }
}

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

- (void)participateDidClicked:(UIButton *)sender
{
    if (self.participateDidClicked) {
        self.participateDidClicked(sender);
    }
}
- (void)textColorChangeWith:(UILabel *)label
{
    NSMutableAttributedString *sendMessageString = [[NSMutableAttributedString alloc] initWithString:label.text];
    [sendMessageString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.733 green:0.733 blue:0.733 alpha:1.00] range:NSMakeRange(0,2)];
    label.attributedText = sendMessageString;
}


@end
