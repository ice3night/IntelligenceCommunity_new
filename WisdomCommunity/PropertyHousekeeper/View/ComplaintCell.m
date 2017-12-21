//
//  ComplaintCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/14.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ComplaintCell.h"
@interface ComplaintCell()
@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIView *topBgView;
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, weak) UILabel *typeView;
@property (nonatomic, weak) UILabel *lineView;
@property (nonatomic, weak) UITextView *detailView;
@property (nonatomic, weak) UILabel *timeView;
@end
@implementation ComplaintCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"NewMessageCell";
    // 1.缓存中取
    ComplaintCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[ComplaintCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        bgView.layer.borderWidth = 0.5;
        bgView.backgroundColor = [UIColor whiteColor];
        
        UIView *topBgView = [[UIView alloc] init];
        topBgView.layer.cornerRadius = 10;
        topBgView.layer.masksToBounds = YES;
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_me_complaint"]];
        
        UILabel *titleView = [[UILabel alloc] init];
        titleView.font = [UIFont systemFontOfSize:12];
        titleView.textColor = CQColor(153,153,153, 1);
        
        UILabel *typeView = [[UILabel alloc] init];
        typeView.font = [UIFont systemFontOfSize:12];
        typeView.textColor = CQColor(63,154,239, 1);
        
        UILabel *lineView = [[UILabel alloc] init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        
        UITextView *detailView = [[UITextView alloc] init];
        detailView.showsVerticalScrollIndicator = NO;
        detailView.showsHorizontalScrollIndicator = NO;
        detailView.scrollEnabled = NO;
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
        _typeView = typeView;
        _lineView = lineView;
        _detailView = detailView;
        _timeView = timeView;
        
        [_topBgView addSubview:_iconView];
        [_topBgView addSubview:_titleView];
        [_topBgView addSubview:_typeView];
        [self.bgView addSubview:_topBgView];
        [self.bgView addSubview:_lineView];
        [self.bgView addSubview:_detailView];
        [self.bgView addSubview:_timeView];
        [self addSubview:self.bgView];
    }
    return self;
}
-(void)setComplaintCellFrame:(ComplaintCellFrame *)complaintCellFrame
{
    _complaintCellFrame = complaintCellFrame;
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
    ComplaintModel *model = self.complaintCellFrame.complaintModel;
    if ([model.category integerValue] == 1){
        self.titleView.text = @"房屋设施";
    }else if ([model.category integerValue] == 2){
        self.titleView.text = @"公共设施";
    }else if([model.category integerValue] == 3){
        self.titleView.text = @"服务评价";
    }
    if([model.status integerValue] == 0) {
        _typeView.text = @"待处理";
    }else if([model.status integerValue] == 1) {
        _typeView.text = @"处理中";
    }else if([model.status integerValue] == 2) {
        _typeView.text = @"已处理";
    }else if([model.status integerValue] ==3) {
        _typeView.text = @"已取消";
    }
    self.detailView.text = model.reason;
    
    NSString *str = [NSString stringWithFormat:@"%@",model.callTime];
    self.timeView.text = [@"提交时间：" stringByAppendingString:[CYSmallTools timeWithTimeIntervalString:str]];
}
/**
 *  设置子控件的frame
 */
- (void)settingFrame
{
    _iconView.frame = _complaintCellFrame.iconF;
    _titleView.frame = _complaintCellFrame.titleF;
    _typeView.frame = _complaintCellFrame.statusF;
    _lineView.frame = _complaintCellFrame.lineF;
    _detailView.frame = _complaintCellFrame.contentF;
    _timeView.frame = _complaintCellFrame.timeF;
    _topBgView.frame = _complaintCellFrame.topBgF;
    _bgView.frame = _complaintCellFrame.bgViewF;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
