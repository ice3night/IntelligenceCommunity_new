//
//  SubmitMOrderTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "SubmitMOrderTableViewCell.h"

@implementation SubmitMOrderTableViewCell

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
        //名称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor colorWithRed:0.345 green:0.353 blue:0.357 alpha:1.00];
        nameLabel.font = [UIFont fontWithName:@"Arial" size:14];
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.05);
             make.top.equalTo(self.mas_top).offset(0);
             make.width.mas_equalTo (CYScreanW * 0.53);
             make.bottom.equalTo(self.mas_bottom).offset(0);
         }];
        self.nameLabel = nameLabel;
        
        //
        UILabel *moneyLabel = [[UILabel alloc] init];
        moneyLabel.textAlignment = NSTextAlignmentRight;
        moneyLabel.textColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
        moneyLabel.font = [UIFont fontWithName:@"Arial" size:13];
        [self.contentView addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
             make.top.equalTo(self.mas_top).offset(0);
             make.width.mas_equalTo(CYScreanW * 0.2);
             make.bottom.equalTo(self.mas_bottom).offset(0);
         }];
        self.moneyLabel = moneyLabel;
        //数量
        UILabel *numberLabel = [[UILabel alloc] init];
        numberLabel.textAlignment = NSTextAlignmentRight;
        numberLabel.textColor = [UIColor colorWithRed:0.624 green:0.624 blue:0.624 alpha:1.00];
        numberLabel.font = [UIFont fontWithName:@"Arial" size:12];
        [self.contentView addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(moneyLabel.mas_left).offset(-CYScreanW * 0.02);
             make.top.equalTo(self.mas_top).offset(0);
             make.width.mas_equalTo(CYScreanW * 0.15);
             make.bottom.equalTo(self.mas_bottom).offset(0);
         }];
        self.numberLabel = numberLabel;
        
        
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
- (void) setModel:(SubmitMOrderModel *)model
{
    _model = model;
    
    NSLog(@"_model.goodsNameString = %@",_model.goodsNameString);
    self.nameLabel.text = [NSString stringWithFormat:@"%@",_model.goodsNameString];
    self.numberLabel.text = [NSString stringWithFormat:@"X%@",_model.goodsNumberString];
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[_model.goodsMoneyString floatValue]];
}
@end
