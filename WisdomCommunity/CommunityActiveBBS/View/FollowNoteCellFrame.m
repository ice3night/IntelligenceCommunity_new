//
//  FollowNoteCellFrame.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/17.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "FollowNoteCellFrame.h"

@implementation FollowNoteCellFrame
-(void)setFollowNoteDO:(FollowNoteDO *)followNoteDO
{
    _followNoteDO = followNoteDO;
    // 间隙    
    CGFloat titleX = 8;
    CGFloat titleY = 8;
    NSString *content = @"";
    float contentH = 0;
    if([_followNoteDO.state intValue] == 1)
    {
        content = [[[ActivityDetailsTools UTFTurnToStr:_followNoteDO.accountName] stringByAppendingString:@"："] stringByAppendingString:[ActivityDetailsTools UTFTurnToStr:_followNoteDO.content]];
    }else{
        content = [[[[ActivityDetailsTools UTFTurnToStr:_followNoteDO.accountName] stringByAppendingString:@"回复"] stringByAppendingString:[ActivityDetailsTools UTFTurnToStr:_followNoteDO.requesterName]] stringByAppendingString:@"："];
    }
    contentH = [self heightString:content fontSize:14 andWidth:(CYScreanW*0.86-titleX*4)];
    self.contentF = CGRectMake(titleX, titleY/2, (CYScreanW*0.86-titleX*4), contentH);
    self.cellHeight = CGRectGetMaxY(self.contentF)+titleY/2;
    
}
- (float) heightString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}

@end
