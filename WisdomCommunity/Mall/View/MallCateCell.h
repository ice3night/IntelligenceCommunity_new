//
//  MallCateCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MallCateCellDelegate
- (void) goToRuncaiyuan;
- (void) goToSupermarket;
- (void) goToWeishop;
- (void) goToTuangou;
@end
@interface MallCateCell : UICollectionViewCell
@property (nonatomic,weak) id <MallCateCellDelegate> delegate;

@end
