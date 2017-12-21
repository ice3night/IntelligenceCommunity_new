//
//  DetailProductHeaderFrame.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/13.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "DetailProductHeaderFrame.h"

@implementation DetailProductHeaderFrame
-(void)setDetailProductModel:(DetailProductModel *)detailProductModel
{
    _detailProductModel = detailProductModel;
    // 间隙
    CGFloat padding = 10;
    
    CGFloat titleX = 8;
    self.slideShowF = CGRectMake(0, 0, CYScreanW, CYScreanW);
    self.titleF = CGRectMake(titleX, CGRectGetMaxY(self.slideShowF)+padding, CYScreanW-2*titleX, [self heightString:_detailProductModel.name fontSize:16 andWidth:CYScreanW-2*titleX]);
    self.featureF = CGRectMake(titleX, CGRectGetMaxY(self.titleF)+padding*2, CYScreanW-2*titleX, [self heightString:_detailProductModel.content fontSize:14 andWidth:CYScreanW-2*titleX]);
    self.priceF = CGRectMake(titleX, CGRectGetMaxY(self.featureF)+padding, CYScreanW*0.4, 21);
    float salesCountW = [self widthForString:[@"已售" stringByAppendingString:[[NSString stringWithFormat:@"%@", _detailProductModel.successnum] stringByAppendingString:@"份"]] fontSize:14 andHeight:21];
    self.salesCountF = CGRectMake(CYScreanW-titleX-salesCountW, CGRectGetMaxY(self.featureF)+padding, salesCountW, 21);
    NSString *scoreStr = [@"购买此产品可以获得" stringByAppendingString:[[NSString stringWithFormat:@"%@",_detailProductModel.score] stringByAppendingString:@"积分"]];
    float scoreW = [self widthForString:scoreStr fontSize:12 andHeight:21];
    self.scoresF = CGRectMake(CYScreanW-scoreW-titleX, CGRectGetMaxY(self.salesCountF)+padding, scoreW, 40);
    self.numtipF = CGRectMake(titleX, CGRectGetMaxY(self.salesCountF)+padding, [self widthForString:@"数量" fontSize:12 andHeight:30], 40);
    self.salesF = CGRectMake(CGRectGetMaxX(self.numtipF)+ titleX, CGRectGetMaxY(self.salesCountF)+padding, 120, 40);
    self.shopParentViewF = CGRectMake(0, CGRectGetMaxY(self.salesF)+padding, CYScreanW, CYScreanH*0.20);

    self.shaopViewF = CGRectMake(0, CYScreanH*0.02, CYScreanW, CYScreanH*0.16);
    self.shopImageF = CGRectMake(titleX, CYScreanH*0.02, CYScreanH*0.12, CYScreanH*0.12);
    
    self.shopNameF = CGRectMake(CGRectGetMaxX(self.shopImageF)+padding, CYScreanH*0.04, CYScreanW*0.5, CYScreanH*0.04);
    self.evaluateTipF = CGRectMake(CGRectGetMaxX(self.shopImageF)+padding, CGRectGetMaxY(self.shopNameF), [self widthForString:@"评价：" fontSize:12 andHeight:CYScreanH*0.04], CYScreanH*0.04);
    self.evaluateF = CGRectMake(CGRectGetMaxX(self.evaluateTipF), CGRectGetMaxY(self.shopNameF), CYScreanW*0.25, CYScreanH*0.04);
    NSArray *imgArray = [_detailProductModel.imageStr componentsSeparatedByString:@","];
    float totalHeight = 0;
    if (imgArray.count > 0) {// 有配图
        self.frameArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < imgArray.count; i++) {
            NSString *maxStr = imgArray[i];
            NSArray *array = [maxStr componentsSeparatedByString:@"-"];
            CGFloat width = [array[1] floatValue];
            CGFloat height = [array[2] floatValue];
//            CGRect frame = CGRectMake(10,CGRectGetMaxY(self.contentF)+totalHeight,kScreenWidth-2*10,(kScreenWidth-2*10)*height/width);
            CGRect frame = CGRectMake(0,CGRectGetMaxY(self.shopParentViewF)+totalHeight,CYScreanW,CYScreanW*height/width);
            totalHeight = totalHeight+CYScreanW*height/width;
            [self.frameArray addObject:[NSValue valueWithCGRect:frame]];
        }
        self.detailF = CGRectMake(0, CGRectGetMaxY(self.shopParentViewF)+totalHeight + padding, CYScreanW, [self heightString:_detailProductModel.intro fontSize:14 andWidth:CYScreanW]);
        self.cellHeight = CGRectGetMaxY(self.detailF)+10;
    }else
    {
        self.detailF = CGRectMake(0, CGRectGetMaxY(self.shopParentViewF)+10, CYScreanW, [self heightString:_detailProductModel.description fontSize:14 andWidth:CYScreanW]);
        self.cellHeight = CGRectGetMaxY(self.detailF)+10;
    }
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
