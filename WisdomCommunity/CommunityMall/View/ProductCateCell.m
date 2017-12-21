//
//  ProductCateCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/26.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ProductCateCell.h"
@interface ProductCateCell()
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
@implementation ProductCateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(TakeOutModel *)model
{
    _model = model;
    NSURL *url = [NSURL URLWithString:model.img];
    [self.titleImage sd_setImageWithURL:url];
    self.title.text = model.name;
    self.content.text = model.intro;
    self.price.text = [@"¥" stringByAppendingString:model.price.stringValue];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"ProductCateCell";
    //自定义cell
    ProductCateCell *cell = (ProductCateCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        //加载MyCell.xib文件，此处loadNibNamed后面的参数CellIdentifier必须与MyCell.xib文件名相同，否则会无法加载，报错崩溃
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (ProductCateCell *)[nibArray objectAtIndex:0];
    }
    
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
