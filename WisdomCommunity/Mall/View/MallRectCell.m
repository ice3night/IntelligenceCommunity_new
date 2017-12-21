//
//  MallRectCell.m
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "MallRectCell.h"
#import "RatingBar.h"
@interface MallRectCell()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *evaluateTip;
@property (weak, nonatomic) IBOutlet UIImageView *shopIcon;

@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *proNum;
@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet RatingBar *ratingbar;
@end
@implementation MallRectCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"MallRectCell" owner:self options:nil];
        
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
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.tipLabel.textColor = CQColor(230,0,18, 1);
    self.shopName.textColor = CQColor(153,153,153, 1);
    self.evaluateTip.textColor = CQColor(153,153,153, 1);
    self.proNum.textColor = CQColor(153,153,153, 1);
    self.ratingbar.isIndicator = YES;
    [self.ratingbar setImageDeselected:@"icon_star_blank" halfSelected:nil fullSelected:@"icon_star_selected" andDelegate:nil];
    self.discount.textColor = CQColor(153,153,153, 1);
    self.discount.backgroundColor = CQColor(255,193,3, 1);
    self.discount.layer.cornerRadius = self.discount.frame.size.height/2;
    self.discount.layer.masksToBounds = YES;
}
-(void)setShop:(MallRecShop *)shop
{
    _shop = shop;
    NSLog(@"店铺头像%@",shop.shopName);
    [self.ratingbar displayRating:[shop.averageStar floatValue]];
    NSURL *url = [NSURL URLWithString:shop.imgBiao];
    [self.shopIcon sd_setImageWithURL:url];
    self.shopName.text = shop.shopName;
    self.proNum.text = [@"商品数量：" stringByAppendingString:[NSString stringWithFormat:@"%@",shop.productNum]];
//    [self.discount setTitle:shop.youHuiInfo];
}
@end
