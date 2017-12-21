//
//  weishopTableViewCell.h
//  WisdomCommunity
//
//  Created by born2try-1 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface weishopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopimage;
@property (weak, nonatomic) IBOutlet UILabel *shopname;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *firstpay;
@property (weak, nonatomic) IBOutlet UILabel *sendmoney;
@property (weak, nonatomic) IBOutlet UILabel *manjian;
@property (weak, nonatomic) IBOutlet UIImageView *jian;

@end
