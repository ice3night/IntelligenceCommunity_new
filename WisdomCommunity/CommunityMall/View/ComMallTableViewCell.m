//
//  ComMallTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ComMallTableViewCell.h"

@implementation ComMallTableViewCell

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
        //商品图片
        UIImageView *goodsImage = [[UIImageView alloc] init];
        [self.contentView addSubview:goodsImage];
        [goodsImage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.04);
             make.top.equalTo(self.mas_top).offset((CYScreanH - 64) * 0.015);
             make.width.mas_equalTo (CYScreanW * 0.225);
             make.bottom.equalTo(self.mas_bottom).offset(-(CYScreanH - 64) * 0.015);
         }];
        self.goodsImage = goodsImage;
        //商品名字
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont fontWithName:@"Arial" size:15];
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(goodsImage.mas_right).offset(CYScreanW * 0.03);
             make.top.equalTo(goodsImage);
             make.width.mas_equalTo (CYScreanW * 0.5);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        self.goodsNameLable = nameLabel;
        //详情
        UILabel *promptLabel = [[UILabel alloc] init];
        promptLabel.textColor = [UIColor blackColor];
        promptLabel.font = font;
        [self.contentView addSubview:promptLabel];
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.and.width.equalTo(nameLabel);
             make.top.equalTo(nameLabel.mas_bottom).offset(0);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        self.goodsPromptLable = promptLabel;
        //价格
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.textColor = ShallowBrownColoe;
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.font = font;
        [self.contentView addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(goodsImage.mas_right).offset(CYScreanW * 0.03);
             make.bottom.equalTo(goodsImage);
             make.width.mas_equalTo(CYScreanW * 0.4);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        self.goodsPriceLable = priceLabel;
        //销售数
        UILabel *numberLabel = [[UILabel alloc] init];
        numberLabel.textColor = [UIColor colorWithRed:0.525 green:0.529 blue:0.529 alpha:1.00];
        numberLabel.textAlignment = NSTextAlignmentRight;
        numberLabel.font = font;
        [self.contentView addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.08);
             make.bottom.equalTo(goodsImage);
             make.width.mas_equalTo(CYScreanW * 0.4);
             make.height.equalTo(priceLabel);
         }];
        self.goodsNumberLable = numberLabel;
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:segmentationImmage];
        [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(0);
             make.right.equalTo(self.mas_right).offset(0);
             make.bottom.equalTo(self.mas_bottom).offset(-1);
             make.height.mas_equalTo(1);
         }];
    }
    return self;
}

- (void) setMallModel:(ComMallTModel *)mallModel
{
    _mallModel = mallModel;
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:_mallModel.goodsPictureString]];
    _goodsNameLable.text = [NSString stringWithFormat:@"%@",_mallModel.goodsNameString];
    _goodsPromptLable.text = [NSString stringWithFormat:@"%@",_mallModel.goodsPromptString];
    _goodsPriceLable.text = [NSString stringWithFormat:@"￥%@",_mallModel.goodsPriceString];
    _goodsNumberLable.text = [NSString stringWithFormat:@"已售%@份",_mallModel.goodsSellNumberString];
    
    
}
@end
