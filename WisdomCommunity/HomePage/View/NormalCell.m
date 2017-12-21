//
//  NormalCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/4.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "NormalCell.h"
@interface NormalCell()
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation NormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"NormalCell";
    //自定义cell
    NormalCell *cell = (NormalCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        //加载MyCell.xib文件，此处loadNibNamed后面的参数CellIdentifier必须与MyCell.xib文件名相同，否则会无法加载，报错崩溃
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (NormalCell *)[nibArray objectAtIndex:0];
    }
    
    return cell;
}
-(void)setModel:(ComModel *)model
{
    _model = model;
    self.title.text = _model.comName;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
