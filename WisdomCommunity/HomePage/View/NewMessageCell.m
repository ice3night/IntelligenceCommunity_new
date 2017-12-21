//
//  NewMessageCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/14.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "NewMessageCell.h"
@interface NewMessageCell()
@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIView *topBgView;
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, weak) UILabel *lineView;
@property (nonatomic, weak) UITextView *detailView;
@property (nonatomic, weak) UILabel *timeView;
@end
@implementation NewMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"NewMessageCell";
    // 1.缓存中取
    NewMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[NewMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
    {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
        self.backgroundColor = CQColor(246,243,254, 1);
        UIView *bgView = [[UIView alloc] init];
        bgView.layer.cornerRadius = 10;
        bgView.layer.masksToBounds = YES;
        bgView.backgroundColor = [UIColor whiteColor];
        
        UIView *topBgView = [[UIView alloc] init];
        topBgView.layer.cornerRadius = 10;
        topBgView.layer.masksToBounds = YES;
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_home_notice"]];
        
        UILabel *titleView = [[UILabel alloc] init];
        titleView.font = [UIFont systemFontOfSize:12];
        titleView.textColor = CQColor(153,153,153, 1);
        
        UILabel *lineView = [[UILabel alloc] init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        
        UITextView *detailView = [[UITextView alloc] init];
        detailView.showsVerticalScrollIndicator = NO;
        detailView.showsHorizontalScrollIndicator = NO;
        detailView.scrollEnabled = NO;
            detailView.editable = NO;
        detailView.textColor = CQColor(3, 3, 3, 1);
        detailView.font = [UIFont systemFontOfSize:14];
        detailView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        UILabel *timeView = [[UILabel alloc] init];
        timeView.font = [UIFont systemFontOfSize:12];
        timeView.textColor = CQColor(153,153,153, 1);
        
        _bgView = bgView;
        _topBgView = topBgView;
        _iconView = iconView;
        _titleView = titleView;
        _lineView = lineView;
        _detailView = detailView;
        _timeView = timeView;
        
        [_topBgView addSubview:_iconView];
        [_topBgView addSubview:_titleView];
        [self.bgView addSubview:_topBgView];
        [self.bgView addSubview:_lineView];
        [self.bgView addSubview:_detailView];
        [self.bgView addSubview:_timeView];
        [self addSubview:self.bgView];
    }
    return self;
}
-(void)setMessageCellFrame:(MessageCellFrame *)messageCellFrame
{
    _messageCellFrame = messageCellFrame;
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
    MessagePModel *model = self.messageCellFrame.messagePModel;
    self.titleView.text = model.title;
    self.detailView.text = model.content;
    
    NSString *str = [NSString stringWithFormat:@"%@",model.publishTime];
    self.timeView.text = [CYSmallTools timeWithTimeIntervalString:str];
}
/**
 *  设置子控件的frame
 */
- (void)settingFrame
{
    _iconView.frame = _messageCellFrame.iconF;
    _titleView.frame = _messageCellFrame.titleF;
    _lineView.frame = _messageCellFrame.lineF;
    _detailView.frame = _messageCellFrame.contentF;
    _timeView.frame = _messageCellFrame.timeF;
    _topBgView.frame = _messageCellFrame.topBgF;
    _bgView.frame = _messageCellFrame.bgViewF;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
