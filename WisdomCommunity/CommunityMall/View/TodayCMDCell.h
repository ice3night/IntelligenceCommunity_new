//
//  TodayCMDCell.h
//  WisdomCommunity
//
//  Created by legend on 2017/10/14.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayCMDModel.h"
@protocol MallMiddleDelegate
- (void) gotoDetail:(TodayCMDModel *)model;
@end
@interface TodayCMDCell : UICollectionViewCell
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,weak) id <MallMiddleDelegate> delegate;
@property (nonatomic, strong) NSArray *tempArr;
@end
