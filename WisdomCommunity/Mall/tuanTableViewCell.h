//
//  tuanTableViewCell.h
//  WisdomCommunity
//
//  Created by born2try-1 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tuanModel.h"
@interface tuanTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *cate;
@property (weak, nonatomic) IBOutlet UILabel *nowprice;
@property (nonatomic,strong) tuanModel *model;

@end
