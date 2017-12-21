//
//  ComCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/8.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ComCell.h"
@interface ComCell()
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation ComCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(ChangeComModel *)model
{
    _model = model;
    _title.text = _model.comName;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"ComCell";
    //自定义cell
    ComCell *cell = (ComCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        //加载MyCell.xib文件，此处loadNibNamed后面的参数CellIdentifier必须与MyCell.xib文件名相同，否则会无法加载，报错崩溃
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (ComCell *)[nibArray objectAtIndex:0];
    }
    
    return cell;
}
- (IBAction)change:(id)sender {
    [self.delegate change:_model];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
