//
//  ComAnnoTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ComAnnoTableViewCell.h"

@implementation ComAnnoTableViewCell

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
        UIFont *font = [UIFont fontWithName:@"Arial" size:12];
        //消息列表
        UIButton *comAnnBtn = [[UIButton alloc] init];
        comAnnBtn.backgroundColor = [UIColor clearColor];
        [comAnnBtn setTitle:@"社区公告" forState:UIControlStateNormal];
        comAnnBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
        [comAnnBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [comAnnBtn setImage:[UIImage imageNamed:@"icon_title_service"] forState:UIControlStateNormal];
        comAnnBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        comAnnBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        comAnnBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:comAnnBtn];
        [comAnnBtn mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.03);
             make.width.mas_equalTo(CYScreanW * 0.4);;
             make.top.equalTo(self.mas_top).offset((CYScreanH - 64) * 0.02);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        comAnnBtn.userInteractionEnabled = NO;//不可点击
        //
        UILabel *comAnnLabel = [[UILabel alloc] init];
        comAnnLabel.textColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
        comAnnLabel.font = font;
        comAnnLabel.numberOfLines = 0;
        [comAnnLabel sizeToFit];
        [self.contentView addSubview:comAnnLabel];
        [comAnnLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.1);
             make.top.equalTo(comAnnBtn.mas_bottom).offset((CYScreanH - 64) * 0.01);
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.15);
         }];
        self.comAnnLabel = comAnnLabel;
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.font = [UIFont fontWithName:@"Arial" size:12];
        [self.contentView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.05);
             make.bottom.equalTo(self.mas_bottom).offset(-CYScreanW * 0.01);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
             make.width.mas_equalTo(CYScreanW * 0.6);
         }];
        self.timeLabel = timeLabel;
        
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
- (void) setModel:(ComAnnoModel *)model
{
    _model = model;
    if (_model.comAnnString.length > 50)//最多显示50个字
    {
        self.comAnnLabel.text = [NSString stringWithFormat:@"%@...",[_model.comAnnString substringToIndex:45]];
    }
    else
        self.comAnnLabel.text = [NSString stringWithFormat:@"%@",_model.comAnnString];
    self.timeLabel.text = [NSString stringWithFormat:@"物业办事处 %@",[CYSmallTools timeWithTimeIntervalString:_model.timeString]];
    
}


@end
