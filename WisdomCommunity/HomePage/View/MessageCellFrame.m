//
//  MessageCellFrame.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/14.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "MessageCellFrame.h"

@implementation MessageCellFrame
-(void)setMessagePModel:(MessagePModel *)messagePModel
{
    _messagePModel = messagePModel;
    // 间隙
    CGFloat padding = 5;
    
    CGFloat titleX = 8;
    CGFloat titleY = 8;
//    self.bgViewF = CGRectMake(titleX, titleY, CYScreanW-2*titleX, (CYScreanH - 64) * 0.3);
    UIImage *image = [UIImage imageNamed:@"icon_home_notice"];
    self.topBgF = CGRectMake(titleX, titleY, CYScreanW-2*titleX, (CYScreanH-64)*0.05);
    self.iconF = CGRectMake(titleX, ((CYScreanH-64)*0.05-image.size.height)/2, image.size.width, image.size.height);
    self.titleF = CGRectMake(CGRectGetMaxX(_iconF)+titleX, ((CYScreanH-64)*0.05-21)/2, [self widthForString:_messagePModel.title fontSize:14 andHeight:21], 21);
    self.lineF = CGRectMake(0, CGRectGetMaxY(self.topBgF)+padding, CYScreanW-2*titleX, 0.5);
    self.contentF = CGRectMake(titleX, CGRectGetMaxY(self.lineF)+padding*2, CYScreanW-4*titleX, [self heightString:_messagePModel.content fontSize:14 andWidth:CYScreanW-4*titleX]);
    self.timeF = CGRectMake(titleX*2, CGRectGetMaxY(self.contentF)+padding*3, CYScreanW-2*titleX, 21);
    self.bgViewF = CGRectMake(titleX, titleY, CYScreanW-2*titleX, CGRectGetMaxY(self.timeF)+10-titleY);
    self.cellHeight = CGRectGetMaxY(self.bgViewF);
}
- (float) heightString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}
-(float) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.width;
}
@end
