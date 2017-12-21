//
//  OrderMTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "OrderMTableViewCell.h"
#import "OrderItem.h"
#import "MJExtension.h"
@implementation OrderMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"OrderMTableViewCell";
    // 1.缓存中取
    OrderMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[OrderMTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = CQColor(246,243,254, 1);
        
        //头像
        UIImageView *headImage = [[UIImageView alloc] init];
        //圆角
//        headImage.layer.cornerRadius = headImage.frame.size.width / 2;
//        headImage.clipsToBounds = YES;
        //商家名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont fontWithName:@"Arial" size:15];
    
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = CQColor(153,153,153, 1);
        timeLabel.font = [UIFont fontWithName:@"Arial" size:10];
        
        //价格
        UILabel *moneyLabel = [[UILabel alloc] init];
        moneyLabel.textColor = [UIColor colorWithRed:0.925 green:0.651 blue:0.263 alpha:1.00];
        
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = ShallowGrayColor;
        
        UITableView *detailTable = [[UITableView alloc] init];
        detailTable.delegate = self;
        detailTable.dataSource = self;
        detailTable.scrollEnabled = NO;
        
        _topBgView = bgView;
        _headImage = headImage;
        _name = nameLabel;
        _time = timeLabel;
        _price = moneyLabel;
        _lineView = segmentationImmage;
        _mTableView = detailTable;
        [self.contentView addSubview:_topBgView];
        [self.contentView addSubview:_headImage];
        [self.contentView addSubview:_name];
        [self.contentView addSubview:_time];
        [self.contentView addSubview:_price];
        [self.contentView addSubview:_lineView];
        [self.contentView addSubview:_mTableView];
    }
    return self;
}
-(void)setOrderCellFrame:(OrderCellFrame *)orderCellFrame
{
    _orderCellFrame = orderCellFrame;
    _orderDetailArray = [OrderItem objectArrayWithKeyValuesArray:_orderCellFrame.orderModel.detailList];
    [self.mTableView reloadData];
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
    OrderMModel *model = self.orderCellFrame.orderModel;
//    self.headImage.image = [UIImage imageNamed:@"icon_login_wechat"];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.shopImg] placeholderImage:nil];
    self.name.text = model.shopName;
    self.time.text = model.gmtCreate;
    self.price.text = [@"¥" stringByAppendingString:[NSString stringWithFormat:@"%@",model.nowMoney]];
}
/**
 *  设置子控件的frame
 */
- (void)settingFrame
{
    _topBgView.frame = _orderCellFrame.topBgF;
    _headImage.frame = _orderCellFrame.headImageF;
    NSLog(@"店铺头像地址%f,%f,%f,%f",_orderCellFrame.headImageF.origin.x,_orderCellFrame.headImageF.origin.y,_orderCellFrame.headImageF.size.width,_orderCellFrame.headImageF.size.height);
    _name.frame = _orderCellFrame.nameF;
    _time.frame = _orderCellFrame.timeF;
    _price.frame = _orderCellFrame.priceF;
    _lineView.frame = _orderCellFrame.lineF;
    _mTableView.frame = _orderCellFrame.tableF;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _orderDetailArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"OrderItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.hidden = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    OrderItem *orderItem = _orderDetailArray[indexPath.row];
    cell.textLabel.textColor = CQColor(51,51,51, 1);
    cell.textLabel.text = orderItem.productName;
    //名称
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (CYScreanH - 64) * 0.01, (CYScreanH - 64) * 0.20, (CYScreanH - 64) * 0.06)];
//    nameLabel.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    nameLabel.textColor = CQColor(3,3,3, 1);
    nameLabel.font = [UIFont systemFontOfSize:12];
//    nameLabel.scrollEnabled = NO;
    nameLabel.text = [NSString stringWithFormat:@"%@",orderItem.productName];
    [cell.contentView addSubview:nameLabel];
    //数量
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake((CYScreanW*0.95-(CYScreanW-64)*0.18)/2, (CYScreanH - 64) * 0.01, (CYScreanH - 64) * 0.06, (CYScreanH - 64) * 0.06)];
    numLabel.font = [UIFont systemFontOfSize:12];
    numLabel.textColor = CQColor(88,88,88, 1);
    numLabel.text = [@"x" stringByAppendingString:[NSString stringWithFormat:@"%@",orderItem.productnum]];
    [cell.contentView addSubview:numLabel];
    
    //价格
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.text = [@"¥" stringByAppendingString: [NSString stringWithFormat:@"%@",orderItem.price]];
    priceLabel.font = [UIFont systemFontOfSize:12];
    priceLabel.textColor = CQColor(200,33,61, 1);
    [cell.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
    make.left.equalTo(numLabel.mas_right).offset(CYScreanW * 0.05);
             make.top.equalTo(numLabel.mas_top).offset(0);
             make.width.mas_equalTo (CYScreanW * 0.5);
             make.height.mas_equalTo((CYScreanH - 64) * 0.06);
         }];
        
//        //选择显示图标
//        self.PayTreasureButton = [[UIButton alloc] init];
//        [self.PayTreasureButton setBackgroundImage:[UIImage imageNamed:@"icon_payway_selected"] forState:UIControlStateNormal];
//        self.PayTreasureButton.backgroundColor = [UIColor clearColor];
//        [cell.contentView addSubview:self.PayTreasureButton];
//        [self.PayTreasureButton mas_makeConstraints:^(MASConstraintMaker *make)
//         {
//             make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.02);
//             make.width.mas_equalTo((CYScreanH - 64) * 0.04);
//             make.top.equalTo(headImage.mas_top).offset((CYScreanH - 64) * 0.01);
//             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
//         }];
    
    return cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
