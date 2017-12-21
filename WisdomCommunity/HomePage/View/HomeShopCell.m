//
//  HomeShopCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/22.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "HomeShopCell.h"

@implementation HomeShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.seperView.backgroundColor = CQColor(246,243,254, 1);
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"HomeShopCell";
    //自定义cell
    HomeShopCell *cell = (HomeShopCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        //加载MyCell.xib文件，此处loadNibNamed后面的参数CellIdentifier必须与MyCell.xib文件名相同，否则会无法加载，报错崩溃
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (HomeShopCell *)[nibArray objectAtIndex:0];
    }
    
    return cell;
}
- (IBAction)shangcheng:(id)sender {
    [self.delegate shopCellGotoShangCheng];
}
- (IBAction)runcaiyuan:(id)sender {
    [self.delegate shopCellGotoRunCaiYuan];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
