//
//  HomeActivityCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/22.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "HomeActivityCell.h"

@implementation HomeActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.topbg.backgroundColor = CQColor(246,243,254, 1);
}
-(void)setUrl:(NSString *)url
{
    _url = url;
    [_showImageView sd_setImageWithURL:[NSURL URLWithString:_url]];
}
- (IBAction)activityAction:(id)sender {
    [self.delegate shopActivityAction];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"HomeActivityCell";
    //自定义cell
    HomeActivityCell *cell = (HomeActivityCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        //加载MyCell.xib文件，此处loadNibNamed后面的参数CellIdentifier必须与MyCell.xib文件名相同，否则会无法加载，报错崩溃
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (HomeActivityCell *)[nibArray objectAtIndex:0];
    }
    
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
