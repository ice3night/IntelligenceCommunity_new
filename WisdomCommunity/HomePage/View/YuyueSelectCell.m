//
//  YuyueSelectCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/20.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "YuyueSelectCell.h"

@implementation YuyueSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)select:(id)sender {
    [self.delegate touchAndselect:_detailModel];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"YuyueSelectCell";
    //自定义cell
    YuyueSelectCell *cell = (YuyueSelectCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        //加载MyCell.xib文件，此处loadNibNamed后面的参数CellIdentifier必须与MyCell.xib文件名相同，否则会无法加载，报错崩溃
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (YuyueSelectCell *)[nibArray objectAtIndex:0];
    }
    
    return cell;
}
-(void)setDetailModel:(YuyueDetailModel *)detailModel
{
    _detailModel = detailModel;
    self.titleLabel.text = _detailModel.categoryName;
    
        NSLog(@"cell里边的值%@",_detailModel.yueYueValue);
    self.contentLabel.text = _detailModel.yueYueValue;
}
-(void)setChoiceStr:(NSString *)choiceStr
{
    _choiceStr = choiceStr;
    _contentLabel.text = choiceStr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
