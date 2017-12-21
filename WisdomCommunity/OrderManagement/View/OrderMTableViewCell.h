//
//  OrderMTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//  订单主页cell

#import <UIKit/UIKit.h>
#import "OrderCellFrame.h"
@interface OrderMTableViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UIView *topBgView;//顶部背景色
@property (nonatomic,weak) UIImageView *headImage;//头像
@property (nonatomic,weak) UILabel *name;//名字
@property (nonatomic,weak) UILabel *time;//
@property (nonatomic,weak) UILabel *price;//销售量
@property (nonatomic,weak) UIView *lineView;//状态提示
@property (nonatomic,weak) UITableView *mTableView;//订单详情
@property (nonatomic,strong) OrderCellFrame *orderCellFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) NSMutableArray *orderDetailArray;//订单模型

@end
