//
//  weishopTableViewCell.m
//  WisdomCommunity
//
//  Created by born2try-1 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "weishopTableViewCell.h"

@implementation weishopTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
