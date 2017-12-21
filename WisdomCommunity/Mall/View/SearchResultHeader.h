//
//  SearchResultHeader.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchResultHeaderDelegate
- (void) priceAction;
- (void) viewAction;
- (void) salesAction;
@end
@interface SearchResultHeader : UIView
@property (nonatomic,weak) id <SearchResultHeaderDelegate> delegate;
@end
