//
//  ActivityRootTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/15.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ActivityRootTableViewCell.h"

@implementation ActivityRootTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIFont *font = [UIFont fontWithName:@"Arial" size:13];
        //活动展示
        UIImageView *showImmage = [[UIImageView alloc] init];
        showImmage.backgroundColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
        [self.contentView addSubview:showImmage];
        [showImmage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(0);
             make.right.equalTo(self.mas_right).offset(0);
             make.top.equalTo(self.mas_top).offset((CYScreanH - 64) * 0.01);
             make.height.mas_equalTo((CYScreanH - 64) * 0.26);
         }];
        self.imageImageView = showImmage;
        UIImage *statusImg = [UIImage imageNamed:@"icon_activity_ing"];
        UIImageView *statusImgView = [[UIImageView alloc] init];
        statusImgView.image = statusImg;
        statusImgView.frame = CGRectMake(CYScreanW * 0.03, (CYScreanH - 64) * 0.26-10-statusImg.size.height, statusImg.size.width,  statusImg.size.height);
        self.statusImgView = statusImgView;
        [self addSubview:self.statusImgView];
        //标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = CQColor(3,3,3, 1);
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.03);
             make.top.equalTo(showImmage.mas_bottom).offset((CYScreanH - 64) * 0.01);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
             make.width.mas_equalTo(CYScreanW * 0.5);
         }];
        self.titleLabel = titleLabel;
        //内容
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.textColor = CQColor(102,102,102, 1);
        contentLabel.font = font;
        [self.contentView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.03);
             make.top.equalTo(titleLabel.mas_bottom).offset(0);
             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
             make.width.mas_equalTo(CYScreanW * 0.5);
         }];
        self.contentLabel = contentLabel;
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.text = @"03-18 12.32.08";
        timeLabel.textColor = CQColor(153,153,153, 1);
        timeLabel.font = [UIFont fontWithName:@"Arial" size:10];
        [self.contentView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.03);
             make.top.equalTo(contentLabel.mas_bottom).offset(0);
             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
             make.right.equalTo(self.mas_right).offset(- 10);

         }];
        self.timeLabel = timeLabel;
        
//        //删除按钮
//        UIButton *delegateButton = [[UIButton alloc] init];
//        [delegateButton setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
//        delegateButton.backgroundColor = [UIColor clearColor];
//        delegateButton.hidden = YES;
//        [delegateButton addTarget:self action:@selector(delegateButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:delegateButton];
//        [delegateButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(showTImmage.mas_bottom).offset(0);
//            make.right.equalTo(self.contentView.mas_right).offset(-CYScreanW * 0.03);
//            make.width.mas_equalTo(CYScreanW * 0.09);
//            make.bottom.equalTo(self.mas_bottom).offset(0);
//        }];
//        self.delegateAButton = delegateButton;
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
        [self.contentView addSubview:segmentationImmage];
        [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(0);
             make.right.equalTo(self.mas_right).offset(0);
             make.bottom.equalTo(self.mas_bottom).offset(0);
             make.height.mas_equalTo(1);
         }];

    }
    return self;
}
- (void) setModel:(ActivityRootModel *)model
{
    _model = model;
    
    NSLog(@"model.imgAddress = %@",model.imgAddress);
    NSArray *imageArray = [model.imgAddress componentsSeparatedByString:@","];
    NSMutableArray *imageList = [NSMutableArray array];
    for (NSString *string in imageArray) {
        if (string.length > 6) {
            [imageList addObject:string];
        }
    }
    //如果有数据
    if (imageList.count)
    {
        NSString *imageUrl = [NSString stringWithFormat:@"%@",[imageList firstObject]];//
        NSData *data = [CYSmallTools GetCashUrl:imageUrl];
        if (data)
        {
            self.imageImageView.image = [UIImage imageWithData:data];
        }
        else
        {
            [self.imageImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        }
    }
    else
    {
        NSData *data = [CYSmallTools GetCashUrl:BackGroundImage];
        if (data)
        {
            self.imageImageView.image = [UIImage imageWithData:data];
        }
        else
            [self.imageImageView sd_setImageWithURL:[NSURL URLWithString: BackGroundImage]];
    }
    
    
    if ([_model.stateString isEqualToString:@"start"])
    {
        self.showImageView.image = [UIImage imageNamed:@"icon_activity_ongoing"];
    }
    else if ([_model.stateString isEqualToString:@"end"]){
        self.showImageView.image = [UIImage imageNamed:@"icon_activity_ending"];
    }else{
        self.showImageView.image = [UIImage imageNamed:@"icon_activity_ongoing"];
    }
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",_model.title.length ? [ActivityDetailsTools UTFTurnToStr:_model.title] : @"标题"];
    if ([_model.flag integerValue] == 1)
    {
        self.contentLabel.text = [NSString stringWithFormat:@"%@",_model.content.length ? [ActivityDetailsTools UTFTurnToStr:_model.content] : @"内容"];
    }
    else
        self.contentLabel.text = @"官方活动内容";
    
    NSLog(@"_model.acTime = %@",_model.acTime);
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[_model.acTime containsString:@"null"] ? @"时间" : _model.acTime];
    //显示删除按钮
    if (self.whetherDelegateActivity) {
        self.delegateAButton.hidden = NO;
    }
}
//删除
- (void) delegateButtonClick
{
    if (self.delegateActivityClicked) {
        self.delegateActivityClicked(self.model.activityID);
    }
}

@end
