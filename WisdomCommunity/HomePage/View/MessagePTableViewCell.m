//
//  MessagePTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MessagePTableViewCell.h"

@implementation MessagePTableViewCell

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
        UIFont *font = [UIFont fontWithName:@"Arial" size:16];
        //图标
        UIImageView *messageImage = [[UIImageView alloc] init];
        messageImage.image = [UIImage imageNamed:@"comments_icon"];
        [self.contentView addSubview:messageImage];
        [messageImage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.04);
             make.top.equalTo(self.mas_top).offset((CYScreanH - 64) * 0.01);
             make.width.mas_equalTo (CYScreanW * 0.045);
             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
         }];
        self.messageImage = messageImage;
        //内容
        UILabel *MessageLabel = [[UILabel alloc] init];
        MessageLabel.textColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
        MessageLabel.font = font;
        MessageLabel.numberOfLines = 0;
        [MessageLabel sizeToFit];
        [self.contentView addSubview:MessageLabel];
        [MessageLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(messageImage.mas_right).offset(CYScreanW * 0.02);
             make.top.equalTo(self.mas_top).offset((CYScreanH - 64) * 0.01);
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.15);
         }];
        self.MessageLabel = MessageLabel;
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.font = [UIFont fontWithName:@"Arial" size:15];
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

- (void) setModel:(MessagePModel *)model
{
//    _model = model;
//    if (_model.messageString.length > 50)//最多显示50个字
//    {
//        self.MessageLabel.text = [NSString stringWithFormat:@"%@...",[_model.messageString substringToIndex:45]];
//    }
//    else
//        self.MessageLabel.text = [NSString stringWithFormat:@"%@",_model.messageString];
//    self.timeLabel.text = [NSString stringWithFormat:@"日期 %@",_model.timeString];
    
    
}

@end
