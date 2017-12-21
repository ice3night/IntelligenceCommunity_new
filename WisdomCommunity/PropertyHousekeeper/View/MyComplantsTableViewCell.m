//
//  MyComplantsTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MyComplantsTableViewCell.h"

@implementation MyComplantsTableViewCell

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
        //提示图标
        UIImageView *promptImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.03, (CYScreanH - 64) * 0.02, CYScreanW * 0.045, (CYScreanH - 64) * 0.03)];
        [self.contentView addSubview:promptImage];
        self.promptImage = promptImage;
        //提示文字
        UILabel *promptLabel = [[UILabel alloc] init];
        promptLabel.textColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
        promptLabel.font = font;
        promptLabel.text = @"问题描述:";
        [self.contentView addSubview:promptLabel];
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(promptImage.mas_right).offset(CYScreanW * 0.02);
             make.top.equalTo(self.mas_top).offset((CYScreanH - 64) * 0.03);
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.1);
             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
         }];
        //描述
        UILabel *MessageLabel = [[UILabel alloc] init];
        MessageLabel.textColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.576 alpha:1.00];
        MessageLabel.font = font;
        MessageLabel.numberOfLines = 0;
        [MessageLabel sizeToFit];
        [self.contentView addSubview:MessageLabel];
        [MessageLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(promptImage.mas_right).offset(CYScreanW * 0.02);
             make.top.equalTo(promptLabel.mas_bottom).offset(0);
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.1);
         }];
        self.promptLabel = MessageLabel;
        //结果
        UILabel *resultLabel = [[UILabel alloc] init];
        resultLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.604 alpha:1.00];
        resultLabel.font = font;
        [self.contentView addSubview:resultLabel];
        [resultLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.and.right.equalTo(MessageLabel);
             make.bottom.equalTo(self.mas_bottom).offset(-(CYScreanH - 64) * 0.005);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        self.resultLabel = resultLabel;
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.604 alpha:1.00];
        timeLabel.font = font;
        [self.contentView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
             make.bottom.equalTo(self.mas_bottom).offset(-(CYScreanH - 64) * 0.005);
             make.width.mas_equalTo (CYScreanW * 0.5);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
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
- (void) setModel:(MyComplaintsModel *)model
{
    _model = model;
    NSLog(@"_model.promptString = %@,_model.resultString = %@",_model.promptString,_model.resultString);
    self.promptImage.image = [UIImage imageNamed:_model.promptImageString];
    //内容
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    paraStyle01.alignment = NSTextAlignmentLeft;  //对齐
    paraStyle01.headIndent = 0.0f;//行首缩进
    //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
    CGFloat emptylen = self.promptLabel.font.pointSize * 2;
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
    paraStyle01.tailIndent = 0.0f;//行尾缩进
    paraStyle01.lineSpacing = 2.0f;//行间距
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:_model.promptString attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    self.promptLabel.attributedText = attrText;
//    self.promptLabel.text = [NSString stringWithFormat:@"问题描述:\n%@",_model.promptString];
    
    self.resultLabel.text = [NSString stringWithFormat:@"%@",_model.resultString];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",_model.timeString];
}

@end
