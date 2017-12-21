//
//  MyConmentTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MyConmentTableViewCell.h"

@implementation MyConmentTableViewCell

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
        self.backgroundColor = [UIColor whiteColor];
        UIFont *font = [UIFont fontWithName:@"Arial" size:15];
        //头像
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.02, (CYScreanH - 64) * 0.01, CYScreanW * 0.12, (CYScreanH - 64) * 0.08)];
        [self.contentView addSubview:headImage];
        //圆角
        headImage.layer.cornerRadius = headImage.frame.size.width / 2;
        headImage.clipsToBounds = YES;
        self.headImageView = headImage;
        //用户名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor colorWithRed:0.659 green:0.659 blue:0.659 alpha:1.00];
        nameLabel.font = font;
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.16);
             make.top.equalTo(self.mas_top).offset((CYScreanH - 64) * 0.01);
             make.width.mas_equalTo (CYScreanW * 0.4);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        self.nameLabel = nameLabel;
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor colorWithRed:0.659 green:0.659 blue:0.659 alpha:1.00];
        timeLabel.font = [UIFont fontWithName:@"Arial" size:12];
        [self.contentView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.and.width.equalTo(nameLabel);
             make.top.equalTo(nameLabel.mas_bottom).offset(0);
             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
         }];
        self.timeLabel = timeLabel;
        //论坛内容
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = font;
        contentLabel.textColor = [UIColor colorWithRed:0.659 green:0.659 blue:0.659 alpha:1.00];
        [self.contentView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headImage);
            make.top.equalTo(headImage.mas_bottom).offset(0);
            make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
            make.height.mas_equalTo((CYScreanH - 64) * 0.06);
        }];
        self.commentPostLabel = contentLabel;
        //展示内容图片
        UIImageView *contentImageOne = [[UIImageView alloc] init];
        contentImageOne.layer.cornerRadius = 5;
        contentImageOne.clipsToBounds = YES;
        [self.contentView addSubview:contentImageOne];
        [contentImageOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(CYScreanW * 0.02);
            make.top.equalTo(contentLabel.mas_bottom).offset(0);
            make.height.mas_equalTo((CYScreanH - 64) * 0.12);
            make.width.mas_equalTo((CYScreanH - 64) * 0.13);
        }];
        self.showImageView = contentImageOne;
        //评论对象
        UILabel *comNameLabel = [[UILabel alloc] init];
        comNameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:comNameLabel];
        [comNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentImageOne.mas_top).offset((CYScreanH - 64) * 0.01);
            make.left.equalTo(contentImageOne.mas_right).offset(CYScreanW * 0.03);
            make.height.mas_equalTo((CYScreanH - 64) * 0.05);
            make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
        }];
        self.comNameLabel = comNameLabel;
        //帖子标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = font;
        titleLabel.numberOfLines = 0;
        [titleLabel sizeToFit];
        titleLabel.textColor = [UIColor colorWithRed:0.659 green:0.659 blue:0.659 alpha:1.00];
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentLabel.mas_bottom).offset(0);
            make.left.equalTo(contentImageOne.mas_right).offset(CYScreanW * 0.03);
            make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.2);
        }];
        self.titleLabel = titleLabel;
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
        [self.contentView addSubview:segmentationImmage];
        [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(0);
             make.right.equalTo(self.mas_right).offset(0);
             make.top.equalTo(self.mas_bottom).offset(0);
             make.height.mas_equalTo(1);
         }];
    }
    return self;
}
- (void) setModel:(MyCommentModel *)model
{
    _model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_model.headString.length > 6 ? _model.headString : DefaultHeadImage]];
    self.nameLabel.text        = [NSString stringWithFormat:@"%@",_model.nameString];
    self.timeLabel.text        = [NSString stringWithFormat:@"%@",_model.timeString];
    self.commentPostLabel.text = [NSString stringWithFormat:@"%@",_model.commentPostString];
    
    NSArray  *array = [_model.showImageString componentsSeparatedByString:@","];
    if (array.count)
    {
        NSString *urlString = [NSString stringWithFormat:@"%@",[array firstObject]];
        [self.showImageView sd_setImageWithURL:[NSURL URLWithString:urlString.length > 6 ? urlString : BackGroundImage]];
    }
    else
        [self.showImageView sd_setImageWithURL:[NSURL URLWithString:BackGroundImage]];
    
    NSString * headerData = _model.titleString;
    headerData = [headerData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    self.titleLabel.text       = [NSString stringWithFormat:@"%@...",headerData.length > 30 ? [headerData substringToIndex:29] : headerData];
    
    
}

@end
