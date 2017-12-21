//
//  HomeMiddleCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/22.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "HomeMiddleCell.h"

@implementation HomeMiddleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)renzheng:(id)sender {
    [self.delegate gotoRenzheng];
}
- (IBAction)yuyue:(id)sender {
    [self.delegate gotoYuyue];
}
- (IBAction)tiandan:(id)sender {
    [self.delegate gotoTiandan];
}
- (IBAction)jianshen:(id)sender {
    [self.delegate goToJianshen];
}
- (IBAction)licai:(id)sender {
    [self.delegate goToBiyouxin];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"HomeMiddleCell";
    //自定义cell
    HomeMiddleCell *cell = (HomeMiddleCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        //加载MyCell.xib文件，此处loadNibNamed后面的参数CellIdentifier必须与MyCell.xib文件名相同，否则会无法加载，报错崩溃
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (HomeMiddleCell *)[nibArray objectAtIndex:0];
    }
    
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
