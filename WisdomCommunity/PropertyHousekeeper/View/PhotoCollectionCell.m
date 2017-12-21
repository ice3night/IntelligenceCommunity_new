//
//  PhotoCollectionCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/10/29.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "PhotoCollectionCell.h"
@interface PhotoCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
@implementation PhotoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setImg:(UIImage *)img
{
    NSLog(@"图片来了");
    _img = img;
    [self.image setImage:img];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"PhotoCollectionCell" owner:self options:nil];
        
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
@end
