//
//  ComBBSCellFrame.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/17.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ComBBSCellFrame.h"
#import "MJExtension.h"
#import "PriseDo.h"
#import "FollowNoteDO.h"
#import "FollowNoteCellFrame.h"
@interface ComBBSCellFrame()
{
    float commentTableHeight;
}
@end
@implementation ComBBSCellFrame

-(void)setComBBSModel:(comBBSModel *)comBBSModel
{
    _comBBSModel = comBBSModel;
    // 间隙
    CGFloat titleX = 8;
    CGFloat titleY = 8;
    commentTableHeight = 0;
    self.iconF = CGRectMake(CYScreanW * 0.02, (CYScreanH - 64) * 0.02, CYScreanW * 0.12, CYScreanW * 0.12);
    self.nameF = CGRectMake(CGRectGetMaxX(self.iconF)+titleY, (CYScreanH - 64) * 0.02, CYScreanW * 0.4, (CYScreanH-64)*0.04);

    float contentW = CYScreanW-CGRectGetMaxX(self.iconF)-titleX*2;
    float contentH = [self heightString:_comBBSModel.content fontSize:12 andWidth:contentW];
    self.contentF = CGRectMake(CGRectGetMaxX(self.iconF)+titleY,CGRectGetMaxY(self.nameF), contentW, contentH);
    
    float cellW = (CYScreanW-CGRectGetMaxX(self.iconF)-titleX*4)/3;
    NSArray *array = [_comBBSModel.imgAddress componentsSeparatedByString:@","];
    float picH = 0;
    if(array.count == 0){
        picH = 0;
    }else if (array.count<=2) {
        picH = cellW*1;
    }else if(array.count <=5){
        picH = cellW*2;
    }else if(array.count <=8){
        picH = cellW*3;
    }
    self.picF = CGRectMake(self.nameF.origin.x, CGRectGetMaxY(self.contentF)+titleY, contentW, picH);
    
    UIImage *popImage = [UIImage imageNamed:@"icon_community_message"];
    float timeW = [self widthForString:[CYSmallTools timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",_comBBSModel.gmtCreate]] fontSize:12 andHeight:popImage.size.height];
    self.timeF = CGRectMake(_nameF.origin.x, CGRectGetMaxY(self.picF)+titleY, timeW, popImage.size.height);
    float deleteW = [self widthForString:@"删除" fontSize:12 andHeight:popImage.size.height];
    self.deleteF = CGRectMake(CGRectGetMaxX(self.timeF), CGRectGetMaxY(self.picF)+titleY, deleteW+titleX*2, popImage.size.height);
    self.popF = CGRectMake(CYScreanW-titleX-popImage.size.width*2, CGRectGetMaxY(self.picF)+titleY, 2*popImage.size.width, popImage.size.height*2);
    
    UIImage *image = [UIImage imageNamed:@"icon_community_prise"];
    self.priseIvF = CGRectMake(0, 0, image.size.width, image.size.height);
    NSArray *priseArray = [PriseDo objectArrayWithKeyValuesArray:_comBBSModel.notePraiseDo];
    NSString *priseMixName = @"";
    NSLog(@"点赞数组%lu",(unsigned long)priseArray.count);
    for (PriseDo *priseDo in priseArray) {
        if ([priseDo isEqual:[priseArray lastObject]]) {
            priseMixName = [priseMixName  stringByAppendingString:[ActivityDetailsTools UTFTurnToStr:priseDo.praiserName]];
        }else{
            priseMixName = [[priseMixName stringByAppendingString:[ActivityDetailsTools UTFTurnToStr:priseDo.praiserName]]
                            stringByAppendingString:@","];
        }
    }
    float priseNameW = self.contentF.size.width - titleX- CGRectGetMaxX(self.priseIvF);
    float priseNameH = [self heightString:priseMixName fontSize:12 andWidth:priseNameW];
    self.priseNameF = CGRectMake(CGRectGetMaxX(self.priseIvF)+5,titleY/2,priseNameW,priseNameH);
    
    NSArray *commentArray = [FollowNoteDO objectArrayWithKeyValuesArray:_comBBSModel.followNoteDO];
    for(FollowNoteDO *followNote in commentArray) {
        FollowNoteCellFrame *noteFrame = [[FollowNoteCellFrame alloc] init];
        NSLog(@"cell的state%@",followNote.state);
        [noteFrame setFollowNoteDO:followNote];
        commentTableHeight = noteFrame.cellHeight+commentTableHeight;
    }
    if(commentArray.count == 0){
        NSArray *priseArray = [PriseDo objectArrayWithKeyValuesArray:_comBBSModel.followNoteDO];
        if (priseArray.count == 0) {
            self.priseBgF = CGRectMake(_nameF.origin.x, CGRectGetMaxY(self.timeF)+titleY, contentW, 0);
            self.commentTableF = CGRectMake(_nameF.origin.x, CGRectGetMaxY(self.priseBgF), self.contentF.size.width, 0);
            self.cellHeight = CGRectGetMaxY(self.timeF)+titleY;

        }else{
            self.priseBgF = CGRectMake(_nameF.origin.x, CGRectGetMaxY(self.timeF)+titleY, contentW, priseNameH+titleY);
            self.commentTableF = CGRectMake(_nameF.origin.x, CGRectGetMaxY(self.priseBgF), self.contentF.size.width, 0);

            self.cellHeight = CGRectGetMaxY(self.priseBgF)+titleY*2;
        }
    }else{
        NSArray *priseArray = [PriseDo objectArrayWithKeyValuesArray:_comBBSModel.followNoteDO];
        if (priseArray.count == 0) {
            self.priseBgF = CGRectMake(_nameF.origin.x, CGRectGetMaxY(self.timeF)+titleY, contentW, 0);
            self.commentTableF = CGRectMake(_nameF.origin.x, CGRectGetMaxY(self.contentF), self.contentF.size.width, commentTableHeight);

            self.cellHeight = CGRectGetMaxY(self.commentTableF)+titleY;
            
        }else{
            self.priseBgF = CGRectMake(_nameF.origin.x, CGRectGetMaxY(self.timeF)+titleY, contentW, priseNameH+titleY);

            self.commentTableF = CGRectMake(_nameF.origin.x, CGRectGetMaxY(self.priseBgF), self.contentF.size.width, commentTableHeight);
            
            self.cellHeight = CGRectGetMaxY(self.commentTableF)+titleY;
            
        }
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
