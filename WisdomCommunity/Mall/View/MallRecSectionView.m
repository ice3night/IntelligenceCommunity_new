//
//  MallRecSectionView.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/12/16.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "MallRecSectionView.h"

@implementation MallRecSectionView
-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor=CQColor(242, 242, 242, 1);
        [self createBasicView];
    }
    return self;
}

/**
 *   进行基本布局操作,根据需求进行.
 */
-(void)createBasicView{
    UIImage *image = [UIImage imageNamed:@"icon_mall_rec_tip"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake((self.frame.size.width-image.size.width)/2, (self.frame.size.height-image.size.height)/2, image.size.width, image.size.height);
    [self addSubview:imageView];
}
@end
