//
//  ScoreCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/7.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ScoreCell.h"
@interface ScoreCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
@implementation ScoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _title.textColor = CQColor(3, 3, 3, 1);
    _date.textColor = CQColor(153, 153, 153, 1);
    _content.textColor = CQColor(252,92,75, 1);
    [_content setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
}
- (void)setModel:(ScoreModel *)model
{
    _model = model;
    _title.text = _model.intro;
    _date.text = [@"日期:" stringByAppendingString: _model.gmtCreate];
    if ([_model.type integerValue] == 0){
        _content.text = [@"-" stringByAppendingString:[NSString stringWithFormat:@"%@",_model.money]];
    }else {
        _content.text = [@"+" stringByAppendingString:[NSString stringWithFormat:@"%@",_model.money]];
    }
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"ScoreCell";
    //自定义cell
    ScoreCell *cell = (ScoreCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        //加载MyCell.xib文件，此处loadNibNamed后面的参数CellIdentifier必须与MyCell.xib文件名相同，否则会无法加载，报错崩溃
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (ScoreCell *)[nibArray objectAtIndex:0];
    }
    
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
