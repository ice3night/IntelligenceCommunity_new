//
//  MessageView.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/21.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "MessageView.h"

@implementation MessageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(MessageView *)instanceView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"MessageView" owner:nil options:nil];
    
    return [nibView objectAtIndex:0];
}
@end
