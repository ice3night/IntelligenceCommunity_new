//
//  ComplaintCellFrame.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/14.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ComplaintCellFrame.h"

@implementation ComplaintCellFrame
-(void)setComplaintModel:(ComplaintModel *)complaintModel
{
    _complaintModel = complaintModel;
    // 间隙
    CGFloat padding = 5;
    
    CGFloat titleX = 8;
    CGFloat titleY = 8;
    UIImage *image = [UIImage imageNamed:@"icon_me_complaint"];
    self.topBgF = CGRectMake(titleX, titleY, CYScreanW-2*titleX, (CYScreanH-64)*0.05);
    self.iconF = CGRectMake(titleX, ((CYScreanH-64)*0.05-image.size.height)/2, image.size.width, image.size.height);
    NSString *title = @"";
    if ([_complaintModel.category integerValue] == 1){
        title = @"房屋设施";
    }else if ([_complaintModel.category integerValue] == 2){
        title = @"公共设施";
    }else if([_complaintModel.category integerValue] == 3){
        title = @"服务评价";
    }
    self.titleF = CGRectMake(CGRectGetMaxX(_iconF)+titleX, ((CYScreanH-64)*0.05-21)/2, [self widthForString:title fontSize:14 andHeight:21], 21);
    NSString *status = @"";
    if([_complaintModel.status integerValue] == 0) {
        status = @"待处理";
    }else if([_complaintModel.status integerValue] == 1) {
        status = @"处理中";
    }else if([_complaintModel.status integerValue] == 2) {
        status = @"已处理";
    }else if([_complaintModel.status integerValue] ==3) {
        status = @"已取消";
    }
    float statusW = [self widthForString:status fontSize:14 andHeight:21];
    self.statusF = CGRectMake(CGRectGetMaxX(self.topBgF)-titleX*2-statusW, ((CYScreanH-64)*0.05-21)/2, statusW, 21);
    self.lineF = CGRectMake(0, CGRectGetMaxY(self.topBgF)+padding, CYScreanW-2*titleX, 0.5);
    self.contentF = CGRectMake(titleX, CGRectGetMaxY(self.lineF)+padding*2, CYScreanW-4*titleX, [self heightString:_complaintModel.reason fontSize:14 andWidth:CYScreanW-4*titleX]);
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
