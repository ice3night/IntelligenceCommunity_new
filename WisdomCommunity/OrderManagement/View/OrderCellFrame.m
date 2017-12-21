//
//  OrderCellFrame.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/16.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "OrderCellFrame.h"
#import "MJExtension.h"
#import "OrderItem.h"
@implementation OrderCellFrame
-(void)setOrderModel:(OrderMModel *)orderModel
{
    _orderModel = orderModel;
    // 间隙
    CGFloat padding = 5;
    
    CGFloat titleX = 8;
    CGFloat titleY = 8;
    self.topBgF = CGRectMake(0, 0, CYScreanW, (CYScreanH - 64) * 0.02);
    //头像
    self.headImageF = CGRectMake(CYScreanW * 0.02, (CYScreanH - 64) * 0.03, (CYScreanH - 64) * 0.12, (CYScreanH - 64) * 0.12);
    
    self.nameF = CGRectMake(CGRectGetMaxX(self.headImageF)+CYScreanW * 0.03, self.headImageF.origin.y, CYScreanW * 0.55, (CYScreanH - 64) * 0.04);
    
    //时间
    self.timeF = CGRectMake(CGRectGetMaxX(self.headImageF)+CYScreanW * 0.03, CGRectGetMaxY(self.nameF), CYScreanW * 0.55, (CYScreanH - 64) * 0.04);
    
    //价格
    self.priceF = CGRectMake(CYScreanW*0.8+5, self.headImageF.origin.y+(CYScreanH - 64) * 0.02, CYScreanW * 0.20, (CYScreanH - 64) * 0.04);
    
    //分割线
    self.lineF = CGRectMake(self.nameF.origin.x, CGRectGetMaxY(self.headImageF), CYScreanW-self.nameF.origin.x, 0.5);
    NSMutableArray *array = [OrderItem objectArrayWithKeyValuesArray:_orderModel.detailList];
    self.tableF = CGRectMake(self.lineF.origin.x, CGRectGetMaxY(self.lineF)+2, CYScreanW*0.95-(CYScreanH - 64) * 0.12, (CYScreanH - 64) * 0.08*array.count);
    self.cellHeight = CGRectGetMaxY(self.tableF);
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
