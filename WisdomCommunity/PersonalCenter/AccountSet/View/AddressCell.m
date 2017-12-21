//
//  AddressCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/9.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "AddressCell.h"
@interface AddressCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end
@implementation AddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _status.textColor = CQColor(77,156,249, 1);
    _address.textColor = CQColor(153, 153, 153, 1);
    _title.textColor = CQColor(153, 153, 153, 1);
}
-(void)setModel:(AddressMangeModel *)model
{
    _model = model;
    _title.text = [[_model.nameString stringByAppendingString:@"  "] stringByAppendingString:_model.phoneString];
    _address.text = _model.addressString;
    if ([_model.defaultString isEqualToString:@"0"]) {
        _status.hidden = YES;
    }else{
        _status.hidden = NO;
        _status.text = @"默认地址";
    }
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"AddressCell";
    //自定义cell
    AddressCell *cell = (AddressCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        //加载MyCell.xib文件，此处loadNibNamed后面的参数CellIdentifier必须与MyCell.xib文件名相同，否则会无法加载，报错崩溃
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (AddressCell *)[nibArray objectAtIndex:0];
    }
    
    return cell;
}
- (IBAction)editAddress:(id)sender {
    [self.delegate ClickEditImage:_model.idString];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
