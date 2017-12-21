//
//  TodayHotCell.m
//  WisdomCommunity
//
//  Created by legend on 2017/10/14.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "TodayHotCell.h"
#import "TodayCMDModel.h"
@interface TodayHotCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UITextView *name;
@property (weak, nonatomic) IBOutlet UILabel *saleCount;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
@implementation TodayHotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(TodayCMDModel *)model {
    NSURL *url = [NSURL URLWithString:model.img];
    [self.img sd_setImageWithURL:url];
    self.name.text = model.name;
    self.price.text = [@"¥" stringByAppendingString:model.price.stringValue];
}
@end
