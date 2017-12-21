//
//  CommunityCollectionCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "CommunityCollectionCell.h"
@interface CommunityCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
@implementation CommunityCollectionCell
-(void)setImgAddress:(NSString *)imgAddress
{
    _imgAddress = imgAddress;
    [self.image sd_setImageWithURL:[NSURL URLWithString:imgAddress]];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CommunityCollectionCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
@end
