//
//  MallSectionHeader.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/12/16.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "MallSectionHeader.h"
@interface MallSectionHeader (){
}
@end
@implementation MallSectionHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, 0,self.frame.size.width-50, self.frame.size.height)];
//    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
//    titleLabel.textColor = CQColorFromRGB(0x3f9aef);
//    [self addSubview:titleLabel];
    
}
@end
