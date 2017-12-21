//
//  ProductCMDCell.m
//  WisdomCommunity
//
//  Created by legend on 2017/10/12.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ProductCMDCell.h"
#import "TodayCMDModel.h"
@interface ProductCMDCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *name;
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *detailName;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *price;
@end
@implementation ProductCMDCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_name setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    self.contentView.backgroundColor = CQColor(246,243,254, 1);
}
- (void)setModel:(TodayCMDModel *)model {
    NSURL *url = [NSURL URLWithString:model.img];
    [self.img sd_setImageWithURL:url];
    self.name.text = model.name;
    self.detailName.text = model.intro;
    self.price.text = [@"¥" stringByAppendingString:model.price.stringValue];
}
@end
