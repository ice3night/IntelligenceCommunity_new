//
//  DetailProductVc.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/11.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailProductModel.h"
#import "DetailProductHeaderFrame.h"
#import "ProductDetailHeader.h"
#import "TakeOutModel.h"
@interface DetailProductVc : UIViewController<UITableViewDelegate,UITableViewDataSource,ProductHeader>
@property (nonatomic,copy) NSString *shopId;
@property (nonatomic,copy) NSString *proId;
@property (nonatomic,strong) DetailProductModel *model;

@end
