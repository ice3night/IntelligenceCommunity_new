//
//  MallSearchResult.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallSearchResult : UIViewController
@property (nonatomic,strong) UICollectionView *mcollectionView;
@property (nonatomic,strong) NSMutableArray *sourceArr;//今日热卖
@property (nonatomic,copy) NSString *key;

@end
