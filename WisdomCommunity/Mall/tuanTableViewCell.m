//
//  tuanTableViewCell.m
//  WisdomCommunity
//
//  Created by born2try-1 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "tuanTableViewCell.h"

@implementation tuanTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    return self;
}
//-(void)setModel:(tuanModel *)model
//{
//    _model = model;
//    NSURL *url = [NSURL URLWithString:model.image];
//    [self.image sd_setImageWithURL:url];
//    self.name.text = model.name;
////    self.content.text = model.intro;
////    self.price.text = [@"¥" stringByAppendingString:model.price.stringValue];
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
