//
//  TodaySetionHeader.m
//  WisdomCommunity
//
//  Created by legend on 2017/10/14.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "TodaySetionHeader.h"
@interface TodaySetionHeader (){
    UILabel *titleLabel;
}

@end
@implementation TodaySetionHeader
-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
        [self createBasicView];
    }
    return self;
    
}

/**
 *   进行基本布局操作,根据需求进行.
 */
-(void)createBasicView{
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0,self.frame.size.width-50, self.frame.size.height)];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    titleLabel.textColor = CQColorFromRGB(0x3f9aef);
    [self addSubview:titleLabel];
    
}

-(void)setTitleName:(NSString *)titleName {
    titleLabel.text = titleName;
}


@end
