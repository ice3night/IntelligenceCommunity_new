//
//  ActivityDetailsTopView.h
//  WisdomCommunity
//
//  Created by mac on 2016/12/30.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDetailsModel.h"

typedef void(^Block)(UIButton *);
@interface ActivityDetailsTopView : UIView

@property (nonatomic, strong) UIButton    *participateButton;
@property (nonatomic, copy)   Block       participateDidClicked;


@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UIImageView *faceImage;
@property (nonatomic, strong) UILabel     *titlelabel;
@property (nonatomic, strong) UILabel     *participateLabel;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *timeLabel;
@property (nonatomic, strong) UILabel     *acTimeLabel;
@property (nonatomic, strong) UILabel     *addressLabel;
@property (nonatomic, strong) UILabel     *comeLabel;

- (void)setTopViewWithModel:(ActivityDetailsModel *)model;

@end
