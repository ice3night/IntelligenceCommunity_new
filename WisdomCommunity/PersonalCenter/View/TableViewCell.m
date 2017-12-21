//
//  TableViewCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/7.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "TableViewCell.h"
@interface TableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end
@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _title.textColor = CQColor(3, 3, 3, 1);
    _status.textColor = CQColor(73,161,243, 1);
    _info.textColor = CQColor(153,153,153, 1);
}
-(void)setModel:(HouseModel *)model
{
    _model = model;
    _title.text = _model.comName;
    if ([_model.status isEqualToString:@"0"]) {
        _status.text = @"审核中";
    } else if ([_model.status isEqualToString:@"1"]) {
        _status.text = @"审核通过";
    } else {
        _status.text = @"审核驳回";
    }
    NSArray * builds = [_model.build componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    _info.text = [[[builds[0] stringByAppendingString:@"号楼"] stringByAppendingString:[builds[1] stringByAppendingString:@"单元"]] stringByAppendingString:builds[2]];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        //加载MyCell.xib文件，此处loadNibNamed后面的参数CellIdentifier必须与MyCell.xib文件名相同，否则会无法加载，报错崩溃
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (TableViewCell *)[nibArray objectAtIndex:0];
    }
    
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
