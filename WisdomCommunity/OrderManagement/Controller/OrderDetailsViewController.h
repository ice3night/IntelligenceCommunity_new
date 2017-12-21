//
//  OrderDetailsViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//  订单详情页

#import <UIKit/UIKit.h>
#import "OrderDetailsTableViewCell.h"
#import "SendCommentViewController.h"
#import "MerchantsPageViewController.h"
#import "AddressManagementViewController.h"//选择收货地址
#import "PayCenterViewController.h"
@interface OrderDetailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *OrderMTableView;//
@property (nonatomic,strong) NSMutableArray *MyOrderAllDataArray;//订单总数据

@property (nonatomic,strong) NSString *selectOrderId;//订单id

@property (nonatomic,strong) UIButton *receiveOrderButton;//商家已接单
@property (nonatomic,assign) BOOL NoHavaReceiveGAddress;//没有收货地址
@property (nonatomic,strong) UIButton *receivePOButton;//收货人
@property (nonatomic,weak)   UIButton *locationButton;//收货地址
@property (nonatomic,strong) UIButton *promptAddressButton;//提示添加收货地址

@property (nonatomic,strong) UIView *StateView;//订单状态
@property (nonatomic,strong) UIButton *confirmButton;//确认收货

@property (nonatomic,strong) NSDictionary *OrderDetailsDict;//订单详情
@property (nonatomic,strong) NSDictionary *ReceiveGoodsAddressDict;//收货地址



@property (nonatomic,strong) OrderDetailsTableViewCell *cell;

@property (nonatomic,strong) AddressManagementViewController *AddressManController;//收货地址选择

@end
