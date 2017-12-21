//
//  FollowNoteCellTableViewCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/17.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "FollowNoteCellTableViewCell.h"
@interface FollowNoteCellTableViewCell()

@end
@implementation FollowNoteCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"FollowNoteCellTableViewCell";
    // 1.缓存中取
    FollowNoteCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[FollowNoteCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = CQColor(243,243,243, 1);
        UITextView *detailView = [[UITextView alloc] init];
        detailView.showsVerticalScrollIndicator = NO;
        detailView.showsHorizontalScrollIndicator = NO;
        detailView.scrollEnabled = NO;
        detailView.backgroundColor = CQColor(243,243,243, 1);
        detailView.font = [UIFont systemFontOfSize:14];
        detailView.textContainer.lineFragmentPadding = 0;
        detailView.textContainerInset = UIEdgeInsetsZero;
        detailView.editable = NO;
        _detailView = detailView;
        [self.contentView addSubview:_detailView];
    }
    return self;
}
-(void)setFollowNoteCellFrame:(FollowNoteCellFrame *)followNoteCellFrame
{
    _followNoteCellFrame = followNoteCellFrame;
    // 1.给子控件赋值数据
    [self settingData];
    // 2.设置frame
    [self settingFrame];
}
/**
 *  设置子控件的数据
 */
- (void)settingData
{
    FollowNoteDO *model = self.followNoteCellFrame.followNoteDO;
    NSMutableAttributedString *str;
    NSString *title = @"";
    if([model.state intValue] == 1){
        title = [[[ActivityDetailsTools UTFTurnToStr:model.accountName] stringByAppendingString:@"："] stringByAppendingString:[ActivityDetailsTools UTFTurnToStr:model.content]];
    str = [[NSMutableAttributedString alloc] initWithString:title];
    [str addAttribute:NSForegroundColorAttributeName value:CQColor(0,0,255, 1) range:NSMakeRange(0,[ActivityDetailsTools UTFTurnToStr:model.accountName].length)];
    }else{
        title = [[[[[ActivityDetailsTools UTFTurnToStr:model.accountName] stringByAppendingString:@"回复"] stringByAppendingString:[ActivityDetailsTools UTFTurnToStr:model.requesterName]] stringByAppendingString:@"："] stringByAppendingString:[ActivityDetailsTools UTFTurnToStr:model.content]];
        str = [[NSMutableAttributedString alloc] initWithString:title];
        [str addAttribute:NSForegroundColorAttributeName value:CQColor(0,0,255, 1) range:NSMakeRange(0,[ActivityDetailsTools UTFTurnToStr:model.accountName].length)];
        NSString *shortStr = [[ActivityDetailsTools UTFTurnToStr:model.accountName] stringByAppendingString:@"回复"];
        NSString *longStr = [[[ActivityDetailsTools UTFTurnToStr:model.accountName] stringByAppendingString:@"回复"] stringByAppendingString:[ActivityDetailsTools UTFTurnToStr:model.requesterName]];
        NSLog(@"字符串长度%lu-%lu",(unsigned long)shortStr.length,longStr.length);
        NSLog(@"总长度%lu",(unsigned long)str.length);
//        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,9)];
//        [str addAttribute:NSForegroundColorAttributeName value:CQColor(0,0,255, 1) range:NSMakeRange([ActivityDetailsTools UTFTurnToStr:model.accountName].length,[[[ActivityDetailsTools UTFTurnToStr:model.accountName] stringByAppendingString:@"回复"] stringByAppendingString:[ActivityDetailsTools UTFTurnToStr:model.requesterName]].length)];
    }
    self.detailView.attributedText = str;
}
/**
 *  设置子控件的frame
 */
- (void)settingFrame
{
    _detailView.frame = _followNoteCellFrame.contentF;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
