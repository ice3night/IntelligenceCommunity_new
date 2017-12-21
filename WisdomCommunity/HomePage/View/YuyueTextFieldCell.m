//
//  YuyueTextFieldCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/20.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "YuyueTextFieldCell.h"

@implementation YuyueTextFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"YuyueTextFieldCell";
    //自定义cell
    YuyueTextFieldCell *cell = (YuyueTextFieldCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        //加载MyCell.xib文件，此处loadNibNamed后面的参数CellIdentifier必须与MyCell.xib文件名相同，否则会无法加载，报错崩溃
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (YuyueTextFieldCell *)[nibArray objectAtIndex:0];
    }
    
    return cell;
}
-(void)setDetailModel:(YuyueDetailModel *)detailModel
{
    _detailModel = detailModel;
    self.titleLabel.text = _detailModel.categoryName;
}
- (IBAction)endEditContent:(id)sender {
    [self.delegate contentEndEdit:_contentField.text index:_index];
}
-(void)setCategory:(NSString *)category
{
    _category = category;
    if ([_category isEqualToString:@"text"]) {
        self.contentField.keyboardType = UIKeyboardTypeDefault;
    }else{
        self.contentField.keyboardType = UIKeyboardTypeNumberPad;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
