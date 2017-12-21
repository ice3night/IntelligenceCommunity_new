//
//  comBBSTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/9.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "comBBSTableViewCell.h"

@implementation comBBSTableViewCell

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
        self.backgroundColor = CQColor(243,243,243, 1);
        UIFont *font = [UIFont fontWithName:@"Arial" size:15];
        //头像
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.02, (CYScreanH - 64) * 0.02, CYScreanW * 0.12, (CYScreanH - 64) * 0.08)];
        [self.contentView addSubview:headImage];
        //圆角
        headImage.layer.cornerRadius = headImage.frame.size.width / 2;
        headImage.clipsToBounds = YES;
        self.headImage = headImage;
        //用户名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = CQColor(87,101,85, 1);
        nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
    
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.16);
             make.top.equalTo(self.mas_top).offset((CYScreanH - 64) * 0.02);
             make.width.mas_equalTo (CYScreanW * 0.4);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        self.nameLabel = nameLabel;
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = ShallowGrayColor;
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
        contentLabel.textColor = ShallowGrayColor;
        [self.contentView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headImage);
            make.top.equalTo(headImage.mas_bottom).offset(0);
            make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
            make.height.mas_equalTo((CYScreanH - 64) * 0.06);
        }];
        self.contentLabel = contentLabel;
        //展示内容图片
        UIImageView *contentImageOne = [[UIImageView alloc] init];
        contentImageOne.layer.cornerRadius = 5;
        contentImageOne.clipsToBounds = YES;
        [self.contentView addSubview:contentImageOne];
        [contentImageOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(CYScreanW * 0.02);
            make.top.equalTo(contentLabel.mas_bottom).offset(0);
            make.height.mas_equalTo(CYScreanW * 0.94 / 3);
            make.width.mas_equalTo(CYScreanW * 0.94 / 3);
        }];
        self.contentImageOne = contentImageOne;
        UIImageView *contentImageTwo = [[UIImageView alloc] init];
        contentImageTwo.layer.cornerRadius = 5;
        contentImageTwo.clipsToBounds = YES;
        [self.contentView addSubview:contentImageTwo];
        [contentImageTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentImageOne.mas_right).offset(CYScreanW * 0.01);
            make.top.and.width.and.height.equalTo(contentImageOne);
        }];
        self.contentImageTwo = contentImageTwo;
        UIImageView *contentImageThree = [[UIImageView alloc] init];
        contentImageThree.layer.cornerRadius = 5;
        contentImageThree.clipsToBounds = YES;
        [self.contentView addSubview:contentImageThree];
        [contentImageThree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentImageTwo.mas_right).offset(CYScreanW * 0.01);
            make.top.and.width.and.height.equalTo(contentImageOne);
        }];
        self.contentImageThree = contentImageThree;
        //提示图片总数
        UILabel *promptLabel = [[UILabel alloc] init];
        promptLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:promptLabel];
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.01);
            make.bottom.equalTo(contentImageOne.mas_bottom).offset(-(CYScreanH - 64) * 0.01);
            make.height.mas_equalTo((CYScreanH - 64) * 0.04);
            make.width.mas_equalTo(CYScreanW * 0.1);
        }];
        self.promptLabel = promptLabel;
        UIImageView *promptImage = [[UIImageView alloc] init];
        promptImage.image = [UIImage imageNamed:@"icon_pic"];
        [self.contentView addSubview:promptImage];
        [promptImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(promptLabel.mas_left).offset(-5);
            make.bottom.equalTo(contentImageOne.mas_bottom).offset(-(CYScreanH - 64) * 0.015);
            make.height.mas_equalTo((CYScreanH - 64) * 0.03);
            make.width.mas_equalTo(CYScreanW * 0.06);
        }];
        self.promptImage = promptImage;
        //查看次数
        UIButton *toViewButton = [[UIButton alloc] init];
        toViewButton.titleLabel.font = font;
        [toViewButton setTitleColor:ShallowGrayColor forState:UIControlStateNormal];
        [toViewButton setImage:[UIImage imageNamed:@"view_icon"] forState:UIControlStateNormal];
        toViewButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 3);
        toViewButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [self.contentView addSubview:toViewButton];
        [toViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-(CYScreanH - 64) * 0.01);
            make.left.equalTo(self.mas_left).offset(CYScreanW * 0.06);
            make.width.mas_equalTo(CYScreanW * 0.2);
            make.height.mas_equalTo((CYScreanH - 64) * 0.04);
        }];
        self.toViewButton = toViewButton;
        //点赞
        UIButton *thumbUpButton = [[UIButton alloc] init];
        thumbUpButton.titleLabel.font = font;
        [thumbUpButton setTitleColor:ShallowGrayColor forState:UIControlStateNormal];
        [thumbUpButton setImage:[UIImage imageNamed:@"like_icon"] forState:UIControlStateNormal];
        thumbUpButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 3);
        thumbUpButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [self.contentView addSubview:thumbUpButton];
        [thumbUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-(CYScreanH - 64) * 0.01);
            make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.08);
            make.width.mas_equalTo(CYScreanW * 0.15);
            make.height.mas_equalTo((CYScreanH - 64) * 0.04);
        }];
        self.thumbUpButton = thumbUpButton;
        //评论
        UIButton *commentButton = [[UIButton alloc] init];//comments_icon
        commentButton.titleLabel.font = font;
        [commentButton setTitleColor:ShallowGrayColor forState:UIControlStateNormal];
        [commentButton setImage:[UIImage imageNamed:@"comments_icon"] forState:UIControlStateNormal];
        commentButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 3);
        commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [self.contentView addSubview:commentButton];
        [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-(CYScreanH - 64) * 0.01);
            make.right.equalTo(thumbUpButton.mas_left).offset(-CYScreanW * 0.05);
            make.width.mas_equalTo(CYScreanW * 0.15);
            make.height.mas_equalTo((CYScreanH - 64) * 0.04);
        }];
        self.commentButton = commentButton;
        //删除按钮
        UIButton *delegateButton = [[UIButton alloc] init];
        [delegateButton setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
        delegateButton.backgroundColor = [UIColor clearColor];
        delegateButton.hidden = YES;
        [delegateButton addTarget:self action:@selector(delegateClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:delegateButton];
        [delegateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-(CYScreanH - 64) * 0.01);
            make.right.equalTo(commentButton.mas_left).offset(0);
            make.width.mas_equalTo(CYScreanW * 0.1);
            make.height.mas_equalTo((CYScreanH - 64) * 0.04);
        }];
        self.delegateButton = delegateButton;
        
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
- (void) setModel:(comBBSModel *)model
{
    _model = model;
    
//    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[CYSmallTools isValidUrl:self.model.headImageString] ? self.model.headImageString : DefaultHeadImage] placeholderImage:nil];
//    self.nameLabel.text = [NSString stringWithFormat:@"%@",[self whetherHavaPicture:[ActivityDetailsTools UTFTurnToStr:self.model.nameString] withCome:@""]];
//    self.timeLabel.text = [NSString stringWithFormat:@"%@",self.model.timeString];
    
//    self.contentLabel.text = [NSString stringWithFormat:@"%@",self.model.content];
//    if ([self.model.pictureNumber integerValue] > 2)
//    {
//        self.promptImage.hidden = NO;
//    }
//    else
//        self.promptImage.hidden = YES;
//
//    self.promptLabel.text = [NSString stringWithFormat:@"%@",self.model.pictureNumber];
//
//    [self.toViewButton setTitle:[NSString stringWithFormat:@"%@",self.model.checkNumber] forState:UIControlStateNormal];
//    [self.commentButton setTitle:[NSString stringWithFormat:@"%@",self.model.commentNumber] forState:UIControlStateNormal];
//    [self.thumbUpButton setTitle:[NSString stringWithFormat:@"%@",self.model.fabulousNumber] forState:UIControlStateNormal];
//
//    [self.contentImageOne sd_setImageWithURL:[NSURL URLWithString:self.model.contentImageOne] placeholderImage:nil];
//    [self.contentImageTwo sd_setImageWithURL:[NSURL URLWithString:self.model.contentImageTwo] placeholderImage:nil];
//    [self.contentImageThree sd_setImageWithURL:[NSURL URLWithString:self.model.contentImageThree] placeholderImage:nil];
//
//    NSLog(@"self.wetherMyBBS = %d",self.wetherMyBBS);
//    if (self.wetherMyBBS) {
//        self.delegateButton.hidden = NO;
//    }
    
}
//是否是空
- (NSString *) whetherHavaPicture:(NSString *) string withCome:(NSString *) comeString
{
    if([@"(null)" isEqual:string] || [@"<null>" isEqual:string] || [[NSNull null] isEqual:string] || !string.length)
        return @"OfficialOrOther";
    else
        return string;
}
//删除事件
- (void) delegateClick:(UIButton *)sender
{
    if (self.delegateClicked) {
//        self.delegateClicked(self.model.postIdString);
    }
}

@end
